pragma Singleton
import Quickshell

Singleton {
    function shutdown() {
        Quickshell.execDetached(["systemctl", "poweroff"]);
    }

    function reboot() {
        Quickshell.execDetached(["systemctl", "reboot"]);
    }

    function lock() {
        Quickshell.execDetached(["qs", "ipc", "call", "lock", "lock"]);
    }
}
