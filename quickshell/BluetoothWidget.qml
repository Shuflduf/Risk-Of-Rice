import QtQuick
import Quickshell
import QtQuick.Effects
import Quickshell.Io
import Quickshell.Widgets

Item {
    id: root
    implicitHeight: 32
    implicitWidth: 32

    Image {
        id: wifi_img
        anchors.fill: parent
        source: "bluetooth.png"
        smooth: false
    }

    MouseArea {
        id: mouse_area
        hoverEnabled: true
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: open_bluetui.running = true
    }

    Process {
        id: open_bluetui
        command: ["hyprctl", "dispatch", "exec", "[float] ghostty -e bluetui"]
    }

    Process {
        id: update_status_proc
        command: ["bluetoothctl", "devices", "Connected"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                popup.devices = [];
                for (const line of this.text.split("\n")) {
                    const parts = line.split(" ");
                    if (parts.length < 3)
                        break;
                    popup.devices = [...popup.devices, parts.slice(2).join(" ")];
                }
                if (popup.devices.length < 1) {
                    popup.devices = ["No Devices Connected"];
                }
            }
        }
    }

    PanelWindow {
        id: popup
        anchors.top: true
        anchors.right: true
        exclusionMode: ExclusionMode.Ignore
        // anchors.
        margins.right: 65
        margins.top: 35
        visible: mouse_area.containsMouse
        implicitWidth: 150
        implicitHeight: 30 + content.implicitHeight
        color: "transparent"

        property var devices: []

        onVisibleChanged: () => {
            if (popup.visible)
                move_anim.start();
        }
        PropertyAnimation {
            id: move_anim
            target: popup
            property: "margins.top"
            from: 60
            to: 35
            duration: 300
            easing.type: Easing.OutBack
        }

        ClippingRectangle {
            id: battery_info
            anchors.fill: parent
            color: Colours.bg
            radius: 5

            RectangularShadow {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                implicitHeight: 2
                blur: 2
            }
            border {
                color: Colours.border
                width: 4
            }

            Column {
                id: content
                anchors.margins: 8
                anchors.fill: parent

                spacing: 8

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 8
                    text: "Devices"
                    font.pixelSize: 18
                    font.family: "RZpix"
                    font.bold: true
                    color: Colours.header
                }

                Repeater {
                    model: popup.devices
                    // Component.onCompleted: popup.devicesChanged.connect(() => console.log(popup.devices))
                    Text {
                        required property string modelData
                        text: modelData
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.margins: 8
                        font.pixelSize: 12
                        font.family: "RZpix"
                        color: Colours.textSelected
                    }
                }
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            update_status_proc.running = true;
        }
    }
}
