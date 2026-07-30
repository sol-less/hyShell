pragma Singleton
import Quickshell

Singleton {
    id: root
    property bool dashboardOpen: false
    property int active_panel: 0

    function set_panel(index) {
        active_panel = index;
    }

    function toggle() {
        dashboardOpen = !dashboardOpen;
    }

    function open() {
        dashboardOpen = true;
    }

    function close() {
        dashboardOpen = false;
    }
}
