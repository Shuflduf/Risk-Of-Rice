import QtQuick
import Quickshell
import QtQuick.Effects
import Quickshell.Io
import Quickshell.Widgets

Item {
    id: root
    implicitHeight: 32
    implicitWidth: 32

    property bool popupOpen: false

    Component.onCompleted: Wallpapers.doLiterallyFuckingNothing()

    Image {
        id: battery_img
        anchors.fill: parent
        source: "settings.png"
        smooth: false
    }

    MouseArea {
        id: mouse_area
        hoverEnabled: true
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            root.popupOpen = !root.popupOpen;
            if (root.popupOpen) {
                content.forceActiveFocus();
            }
        }
    }

    PanelWindow {
        id: popup
        anchors.top: true
        anchors.right: true
        exclusionMode: ExclusionMode.Ignore
        focusable: true
        margins.top: 35
        visible: root.popupOpen
        implicitWidth: 150
        implicitHeight: 85
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
            id: content
            anchors.fill: parent
            color: Colours.bg
            radius: 5
            onActiveFocusChanged: {
                if (!activeFocus && root.popupOpen) {
                    root.popupOpen = false;
                }
            }

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
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 8
                    text: "Settings"
                    font.pixelSize: 18
                    font.family: "RZpix"
                    font.bold: true
                    color: Colours.header
                }
                Rectangle {
                    implicitHeight: 30
                    implicitWidth: 130
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: wallpaper_mouse_area.containsMouse ? Colours.bgSelected : Colours.secondaryBg
                    radius: 3

                    border {
                        width: 2
                        color: Colours.border
                    }

                    function cycleWallpapers() {
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "Wallpaper"
                        font.pixelSize: 12
                        font.family: "RZpix"
                        anchors.margins: 4
                        color: Colours.textSelected
                    }

                    MouseArea {
                        id: wallpaper_mouse_area
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onClicked: console.log(Wallpapers.wallpapers)
                    }
                }
            }
        }
    }
}
