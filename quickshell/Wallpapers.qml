pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property var wallpapers: []
    property int currentIndex: 0

    function doLiterallyFuckingNothing() {
    }

    Process {
        id: refresh_wallpaper_list
        command: ["find", "/home/shuflduf/Projects/Risk-Of-Rice/wallpapers/", "-type", "f"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                root.wallpapers = this.text.trim().split("\n");
            }
        }
    }
}
