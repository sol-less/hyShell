import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.config

Item {
    id: root
    height: parent.height
    width: row.width

    RowLayout {
        id: row
        anchors.centerIn: parent
        height: parent.height
        spacing: 3

        Repeater {
            model: 5

            delegate: Rectangle {
                id: dot_slot
                required property int index
                property bool focused: Hyprland.focusedWorkspace?.id === index + 1
                property real firstIndex: focused ? height / 2 : (index === 0 ? height / 2 : height / 4)
                property real lastIndex: focused ? height / 2 : (index === 4 ? height / 2 : height / 4)

                Layout.preferredHeight: 28
                Layout.preferredWidth: focused ? height * 2 : height + 6
                bottomLeftRadius: firstIndex
                topLeftRadius: firstIndex
                bottomRightRadius: lastIndex
                topRightRadius: lastIndex
                color: focused ? Colors.md3.secondary : Colors.md3.surface_container_highest

                Behavior on Layout.preferredWidth {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.OutQuad
                    }
                }
                Behavior on color {
                    ColorAnimation {
                        duration: 250
                    }
                }

                Behavior on topLeftRadius {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.OutQuad
                    }
                }
                Behavior on topRightRadius {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.OutQuad
                    }
                }
                Behavior on bottomLeftRadius {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.OutQuad
                    }
                }
                Behavior on bottomRightRadius {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.OutQuad
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + (dot_slot.index + 1) + " })")
                }
            }
        }
    }
}
