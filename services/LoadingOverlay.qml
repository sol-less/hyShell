import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.services

PanelWindow {
    id: overlay

    visible: MatugenService.isRunning
    color: Qt.alpha(Colors.md3.background, 0.85)

    Behavior on color {
        ColorAnimation {
            duration: 250
        }
    }

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayershell.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None  // don't steal input, this is just visual feedback

    Loading {
        active: MatugenService.isRunning
        anchors.centerIn: parent
    }
}
