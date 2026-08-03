pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root

    readonly property var player: Mpris.players.values.length > 0 ? Mpris.players.values[0] : null

    readonly property var track: ({
            title: player?.trackTitle || "Unknown Title",
            artist: player?.trackArtist || "Unknown Artist",
            album: player?.trackAlbum || "",
            albumArtist: player?.trackAlbumArtist || "",
            artUrl: player?.trackArtUrl || "",
            trackId: player?.trackId || ""
        })

    readonly property var playback: ({
            isPlaying: player?.isPlaying ?? false,
            state: player?.playbackState ?? MprisPlaybackState.Stopped,
            position: player?.position ?? 0,
            length: player?.length ?? 0,
            shuffle: player?.shuffle ?? false,
            loopState: player?.loopState ?? MprisLoopState.None
        })

    readonly property var capabilities: ({
            canControl: player?.canControl ?? false,
            canGoNext: player?.canGoNext ?? false,
            canGoPrevious: player?.canGoPrevious ?? false,
            canTogglePlaying: player?.canTogglePlaying ?? false,
            canSeek: player?.canSeek ?? false,
            shuffleSupported: player?.shuffleSupported ?? false,
            volumeSupported: player?.volumeSupported ?? false,
            lengthSupported: player?.lengthSupported ?? false
        })

    readonly property real progress: playback.length > 0 ? playback.position / playback.length : 0

    // required by MPRIS spec: position isn't reactive on its own,
    // must be manually re-polled to get smooth/updated values
    Timer {
        interval: 1000
        running: root.player !== null && root.playback.isPlaying
        repeat: true
        onTriggered: {
            if (root.player) {
                root.player.positionChanged();
            }
        }
    }
}
