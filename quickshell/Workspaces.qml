import QtQuick
import QtQuick.Effects
import Quickshell.Hyprland
import QtQuick.Layouts
import Quickshell.Widgets

RowLayout {
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left
    spacing: 2

    // Component.onCompleted: {
    //     Hyprland.rawEvent.connect(event => console.log(event.name));
    // }

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
                anchors.margins: 1
            }
            ClippingRectangle {
                anchors.margins: 4
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
                    opacity: 0.5
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
            Image {
                id: select
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                // onBaselineOffsetChanged
                // x: 20
                // y: 20
                height: 30
                width: 30
                visible: workspace_button.modelData.focused
                Component.onCompleted: workspace_button.modelData.focusedChanged.connect(anim.start)

                PropertyAnimation {
                    id: anim
                    target: select
                    properties: "width,height"
                    from: 50
                    to: 30
                    duration: 200
                    easing.type: Easing.OutBack
                }
                // anchors.fill: parent
                source: "selection.svg"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: workspace_button.modelData.activate()
            }
        }
    }
}
