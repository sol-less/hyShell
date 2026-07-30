pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property bool isRunning: false
    property bool _process_done: false
    property var current_wallpaper: ""

    signal wallpaperApplied(string path)

    function applyWallpaper(path) {
        matugenProc.command = ["matugen", "image", path, "--source-color-index", "0"];
        isRunning = true;
        matugenProc.running = true;
        root.wallpaperApplied(path);
    }
    Timer {
        id: min_duration_timer
        interval: 700
        onTriggered: {
            root._process_done = true;
            if (!matugenProc.running)
                root.is_running = false;
        }
    }

    Process {
        id: matugenProc
        onExited: (code, status) => {
            root.isRunning = false;
        }
    }
}
