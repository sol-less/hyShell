import QtQuick
import qs.dashboard.launcher

ListView {
    id: root

    property var app_ref_current: currentItem?.app_ref ?? null
    signal app_activated(var app)

    clip: true
    spacing: 4
    currentIndex: 0
    highlightMoveDuration: 120

    delegate: AppEntry {
        required property var modelData
        required property int index

        app_ref: modelData
        is_current: root.currentIndex === index

        onHovered: root.currentIndex = index
        onActivated: root.app_activated(modelData)
    }
}
