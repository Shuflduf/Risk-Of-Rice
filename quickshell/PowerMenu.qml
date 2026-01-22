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
                    color: "red"
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

                    Text {
                        anchors.centerIn: parent
                        text: button.modelData.name
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: process.startDetached()
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
