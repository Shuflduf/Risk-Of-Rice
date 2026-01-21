pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    function show() {
        menu.visible = true;
    }
    PanelWindow {
        id: menu
        anchors {
            top: true
            right: true
        }
        exclusionMode: ExclusionMode.Ignore
        focusable: true
        visible: false
        // visible: power_button.shown
        Rectangle {
            anchors.fill: parent
            // activeFocus: true
            focus: true
            onFocusChanged: console.log("BUHH")
            // focusabl
            color: activeFocus ? "red" : "green"
        }
        // visible:
    }
}
