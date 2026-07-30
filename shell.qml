//@ pragma DefaultEnv QS_NO_RELOAD_POPUP=1
import QtQuick
import Quickshell
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

    Dashboard {}

    LoadingOverlay {}
}
