import QtQuick
import Quickshell
import Quickshell.Hyprland

Row {
    anchors.verticalCenter: parent.verticalCenter
    Repeater {
        model: Hyprland.workspaces
        Text {
            required property HyprlandWorkspace modelData
            text: "fuck" + modelData.name
        }
    }
}
