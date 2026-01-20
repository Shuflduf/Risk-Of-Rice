pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    function showPowerMenu() {
        power_menu.show();
    }
    FloatingWindow {
        id: power_menu
        color: "blue"

        function show() {
            console.log("SHIT");
        }
    }
}
