import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.dashboard.system
import qs.services

Item {
    Layout.fillWidth: true
    Layout.preferredHeight: rows.height

    component Indicator: ColumnLayout {
        id: componentRoot
        property var icon
        property var job
        Progress {
            Layout.alignment: Qt.AlignHCenter
            mode: "circular"
            type: "normal"
            value: componentRoot.job / 100
            size: 96
            strokeWidth: 6

            Text {
                anchors.centerIn: parent
                text: componentRoot.job + "%"
                color: Colors.md3.secondary
                font.family: "Google Sans"
                font.weight: 500
                font.pixelSize: 16
            }
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            font.family: "Material Symbols Rounded"
            text: componentRoot.icon
            color: Colors.md3.secondary
            font.pixelSize: 16
        }
    }

    RowLayout {
        id: rows
        anchors.centerIn: parent
        spacing: 10

        Indicator {
            job: InfoProcess.cpuPercent
            icon: "\ue322"
        }

        Indicator {
            job: InfoProcess.diskPercent
            icon: "\ue1db"
        }

        Indicator {
            job: InfoProcess.batteryPercent
            icon: "\uf304"
        }
    }
}
