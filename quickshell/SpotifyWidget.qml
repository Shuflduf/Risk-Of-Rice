import QtQuick
import Quickshell
import QtQuick.Effects
import Quickshell.Io
import Quickshell.Widgets
import QtQuick.Layouts

Item {
    id: root
    implicitHeight: 32
    implicitWidth: 32

    Image {
        id: sound_img
        anchors.fill: parent
        source: "spotify.png"
        smooth: false
    }

    MouseArea {
        id: mouse_area
        z: 100
        hoverEnabled: true
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (status_label.text == "Playing") {
                status_label.text = "Paused";
                playerctl_pause.startDetached();
            } else if (status_label.text == "Paused") {
                status_label.text = "Playing";
                playerctl_pause.startDetached();
            }
        }
    }

    Process {
        id: playerctl_pause
        command: ["playerctl", "play-pause"]
    }

    Process {
        id: playerctl_status
        command: ["playerctl", "status"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                if (this.text.length < 1) {
                    status_label.text = "Not Found";
                } else {
                    status_label.text = this.text.trim();
                }
            }
        }
    }
    Process {
        id: playerctl_metadata
        command: ["playerctl", "metadata"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                if (this.text.length < 1) {
                    popup.expanded = false;
                    return;
                }
                const lines = this.text.trim().split("\n");
                const trackInfo = {};
                for (const line of lines) {
                    const info = line.split(":")[1];
                    trackInfo[info.split(" ")[0]] = line.split(" ").filter(s => s).slice(2).join(" ");
                }
                content.trackInfo = trackInfo;
                popup.expanded = true;
                // console.log(JSON.stringify(trackInfo, null, 2));
            }
        }
    }

    PanelWindow {
        id: popup
        property bool expanded: false
        anchors.top: true
        anchors.right: true
        exclusionMode: ExclusionMode.Ignore
        margins.right: expanded ? 135 : 180
        margins.top: 40
        visible: mouse_area.containsMouse
        implicitWidth: expanded ? 250 : 150
        implicitHeight: 25 + content.implicitHeight
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
            to: 40
            duration: 300
            easing.type: Easing.OutBack
        }

        ClippingRectangle {
            id: content
            property var trackInfo: ({})
            anchors.fill: parent
            color: Colours.bg
            radius: 5
            implicitHeight: content_col.implicitHeight
            onActiveFocusChanged: () => console.log("active", activeFocus)

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
                id: content_col
                anchors.margins: 8
                anchors.fill: parent

                spacing: 8

                Text {
                    id: status_label
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 8
                    text: "0%"
                    font.pixelSize: 18
                    font.family: "RZpix"
                    font.bold: true
                    color: Colours.header
                }

                RowLayout {
                    visible: popup.expanded
                    spacing: 8
                    Item {
                        implicitHeight: 100
                        implicitWidth: 100

                        RectangularShadow {
                            anchors.fill: parent
                        }
                        ClippingRectangle {
                            anchors.fill: parent
                            radius: 10

                            Image {
                                anchors.fill: parent
                                source: content.trackInfo.artUrl
                            }
                        }
                    }
                    Item {

                        implicitHeight: 10
                        implicitWidth: 120
                        Layout.fillHeight: true
                        z: -1

                        Column {
                            spacing: 8
                            anchors.centerIn: parent

                            Text {
                                text: content.trackInfo.title
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.margins: 8
                                font.pixelSize: 12
                                font.bold: true
                                font.family: "RZpix"
                                color: Colours.textSelected
                            }
                            Text {
                                text: content.trackInfo.artist
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
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            playerctl_status.running = true;
            playerctl_metadata.running = true;
        }
    }
}
