import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services

Rectangle {
    id: root
    property real cornerRadius: height / 2

    width: (mouseHandler.containsMouse ? dateText.implicitWidth : timeText.implicitWidth) + 24
    height: parent.height - 12
    radius: cornerRadius
    color: Colors.md3.secondary
    clip: true

    SystemClock {
        id: sysClock

        precision: SystemClock.Seconds
    }

    SequentialAnimation {
        id: open_punch
        NumberAnimation {
            target: root
            property: "cornerRadius"
            to: 6
            duration: 180
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: root
            property: "cornerRadius"
            to: root.height / 2
            duration: 380
            easing.type: Easing.OutBack
            easing.overshoot: 3.5
        }
    }

    Text {
        id: timeText

        anchors.centerIn: parent
        text: Qt.formatDateTime(sysClock.date, "hh:mm")
        font.family: "Google Sans"
        font.weight: 500
        font.pixelSize: 18
        color: Colors.md3.on_secondary
        opacity: mouseHandler.containsMouse ? 0 : 1
        y: (parent.height - height) / 2 + (mouseHandler.containsMouse ? -8 : 0)

        Behavior on opacity {
            NumberAnimation {
                duration: 200
                easing.bezierCurve: [0.2, 0, 0, 1, 1, 1]
            }
        }

        Behavior on y {
            NumberAnimation {
                duration: 250
                easing.bezierCurve: [0.2, 0, 0, 1, 1, 1]
            }
        }
    }

    Text {
        id: dateText

        anchors.centerIn: parent
        text: Qt.formatDateTime(sysClock.date, "dd ddd, MMM")
        font.family: "Google Sans"
        font.weight: 500
        font.pixelSize: 18
        color: Colors.md3.on_secondary
        opacity: mouseHandler.containsMouse ? 1 : 0
        y: (parent.height - height) / 2 + (mouseHandler.containsMouse ? 0 : 8)

        Behavior on opacity {
            NumberAnimation {
                duration: 200
                easing.bezierCurve: [0.2, 0, 0, 1, 1, 1]
            }
        }

        Behavior on y {
            NumberAnimation {
                duration: 250
                easing.bezierCurve: [0.2, 0, 0, 1, 1, 1]
            }
        }
    }

    MouseArea {
        id: mouseHandler
        anchors.fill: parent
        hoverEnabled: true
        onContainsMouseChanged: {
            if (containsMouse) {
                open_punch.start();
            } else {
                open_punch.stop();
                cornerRadius = root.height / 2;
            }
        }
    }

    Behavior on width {
        SpringAnimation {
            spring: 3.2
            damping: 0.18
            mass: 1
            epsilon: 0.25
        }
    }
}
