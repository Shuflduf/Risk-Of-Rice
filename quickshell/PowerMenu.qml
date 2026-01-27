pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property var actions: [
        {
            "name": "Lock",
            "command": "hyprlock"
        },
        {
            "name": "Power Off",
            "command": "shutdown now"
        },
        {
            "name": "Reboot",
            "command": "reboot"
        },
        {
            "name": "Sleep",
            "command": "systemctl suspend"
        },
        {
            "name": "Sign Out",
            "command": "hyprshutdown"
        },
    ]

    function show() {
        menu.visible = true;
        move_anim.start();
    }
    PanelWindow {
        id: menu
        property real buttonHeight: 30
        anchors {
            top: true
            right: true
        }
        exclusionMode: ExclusionMode.Ignore
        focusable: true
        visible: false
        implicitWidth: buttons.implicitWidth
        implicitHeight: (buttonHeight + 20) * (root.actions.length)
        color: "transparent"
        margins {
            top: 38
            right: 5
        }
        // Component.onCompleted: console.log(root.actions.length)

        Column {
            id: buttons
            spacing: 20
            anchors.fill: parent
            focus: true
            onActiveFocusChanged: () => {
                // console
                if (!activeFocus)
                    menu.visible = false;
            }

            PropertyAnimation {
                id: move_anim
                target: buttons
                property: "spacing"
                from: 20
                to: 5
                duration: 300
                easing.type: Easing.OutBack
            }

            Repeater {
                model: root.actions

                Rectangle {
                    id: button
                    property bool hovered: false
                    required property var modelData
                    required property int index
                    implicitHeight: menu.buttonHeight
                    implicitWidth: 200
                    border {
                        width: 2
                        color: Colours.border
                    }
                    color: mouse_area.containsMouse ? Colours.secondaryBg : Colours.bg
                    radius: 3
                    Text {
                        anchors.centerIn: parent
                        text: button.modelData.name
                        color: mouse_area.containsMouse ? Colours.textSelected : Colours.textUnselected
                        font.family: "RZPix"
                    }
                    Behavior on color {
                        ColorAnimation {
                            duration: 50
                        }
                    }
                    MouseArea {
                        id: mouse_area
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: process.startDetached()
                        hoverEnabled: true
                    }

                    Process {
                        id: process
                        command: button.modelData.command.split(" ")
                    }
                }
            }
        }
        // visible:
    }
}
