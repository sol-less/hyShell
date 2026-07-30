import QtQuick
import Quickshell
import qs.config
import qs.bar.components

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    margins {
        top: Metrics.bar_margin_top
        left: 10
        right: 10
    }

    implicitHeight: Metrics.bar_height
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        z: -99
        color: Colors.md3.surface_container
        radius: 99
    }

    Workspaces {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 6
    }

    Clock {
        anchors.centerIn: parent
    }

    PowerMenu {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 6
    }
}
