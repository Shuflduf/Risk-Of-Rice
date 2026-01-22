pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property var actions: [
        {
            "name": "Power Off",
            "command": "sudo shutdown -h now"
        },
        {
            "name": "Sleep",
            "command": "sudo systemctl suspend"
        },
        {
            "name": "Sign Out",
            "command": "hyprctl dispatch exit"
        },
        {
            "name": "Lock",
            "command": "hyprlock"
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
                    required property var modelData
                    required property int index
                    // anchors.topMargin: 10
                    // y: 20
                    implicitHeight: menu.buttonHeight
                    implicitWidth: 200
                    color: "#101117"
                    radius: 3

                    Rectangle {
                        // id: coloured_part
                        property bool hovered: false
                        anchors {
                            leftMargin: 3
                            rightMargin: 3
                            topMargin: 1
                            bottomMargin: 3
                        }
                        anchors.fill: parent
                        color: mouse_area.containsMouse ? "#2D6171" : "#2A2D42"
                        radius: 3
                        Text {
                            anchors.centerIn: parent
                            text: button.modelData.name
                            color: "#FFFFFF"
                            font.family: "RZPix"
                        }
                        Behavior on color {
                            ColorAnimation {
                                duration: 75
                            }
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
