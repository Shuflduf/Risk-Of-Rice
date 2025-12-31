import Quickshell
import Quickshell.Hyprland
import Quickshell.Io // for Process
import QtQuick

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 30
  // implicitWidth: 30

  Text {
    // give the text an ID we can refer to elsewhere in the file
    id: clock
    // rotation: 270

    anchors.centerIn: parent
    text: Hyprland.workspaces.values[2].name
  }
}
