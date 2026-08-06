// LockOverlay.qml
import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.services

ShellRoot {
    id: root

    LockContext {
        id: lockContext
        onUnlocked: {
            States.lockscreenActive = false;
        }
    }

    WlSessionLock {
        id: lock
        // Directly bind lock state to global state
        locked: States.lockscreenActive

        WlSessionLockSurface {
            LockSurface {
                anchors.fill: parent
                context: lockContext
            }
        }
    }
}
