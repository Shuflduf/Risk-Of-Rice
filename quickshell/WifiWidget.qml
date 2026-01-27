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
        source: "wifi3.png"
        smooth: false

        function updateImg(percent) {
            // lmao
            const imgs = ["wifi1.png", "wifi2.png", "wifi3.png", "wifi3.png"];
            const index = Math.round(percent * (imgs.length - 1) / 100);
            source = imgs[index];
        }
    }

    MouseArea {
        id: mouse_area
        hoverEnabled: true
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: open_impala.running = true
    }

    Process {
        id: open_impala
        command: ["hyprctl", "dispatch", "exec", "[float] ghostty -e impala"]
    }

    Process {
        id: update_status_proc
        command: ["nmcli", "-t", "-f", "ACTIVE,SSID,SIGNAL", "dev", "wifi"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                for (const line of this.text.split("\n")) {
                    if (line.startsWith("yes")) {
                        const parts = line.split(":");
                        const strength = parseInt(parts[2]);
                        wifi_img.updateImg(strength);
                        network_label.text = parts[1];
                        strength_label.text = `${strength}%`;
                        return;
                    }
                }
                const wifiErrImg = "wifi4.png";
                wifi_img.source = wifiErrImg;
            }
        }
    }

    PanelWindow {
        id: popup
        anchors.top: true
        anchors.right: true
        exclusionMode: ExclusionMode.Ignore
        // anchors.
        margins.right: 20
        margins.top: 35
        visible: mouse_area.containsMouse
        implicitWidth: 150
        implicitHeight: 65
        color: "transparent"

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
                anchors.margins: 8
                anchors.fill: parent

                spacing: 8

                Text {
                    id: network_label
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 8
                    text: "TELUS"
                    font.pixelSize: 18
                    font.family: "RZpix"
                    font.bold: true
                    color: Colours.header
                }
                Text {
                    id: strength_label
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "0%"
                    font.pixelSize: 12
                    font.family: "RZpix"
                    color: Colours.textSelected
                    // height: 24
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
