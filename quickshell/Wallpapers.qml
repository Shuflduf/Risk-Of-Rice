pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property var wallpapers: []

    function doLiterallyFuckingNothing() {
    }

    function cycleWallpaper() {
        const oldTemplate = hyprpaper_conf.text();

        const firstLine = oldTemplate.split("\n")[0];
        const currentIndex = firstLine.startsWith("# index = ") ? parseInt(firstLine.split("=")[1].trim()) : 0;

        const hyprpaperConfTemplate = `# index = [[INDEX]]
wallpaper {
	monitor =
	path = [[PATH]]
}

splash = false`;

        const nextWallIndex = (currentIndex + 1) % wallpapers.length;
        const nextWall = wallpapers[nextWallIndex];
        const newConf = hyprpaperConfTemplate.replace("[[PATH]]", nextWall).replace("[[INDEX]]", nextWallIndex);
        hyprpaper_conf.setText(newConf);

        force_update_hyprpaper.command = ["hyprctl", "hyprpaper", "wallpaper", `,${nextWall}`];
        force_update_hyprpaper.running = true;
    }

    FileView {
        id: hyprpaper_conf
        path: `${Quickshell.env("XDG_CONFIG_HOME")}/hypr/hyprpaper.conf`
        blockLoading: true
    }

    Process {
        id: force_update_hyprpaper
    }

    Process {
        id: refresh_wallpaper_list
        command: ["find", `${Quickshell.env("XDG_DATA_HOME")}/Risk-Of-Rice/wallpapers/`, "-type", "f"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                root.wallpapers = this.text.trim().split("\n");
            }
        }
    }
}
