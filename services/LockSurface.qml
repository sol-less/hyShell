import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland
import M3Shapes
import qs.config

Rectangle {
    id: root
    property LockContext context: null

    readonly property var indicatorShapes: [MaterialShape.Triangle, MaterialShape.Square, MaterialShape.Circle]
    readonly property bool hasContext: context !== null && context !== undefined

    color: Colors.md3.background

    // 1. Dynamic model to hold individual indicator items
    ListModel {
        id: indicatorModel
    }

    // 2. Incremental update handler (prevents recreating existing dots)
    Connections {
        target: root.context
        function onCurrentTextChanged() {
            if (!root.hasContext) {
                indicatorModel.clear();
                return;
            }

            var targetLen = root.context.currentText.length;

            // Append new letters incrementally (only new delegates are created)
            while (indicatorModel.count < targetLen) {
                indicatorModel.append({
                    "shapeIndex": indicatorModel.count
                });
            }

            // Remove deleted letters
            while (indicatorModel.count > targetLen) {
                indicatorModel.remove(indicatorModel.count - 1);
            }
        }
    }

    TextInput {
        id: passwordCapture
        focus: true
        width: 0
        height: 0
        opacity: 0
        enabled: hasContext ? !root.context.unlockInProgress : false
        echoMode: TextInput.Password
        inputMethodHints: Qt.ImhSensitiveData

        Component.onCompleted: forceActiveFocus()

        onTextChanged: {
            if (root.hasContext)
                root.context.currentText = text;
        }

        Keys.onReturnPressed: {
            if (root.hasContext)
                root.context.tryUnlock();
        }
        Keys.onEscapePressed: {
            text = "";
            if (root.hasContext)
                root.context.currentText = "";
        }

        Connections {
            target: root.context
            function onCurrentTextChanged() {
                if (root.hasContext && root.context.currentText !== passwordCapture.text) {
                    passwordCapture.text = root.context.currentText;
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: passwordCapture.forceActiveFocus()
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 32

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: Qt.formatDateTime(new Date(), "hh:mm")
            font.family: "Google Sans"
            font.pixelSize: 72
            font.weight: 300
            color: Colors.md3.on_background
            Timer {
                running: true
                repeat: true
                interval: 1000
                onTriggered: parent.text = Qt.formatDateTime(new Date(), "hh:mm")
            }
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: Qt.formatDateTime(new Date(), "dddd, dd MMMM")
            font.family: "Google Sans"
            font.pixelSize: 18
            color: Colors.md3.on_surface_variant
            Timer {
                running: true
                repeat: true
                interval: 60000
                onTriggered: parent.text = Qt.formatDateTime(new Date(), "dddd, dd MMMM")
            }
        }

        RowLayout {
            id: indicatorRow
            Layout.alignment: Qt.AlignHCenter
            spacing: 12

            // Idle shape when no text is present

            // 3. Repeater bound to ListModel
            Repeater {
                model: indicatorModel

                delegate: MaterialShape {
                    id: indicator
                    required property int shapeIndex

                    width: 18
                    height: 18
                    shape: root.indicatorShapes[shapeIndex % root.indicatorShapes.length]
                    color: (root.hasContext && root.context.showFailure) ? Colors.md3.error : Colors.md3.primary

                    scale: 0
                    rotation: 90
                    Component.onCompleted: {
                        scale = 1;
                        rotation = 0;
                    }

                    Behavior on scale {
                        NumberAnimation {
                            duration: 250
                            easing.type: Easing.OutQuint
                        }
                    }

                    Behavior on rotation {
                        NumberAnimation {
                            duration: 250
                            easing.type: Easing.OutQuint
                        }
                    }
                }
            }
        }

        Connections {
            target: root.context
            function onFailed() {
                shakeAnim.start();
            }
        }

        SequentialAnimation {
            id: shakeAnim
            NumberAnimation {
                target: indicatorRow
                property: "x"
                to: -12
                duration: 50
            }
            NumberAnimation {
                target: indicatorRow
                property: "x"
                to: 12
                duration: 50
            }
            NumberAnimation {
                target: indicatorRow
                property: "x"
                to: -8
                duration: 50
            }
            NumberAnimation {
                target: indicatorRow
                property: "x"
                to: 8
                duration: 50
            }
            NumberAnimation {
                target: indicatorRow
                property: "x"
                to: 0
                duration: 50
            }
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            visible: root.hasContext && root.context.showFailure
            text: "Incorrect password"
            font.family: "Google Sans"
            font.pixelSize: 14
            color: Colors.md3.error
            Behavior on opacity {
                NumberAnimation {
                    duration: 150
                }
            }
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            visible: indicatorModel.count === 0
            text: "Type to unlock"
            font.family: "Google Sans"
            font.pixelSize: 14
            color: Colors.md3.on_surface_variant
            opacity: 0.6
        }
    }
}
