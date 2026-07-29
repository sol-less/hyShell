import QtQuick
import QtQuick.Layouts
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

            delegate: Rectangle {
                width: 28
                height: 28
                radius: 6
                color: Colors.md3.surface_container_highest

                Text {
                    anchors.centerIn: parent
                    text: modelData.text
                    color: Colors.md3.secondary
                    font.family: "Material Symbols Rounded"
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: modelData.action()
                }
            }
        }
    }
}
