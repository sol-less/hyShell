import QtQuick
import QtQuick.Layouts
import qs.services
import qs.config

Rectangle {
    readonly property var tabs: [
        {
            "icon": "\ue5c3",
            "label": "Apps"
        },
        {
            "icon": "\ue3f4",
            "label": "Wallpaper"
        },
        {
            "icon": "\ue30a",
            "label": "System"
        },
        {
            "icon": "\ue405",
            "label": "Music"
        }
    ]

    function switcher_tabs_icon(i) {
        return tabs[i].icon;
    }

    function switcher_tabs_label(i) {
        return tabs[i].label;
    }

    Layout.fillWidth: true
    Layout.preferredHeight: 52
    radius: height / 2
    color: Colors.md3.surface_container_high

    RowLayout {
        anchors.fill: parent
        anchors.margins: 6
        spacing: 3

        Repeater {
            model: 4

            delegate: Rectangle {
                id: tab_slot

                required property int index
                readonly property bool isActive: States.active_panel === index
                property real firstIndex: (index === 0 || isActive) ? height / 2 : 6
                property real lastIndex: (index === 3 || isActive) ? height / 2 : 6

                Layout.fillWidth: true
                Layout.fillHeight: true
                bottomLeftRadius: firstIndex
                topLeftRadius: firstIndex
                bottomRightRadius: lastIndex
                topRightRadius: lastIndex
                color: isActive ? Colors.md3.secondary : Colors.md3.secondary_container

                RowLayout {
                    anchors.centerIn: parent
                    spacing: 4

                    Item {
                        Layout.preferredWidth: iconText.implicitWidth
                        Layout.preferredHeight: iconText.implicitHeight

                        Text {
                            id: iconText
                            y: 2
                            text: switcher_tabs_icon(tab_slot.index)
                            font.family: "Material Symbols Rounded"
                            font.pixelSize: 16
                            color: tab_slot.isActive ? Colors.md3.surface_container_high : Colors.md3.on_surface_variant
                            Behavior on color {
                                ColorAnimation {
                                    duration: 200
                                }
                            }
                        }
                    }

                    Text {
                        text: switcher_tabs_label(tab_slot.index)
                        font.family: "Google Sans"
                        font.weight: tab_slot.isActive ? 500 : 400
                        font.pixelSize: 12
                        color: tab_slot.isActive ? Colors.md3.surface_container_high : Colors.md3.on_surface_variant
                        Behavior on color {
                            ColorAnimation {
                                duration: 200
                            }
                        }
                        Behavior on font.pixelSize {
                            NumberAnimation {
                                duration: 250
                                easing.type: Easing.OutQuint
                            }
                        }
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: States.set_panel(tab_slot.index)
                }

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }

                Behavior on topLeftRadius {
                    SpringAnimation {
                        spring: 3.2
                        damping: 0.18
                        mass: 1
                        epsilon: 0.25
                    }
                }

                Behavior on topRightRadius {
                    SpringAnimation {
                        spring: 3.2
                        damping: 0.18
                        mass: 1
                        epsilon: 0.25
                    }
                }

                Behavior on bottomLeftRadius {
                    SpringAnimation {
                        spring: 3.2
                        damping: 0.18
                        mass: 1
                        epsilon: 0.25
                    }
                }

                Behavior on bottomRightRadius {
                    SpringAnimation {
                        spring: 3.2
                        damping: 0.18
                        mass: 1
                        epsilon: 0.25
                    }
                }
            }
        }
    }
}
