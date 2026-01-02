import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts

RowLayout {
    // padding: 80
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left
    spacing: 4
    // anchors.margins: 8
    Repeater {
        model: Hyprland.workspaces
        Rectangle {
            id: workspace_button
            required property HyprlandWorkspace modelData
            // color: "#FF0000"
            implicitWidth: 30
            implicitHeight: 30
            radius: 4
            border {
                color: "#494A5B"
                width: 3
            }
            // border: 4
            // padd
            // width: 10
            color: modelData.focused ? "#476894" : "#3B3542"

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

                MouseArea {
                    anchors.fill: parent
                    onClicked: workspace_button.modelData.activate()
                }
            }
        }
    }
}
