//@ pragma DefaultEnv QS_NO_RELOAD_POPUP=1
import QtQuick
import Quickshell
import Quickshell.Io
import qs.bar
import qs.dashboard
import qs.services
import qs.lockscreen

ShellRoot {
    Variants {
        model: Quickshell.screens

        Bar {
            required property var modelData
            screen: modelData
        }
    }

    Dashboard {
        id: dashboard

        IpcHandler {
            target: "dashboard"
            function toggle(): void {
                States.dashboardToggle();
            }
            function open(): void {
                States.dashboardOpenSet();
            }
            function close(): void {
                States.dashboardClose();
            }
        }
    }

    IpcHandler {
        target: "lock"
        function lock(): void {
            States.toggleLock();
        }
    }

    LoadingOverlay {}

    LockOverlay {}
}
