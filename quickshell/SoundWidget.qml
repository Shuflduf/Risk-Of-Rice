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
        id: sound_img
        anchors.fill: parent
        source: "sound3.png"
        smooth: false

        function updateImg(percent) {
            const imgs = ["sound1.png", "sound2.png", "sound3.png"];
            const index = Math.round(percent * (imgs.length - 1) / 100);
            source = imgs[index];
        }
    }
    Image {
        id: mute_img
        anchors.fill: parent
        source: "sound_mute.png"
        smooth: false
    }

    MouseArea {
        id: mouse_area
        hoverEnabled: true
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: open_pulsemixer.running = true
    }

    Process {
        id: open_pulsemixer
        command: ["hyprctl", "dispatch", "exec", "[float] ghostty -e pulsemixer"]
    }

    Process {
        id: update_status_proc
        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const parts = this.text.trim().split(" ");
                const volume = parseInt(parts[1].slice(2));
                // console.log(volume);
                sound_img.updateImg(volume);
                mute_img.visible = parts.length >= 3 && parts[2] == "[MUTED]";
                volume_label.text = `${volume}%`;
            }
        }
    }

    Process {
        id: update_playerctl_info
        command: ["playerctl", "metadata"]
    }

    PanelWindow {
        id: popup
        anchors.top: true
        anchors.right: true
        exclusionMode: ExclusionMode.Ignore
        // anchors.
        margins.right: 85
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
                    id: volume_label
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 8
                    text: "0%"
                    font.pixelSize: 18
                    font.family: "RZpix"
                    font.bold: true
                    color: Colours.header
                }
            }
        }
    }

    Timer {
        interval: 300
        running: true
        repeat: true
        onTriggered: {
            update_status_proc.running = true;
        }
    }
}
