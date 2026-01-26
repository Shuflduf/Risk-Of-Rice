import QtQuick
import Quickshell
import QtQuick.Effects
import Quickshell.Io
import Quickshell.Widgets

Item {
    id: root
    implicitHeight: 30
    implicitWidth: 30

    Image {
        id: wifi_img
        anchors.fill: parent
        source: "wifi3.png"
        smooth: false

        function updateImg(percent) {
            const imgs = ["wifi1.png", "wifi2.png", "wifi3.png"];
            const index = Math.round(percent * (imgs.length - 1) / 100);
            source = imgs[index];
        }
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
                        wifi_img.updateImg(parseInt(parts[2]));
                        return;
                    }
                }
                const wifiErrImg = "wifi4.png";
                wifi_img.source = wifiErrImg;

                // wifi_img. = root.profileNames[profile_proc_cycle.nextProfile];
            }
        }
    }
}
