import QtQuick
import Quickshell
import QtQuick.Effects
import Quickshell.Io
import Quickshell.Widgets

Item {
    id: root
    implicitHeight: 30
    implicitWidth: 30

    property var profileNames: {
        "power-saver": "Power Saver",
        "balanced": "Balanced",
        "performance": "Performance"
    }

    Image {
        id: battery_img
        anchors.fill: parent
        source: "battery1.png"
        smooth: false

        function updateImg(percent) {
            const imgs = ["battery1.png", "battery2.png", "battery3.png", "battery4.png", "battery5.png", "battery6.png", "battery7.png", "battery8.png", "battery9.png"];
            const index = Math.round(percent * (imgs.length - 1) / 100);
            source = imgs[index];
        }
    }
    Image {
        id: charging_indicator
        anchors.fill: parent
        source: "battery_charging.png"
        smooth: false
    }
    Image {
        id: warning_indicator
        anchors.fill: parent
        source: "battery_warning.png"
        smooth: false
    }

    MouseArea {
        id: mouse_area
        hoverEnabled: true
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: profile_proc_cycle.running = true
    }

    PanelWindow {
        id: popup
        anchors.top: true
        anchors.right: true
        exclusionMode: ExclusionMode.Ignore
        // anchors.
        margins.top: 35
        visible: mouse_area.containsMouse
        implicitWidth: 150
        implicitHeight: 85
        // implicitHeight: items.implicitHeight + 14
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
            // anchors.horizontalCenterOffset
            // anchors.verticalCenterOffset: 20
            // anchors.topMargin: 30
            border {
                color: Colours.border
                width: 4
            }

            Column {
                anchors.margins: 8
                anchors.fill: parent

                spacing: 8

                Text {
                    id: percent_label
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 8
                    text: "0%"
                    font.pixelSize: 18
                    font.family: "RZpix"
                    font.bold: true
                    color: Colours.header
                }
                Text {
                    id: est_time
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Full in 12 Years"
                    font.pixelSize: 12
                    font.family: "RZpix"
                    color: Colours.textSelected
                    // height: 24
                }
                Text {
                    id: bat_profile
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Loading"
                    font.pixelSize: 12
                    font.family: "RZpix"
                    font.bold: true
                    color: Colours.textSelected
                }
            }
        }
    }

    Process {
        id: profile_proc_cycle

        property string nextProfile
        Component.onCompleted: {
            bat_profile.textChanged.connect(() => {
                switch (bat_profile.text) {
                case "Power Saver":
                    nextProfile = "balanced";
                    break;
                case "Balanced":
                    nextProfile = "performance";
                    break;
                case "Performance":
                    nextProfile = "power-saver";
                    break;
                default:
                    nextProfile = "balanced";
                }
            });
        }
        command: ["powerprofilesctl", "set", nextProfile]

        stdout: StdioCollector {
            onStreamFinished: {
                bat_profile.text = root.profileNames[profile_proc_cycle.nextProfile];
            }
        }
    }

    Process {
        id: profile_proc_get
        command: ["powerprofilesctl", "get"]
        stdout: StdioCollector {
            onStreamFinished: {
                bat_profile.text = root.profileNames[this.text.trim()];
            }
        }
    }

    Process {
        id: battery_proc

        command: ["upower", "-i", "/org/freedesktop/UPower/devices/battery_BAT0"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const lines = this.text.split('\n');

                lines.forEach(line => {
                    const trimmed = line.trim();

                    if (trimmed.startsWith('percentage:')) {
                        const bat_percent = trimmed.split(':')[1].trim().slice(0, -1);
                        percent_label.text = `${bat_percent}%`;
                        warning_indicator.visible = bat_percent < 10;
                        battery_img.updateImg(bat_percent);
                    } else if (trimmed.startsWith('state:')) {
                        const state = trimmed.split(':')[1].trim();
                        charging_indicator.visible = state == "charging";
                    } else if (trimmed.startsWith('time to empty:')) {
                        const time = trimmed.split(':').slice(1).join(':').trim();
                        est_time.text = `Empty in ${time}`;
                    } else if (trimmed.startsWith('time to full:')) {
                        const time = trimmed.split(':').slice(1).join(':').trim();
                        est_time.text = `Full in ${time}`;
                    }
                });
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            profile_proc_get.running = true;
            battery_proc.running = true;
        }
    }
}
