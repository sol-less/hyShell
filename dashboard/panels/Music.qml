import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import qs.config
import qs.services
import qs.dashboard.music

Item {
    id: root
    implicitWidth: Metrics.panelSizes.music.width
    implicitHeight: Metrics.panelSizes.music.height

    Image {
        id: backgroundImage
        anchors.fill: parent
        source: Variable.track.artUrl
        fillMode: Image.PreserveAspectCrop
        layer.enabled: true
        visible: false
    }

    MultiEffect {
        anchors.fill: backgroundImage
        source: backgroundImage
        blurEnabled: true
        blur: 0.6
        blurMax: 32
        opacity: 0.3
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 16

        RowLayout {
            spacing: 14
            CoverArt {}
            Metadata {
                Layout.fillWidth: true
            }
        }

        Slider {
            id: progressSlider
            Layout.fillWidth: true
            from: 0
            to: Variable.playback.length > 0 ? Variable.playback.length : 1
            enabled: Variable.capabilities.canSeek
            trackColor: Colors.roleColor("music_progress")

            onPressedChanged: {
                if (!pressed && Variable.player && Variable.capabilities.canSeek) {
                    Variable.player.position = value;
                }
            }

            Connections {
                target: Variable
                function onPlaybackChanged() {
                    if (!progressSlider.pressed) {
                        progressSlider.value = Variable.playback.position;
                    }
                }
            }
        }

        TransportControls {
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
