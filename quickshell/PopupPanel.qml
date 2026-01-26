import QtQuick
import Quickshell
import QtQuick.Effects
import Quickshell.Io
import Quickshell.Widgets

PanelWindow {
    id: popup
    property MouseArea mouse_area
    default property var children
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
