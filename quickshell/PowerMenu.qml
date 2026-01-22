pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

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
    }
    PanelWindow {
        id: menu
        anchors {
            top: true
            right: true
        }
        exclusionMode: ExclusionMode.Ignore
        focusable: true
        visible: false
        implicitWidth: buttons.implicitWidth
        implicitHeight: buttons.implicitHeight
        color: "transparent"

        ColumnLayout {
            id: buttons
            spacing: 5
            anchors.fill: parent
            focus: true
            onActiveFocusChanged: () => {
                if (!activeFocus)
                    menu.visible = false;
            }

            Repeater {
                model: root.actions
                Rectangle {
                    id: button
                    required property var modelData
                    required property int index
                    implicitHeight: 30
                    implicitWidth: 200
                    color: "#101117"
                    radius: 3
                    Component.onCompleted: {
                        menu.visibleChanged.connect(spawn);
                    }
                    // root.onVisibleChanged: () => {}

                    function spawn() {
                        if (!menu.visible) {
                            return;
                        }
                        console.log(index);
                    }

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
