import QtQuick.Layouts
import QtQuick
import Quickshell
import Quickshell.Io

Rectangle {
    anchors.horizontalCenter: parent.horizontalCenter
    // anchors.top: parent.top
    // anchors.right: parent.right
    implicitHeight: 38
    implicitWidth: 100
    radius: 8
    color: "#494A5B"

    Process {
        id: dateProc

        command: ["date", "+%I %M %p %d %B %Y %A"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const parts = this.text.trim().split(" ");
                hour_label.text = parts[0];
                minute_label.text = `${parts[1]} ${parts[2]}`;
                day_label.text = `${parts[3]} ${parts[4]}`;

                weekday_label.text = parts[6];
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }

    Rectangle {
        anchors.margins: 5
        anchors.fill: parent
        radius: 8
        color: "#151619"
        Row {

            // anchors.horizontalCenter: parent.horizontalCenter
            anchors.centerIn: parent
            spacing: 2
            Text {
                id: hour_label
                anchors.verticalCenter: parent.verticalCenter
                text: "00"
                color: "#C0C0C0"
                font.pixelSize: 18
                font.family: "RZpix"
                font.bold: true
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: ":"
                color: "#C0C0C0"
                font.pixelSize: 12
                font.family: "RZpix"
            }
            Text {
                id: minute_label
                anchors.verticalCenter: parent.verticalCenter
                text: "00 AM"
                color: "#C0C0C0"
                font.pixelSize: 12
                font.family: "RZpix"
            }
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
        margins.top: 38
        visible: mouse_area.containsMouse
        implicitWidth: 150
        implicitHeight: items.implicitHeight + 14
        color: "transparent"
        // border
        Rectangle {
            anchors.fill: parent
            color: "#292B2D"
            border {
                color: "#202224"
                width: 2
            }
            radius: 5
        }

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
                color: "#E6CA76"
            }
            Text {
                id: day_label
                anchors.horizontalCenter: parent.horizontalCenter
                text: "01 January"
                font.pixelSize: 12
                font.family: "RZpix"
                color: "white"
                height: 18
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
