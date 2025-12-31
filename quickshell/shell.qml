import Quickshell
import Quickshell.Hyprland
import QtQuick

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 30
  // implicitWidth: 30
  //
  Workspaces {}

  // Text {
  //   // give the text an ID we can refer to elsewhere in the file
  //   id: clock
  //   // rotation: 270

  //   anchors.centerIn: parent
  //   text: Hyprland.workspaces.values[2].name
  // }
}
