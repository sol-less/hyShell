//@ pragma DefaultEnv QS_NO_RELOAD_POPUP=1
import QtQuick
import Quickshell
import Quickshell.Io
import qs.bar
import qs.dashboard
import qs.services

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
    }

    IpcHandler {
        target: "dashboard"
        function toggle(): void {
            States.toggle();
        }
        function open(): void {
            States.open();
        }
        function close(): void {
            States.close();
        }
    }

    LoadingOverlay {}
}
