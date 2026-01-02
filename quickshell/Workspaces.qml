import QtQuick
import QtQuick.Effects
import Quickshell.Hyprland
import QtQuick.Layouts
import Quickshell.Widgets

RowLayout {
    // padding: 80
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left
    spacing: 4
    // anchors.margins: 8
    Repeater {
        model: Hyprland.workspaces
        Item {
            id: workspace_button
            required property HyprlandWorkspace modelData

            implicitWidth: 30
            implicitHeight: 30

            RectangularShadow {
                anchors.fill: parent
                offset: Qt.vector2d(0.0, 5.0)
                spread: 1
                color: Qt.rgba(0.0, 0.0, 0.0, 0.7)
            }
            Rectangle {
                color: "#494A5B"
                radius: 4
                anchors.fill: parent
            }
            ClippingRectangle {
                anchors.margins: 3
                anchors.fill: parent
                // padding

                radius: 4
                color: workspace_button.modelData.focused ? "#476894" : "#3B3542"
                // color: "transparent"
                width: 26
                height: 26

                RectangularShadow {
                    offset: Qt.vector2d(-5.0, -5.0)
                    width: 30
                    height: 8
                    blur: 1
                    color: "#1A1A1A"
                    opacity: 100.0
                    // spread: 10
                }
                Text {
                    anchors.centerIn: parent
                    text: workspace_button.modelData.name
                    // padding: 8
                    color: workspace_button.modelData.focused ? "#FFFFFF" : "#A5ACB5"

                    font {
                        pixelSize: 14
                        // bold: true
                    }

                    // anchors.: 8

                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: workspace_button.modelData.activate()
            }
        }
    }
}
