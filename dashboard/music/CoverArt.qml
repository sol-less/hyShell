import QtQuick
import QtQuick.Effects
import M3Shapes
import qs.config
import qs.services

Item {
    id: root
    implicitWidth: 80
    implicitHeight: 80

    readonly property var shapePool: [MaterialShape.Cookie4Sided, MaterialShape.Cookie6Sided, MaterialShape.Cookie9Sided, MaterialShape.Sunny, MaterialShape.VerySunny, MaterialShape.Flower, MaterialShape.Boom, MaterialShape.Pentagon, MaterialShape.Gem, MaterialShape.Heart, MaterialShape.Squircle]
    property int currentShapeIndex: Math.floor(Math.random() * shapePool.length)

    Connections {
        target: Variable
        function onTrackChanged() {
            root.currentShapeIndex = Math.floor(Math.random() * root.shapePool.length);
        }
    }

    Image {
        id: imageHandler
        source: Variable.track.artUrl
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        sourceSize.width: 160
        sourceSize.height: 160
        layer.enabled: true
        visible: false
    }

    MaterialShape {
        id: materialHandler
        anchors.fill: parent
        layer.enabled: true
        visible: false
        shape: root.shapePool[root.currentShapeIndex]
        animationDuration: 550
        animationEasing.type: Easing.OutBack
    }

    MultiEffect {
        anchors.fill: imageHandler
        source: imageHandler
        maskEnabled: true
        maskSource: materialHandler
    }
}
