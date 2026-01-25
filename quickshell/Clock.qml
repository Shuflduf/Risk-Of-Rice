import QtQuick.Layouts
import QtQuick
import Quickshell
import Quickshell.Io
import QtQuick.Effects
import Quickshell.Widgets

Item {
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    implicitWidth: 100
    implicitHeight: 34
    anchors.margins: 2

    ClippingRectangle {
        anchors.fill: parent
        radius: 6
        color: Colours.bg

        border {
            width: 4
            color: Colours.border
        }

        RectangularShadow {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            implicitHeight: 2
            blur: 2
        }
        RowLayout {

            // anchors.horizontalCenter: parent.horizontalCenter
            anchors.centerIn: parent
            spacing: 2
            Text {
                id: hour_label
                text: "00"
                color: Colours.menu
                font.pixelSize: 18
                font.family: "RZpix"
                font.bold: true
            }
            Text {
                text: ":"
                color: Colours.menu
                font.pixelSize: 12
                font.family: "RZpix"
            }
            Text {
                id: minute_label
                text: "00 AM"
                color: Colours.menu
                font.pixelSize: 12
                font.family: "RZpix"
            }
        }

        MouseArea {
            id: mouse_area
            hoverEnabled: true
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
        }

        PanelWindow {
            id: calendar_popup
            anchors.top: true
            exclusionMode: ExclusionMode.Ignore
            // anchors.
            margins.top: 40
            visible: mouse_area.containsMouse
            implicitWidth: 150
            implicitHeight: items.implicitHeight + 14
            color: "transparent"

            onVisibleChanged: () => {
                if (calendar_popup.visible)
                    move_anim.start();
            }

            PropertyAnimation {
                id: move_anim
                target: calendar_popup
                property: "margins.top"
                from: 60
                to: 40
                duration: 300
                easing.type: Easing.OutBack
            }

            // border
            ClippingRectangle {
                id: day_info
                anchors.fill: parent
                color: Colours.bg

                RectangularShadow {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    implicitHeight: 2
                    blur: 2
                }
                // anchors.horizontalCenterOffset
                // anchors.verticalCenterOffset: 20
                // anchors.topMargin: 30
                border {
                    color: Colours.border
                    width: 4
                }
                radius: 5

                Column {
                    id: items
                    anchors.margins: 8
                    anchors.fill: parent

                    spacing: 8

                    Text {
                        id: weekday_label
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.margins: 8
                        text: "Sunday"
                        font.pixelSize: 18
                        font.family: "RZpix"
                        font.bold: true
                        color: Colours.header
                    }
                    Text {
                        id: day_label
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "01 January"
                        font.pixelSize: 12
                        font.family: "RZpix"
                        color: Colours.textSelected
                        height: 24
                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Upcoming"
                        font.pixelSize: 14
                        font.family: "RZpix"
                        font.bold: true
                        visible: false
                        // anchors.verticalCenter: parent.verticalCenter
                        // anchors.topMargin: 8
                    }
                    Column {
                        visible: false
                        Repeater {
                            // model: ["Do thing", "Other thing"]
                            model: [
                                {
                                    "time": "1:00 PM",
                                    "event": "Do Thing"
                                },
                                {
                                    "time": "3:00 PM",
                                    "event": "Other Thing AOJDKMSIUDNCJCSUISCJSOIJOIC CIJSOIJ"
                                },
                                {
                                    "time": "3:00 PM",
                                    "event": "Other Thing"
                                },
                                {
                                    "time": "3:00 PM",
                                    "event": "Other Thing"
                                },
                                {
                                    "time": "3:00 PM",
                                    "event": "Other Thing"
                                },
                                {
                                    "time": "3:00 PM",
                                    "event": "Other Thing"
                                },
                                {
                                    "time": "3:00 PM",
                                    "event": "Other Thing"
                                },
                                {
                                    "time": "3:00 PM",
                                    "event": "Other Thing"
                                },
                                {
                                    "time": "3:00 PM",
                                    "event": "Other Thing"
                                },
                                {
                                    "time": "3:00 PM",
                                    "event": "Other Thing"
                                },
                            ]
                            Row {
                                id: calendar_item
                                required property var modelData
                                spacing: 4
                                Text {
                                    text: calendar_item.modelData.event
                                    font.pixelSize: 12
                                    font.family: "RZpix"
                                    // font.bold: true
                                }
                                Text {
                                    text: "-"
                                    font.pixelSize: 12
                                    font.family: "RZpix"
                                }
                                Text {
                                    // implicitWidth: 40
                                    text: calendar_item.modelData.time
                                    font.pixelSize: 12
                                    font.family: "RZpix"
                                }
                            }
                        }
                    }
                }
            }
        }

        Process {
            id: dateProc

            command: ["date", "+%I %M %p %d %B %A"]
            running: true

            stdout: StdioCollector {
                onStreamFinished: {
                    const parts = this.text.trim().split(" ");
                    hour_label.text = parts[0];
                    minute_label.text = `${parts[1]} ${parts[2]}`;
                    day_label.text = `${parts[3]} ${parts[4]}`;

                    weekday_label.text = parts[5];
                }
            }
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: dateProc.running = true
        }
    }
    RectangularShadow {
        anchors.fill: parent
        // spread: 1
        z: -10
    }
}
