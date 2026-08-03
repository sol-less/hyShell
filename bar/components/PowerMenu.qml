import QtQuick
import QtQuick.Layouts
import M3Shapes
import qs.config
import qs.services

Item {
    width: rowLayout.width + 6
    height: parent.height - 12

    RowLayout {
        id: rowLayout
        anchors.centerIn: parent
        spacing: 16

        Repeater {
            model: [
                {
                    text: "\ue8ac",
                    action: PowerActions.shutdown
                },
                {
                    text: "\uf053",
                    action: PowerActions.reboot
                },
                {
                    text: "\ue897",
                    action: PowerActions.lock
                }
            ]

            delegate: MaterialShape {
                width: 28
                height: 28
                color: mouseHandler.containsMouse ? Colors.roleColor("powermenu") : Colors.md3.surface_container_highest
                scale: mouseHandler.containsMouse ? 1.2 : 1
                shape: mouseHandler.containsMouse ? MaterialShape.Cookie7Sided : MaterialShape.Cookie4Sided

                Behavior on color {
                    ColorAnimation {
                        duration: 250
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.OutQuad
                    }
                }

                Text {
                    anchors.centerIn: parent
                    text: modelData.text
                    color: mouseHandler.containsMouse ? Colors.md3.surface_container_highest : Colors.md3.secondary
                    font.family: "Material Symbols Rounded"

                    Behavior on color {
                        ColorAnimation {
                            duration: 250
                        }
                    }
                }

                MouseArea {
                    id: mouseHandler
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: modelData.action()
                }
            }
        }
    }
}
