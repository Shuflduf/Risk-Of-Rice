//@ pragma UseQApplication

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    color: "transparent"
    implicitHeight: 38
    Bar {}
    // implicitWidth: 30
    //

    // Text {
    //   // give the text an ID we can refer to elsewhere in the file
    //   id: clock
    //   // rotation: 270

    //   anchors.centerIn: parent
    //   text: Hyprland.workspaces.values[2].name
    // }
}
