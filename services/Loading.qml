import QtQuick
import QtQuick.Shapes
import qs.config

Item {
    id: root
    property bool active: false
    width: 64
    height: 64
    property int currentSides: 8
    property int previousSides: -1
    property real baseRotation: 0
    property real burstRotation: 0
    readonly property real totalRotation: baseRotation + burstRotation
    property real shapeScale: 1

    NumberAnimation on baseRotation {
        running: root.active
        loops: Animation.Infinite
        from: 0
        to: 360
        duration: 6000
    }

    Timer {
        interval: 800
        running: root.active
        repeat: true
        onTriggered: morphBurst.start()
    }

    SequentialAnimation {
        id: morphBurst

        ParallelAnimation {
            NumberAnimation {
                target: root
                property: "shapeScale"
                to: 1.05
                duration: 180
                easing.type: Easing.InQuad
            }
            NumberAnimation {
                target: root
                property: "burstRotation"
                to: 80
                duration: 300
                easing.type: Easing.InQuad
            }
        }

        ScriptAction {
            script: {
                root.previousSides = root.currentSides;
                root.currentSides = Shapes.randomSides(root.previousSides);
            }
        }

        ParallelAnimation {
            NumberAnimation {
                target: root
                property: "shapeScale"
                to: 1
                duration: 380
                easing.type: Easing.OutBack
                easing.overshoot: 2.5
            }
            NumberAnimation {
                target: root
                property: "burstRotation"
                to: 0
                duration: 380
                easing.type: Easing.OutBack
                easing.overshoot: 2.5
            }
        }
    }

    Shape {
        anchors.fill: parent
        rotation: root.totalRotation
        scale: root.shapeScale
        transformOrigin: Item.Center

        ShapePath {
            fillColor: Colors.md3.primary
            strokeWidth: -1
            PathSvg {
                path: Shapes.cookiePath(root.width, root.height, root.currentSides, 0.12)
            }

            Behavior on fillColor {
                ColorAnimation {
                    duration: 250
                }
            }
        }
    }
}
