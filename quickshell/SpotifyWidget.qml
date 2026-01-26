import QtQuick
import Quickshell
import QtQuick.Effects
import Quickshell.Io
import Quickshell.Widgets
import QtQuick.Layouts

Item {
    id: root
    implicitHeight: 30
    implicitWidth: 30

    Image {
        id: sound_img
        anchors.fill: parent
        source: "spotify.png"
        smooth: false

        // function updateImg(percent) {
        //     const imgs = ["sound1.png", "sound2.png", "sound3.png"];
        //     const index = Math.round(percent * (imgs.length - 1) / 100);
        //     source = imgs[index];
        // }
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

    // Process {
    //     id: open_pulsemixer
    //     command: ["hyprctl", "dispatch", "exec", "[float] ghostty -e pulsemixer"]
    // }

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
                // console.log(this.text);
                if (this.text.length < 1) {
                    status_label.text = "Not Found";
                } else {
                    status_label.text = this.text.trim();
                }
                // const lines = this.text.trim().split("\n");
                // const trackInfo = {};
                // for (const line of lines) {
                //     const info = line.split(":")[1];
                //     trackInfo[info.split(" ")[0]] = line.split(" ").filter(s => s).slice(2)[0];
                // }
                // console.log(JSON.stringify(trackInfo, null, 2));
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
                    return;
                }
                // console.log(this.text.length);
                // console.log("A", this.text);
                const lines = this.text.trim().split("\n");
                const trackInfo = {};
                for (const line of lines) {
                    const info = line.split(":")[1];
                    trackInfo[info.split(" ")[0]] = line.split(" ").filter(s => s).slice(2).join(" ");
                }
                content.trackInfo = trackInfo;
                console.log(JSON.stringify(trackInfo, null, 2));
            }
        }
    }

    // Process {
    //     id: update_playerctl_info
    //     command: ["playerctl", "metadata"]
    //     running: true
    //     stdout: StdioCollector {
    //         onStreamFinished: {
    //             const lines = this.text.trim().split("\n");
    //             const trackInfo = {};
    //             for (const line of lines) {
    //                 const info = line.split(":")[1];
    //                 trackInfo[info.split(" ")[0]] = line.split(" ").filter(s => s).slice(2)[0];
    //             }
    //             console.log(JSON.stringify(trackInfo, null, 2));
    //         }
    //     }
    // }

    PanelWindow {
        id: popup

        // property bool expanded: false
        // focusable: true
        anchors.top: true
        anchors.right: true
        exclusionMode: ExclusionMode.Ignore
        // anchors.
        // anchors.
        margins.right: 95
        margins.top: 40
        visible: mouse_area.containsMouse
        implicitWidth: 250
        implicitHeight: 25 + content.implicitHeight
        color: "transparent"

        onVisibleChanged: () => {
        // console.log(visible);
        // if (visible) {
        // popup.margins.top = 100;
        // move_anim.start();
        // }
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
            // anchors.verticalCenterOffset: 200
            // x: 200
            onActiveFocusChanged: () => console.log("active", activeFocus)
            // focus: true
            // onFocusChanged: console.log("focus", focus)

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
                // implicitHeight: 50
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
                    spacing: 8
                    // implicitHeight: 50
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
                                // anchors {
                                //     top: parent.top
                                //     left: parent.left
                                //     bottom: parent.bottom
                                // }
                                // height: 100
                                // width: 100
                                // implicitHeight: 40
                                source: content.trackInfo.artUrl
                                // radius
                            }
                        }
                    }
                    Item {

                        implicitHeight: 10
                        implicitWidth: 120
                        // anchors
                        // Layout.fillWidth: true
                        Layout.fillHeight: true
                        z: -1
                        // color: "red"

                        Column {
                            spacing: 8
                            anchors.centerIn: parent
                            // anchors.fill: parent
                            // anchors.verticalCenter: parent.verticalCenter
                            // anchors.horizontalCenter
                            // anchors.right: parent.right
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
