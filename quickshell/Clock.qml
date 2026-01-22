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

        command: ["date", "-Iminutes"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                // console.log(this.text.trim());
                const date = new Date(this.text.trim());
                hour_label.text = (date.getHours() % 12).toString().padStart(2, "0");
                const minStr = date.getMinutes().toString().padStart(2, "0");
                const amOrPm = (date.getHours() <= 12) ? "AM" : "PM";
                minute_label.text = `${minStr} ${amOrPm}`;
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
    }
}
