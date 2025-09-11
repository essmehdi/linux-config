import QtQuick.Layouts
import qs.services
import qs.common
import qs.theme

Bubble {
    id: volumeBubble
		property string color: SystemAudio.sink.audio.muted ? Appearance.colors.muted : Appearance.colors.surfaceSecondaryForeground
    property string icon: {
        let volume = SystemAudio.sink.audio.volume * 100;
        if (SystemAudio.sink.audio.muted || volume === 0) {
            return "audio-volume-muted-symbolic";
        }
        switch (true) {
						case volume <= 100 && volume >= 70:
								return "audio-volume-high-symbolic";
						case volume < 70 && volume >= 25:
								return "audio-volume-medium-symbolic";
						default:
								return "audio-volume-low-symbolic";
        }
    }

    RowLayout {
				Icon {
					iconName: volumeBubble.icon
					color: volumeBubble.color
				}

        StyledText {
            text: Math.round(SystemAudio.sink.audio.volume * 100) + "%"
						color: volumeBubble.color
        }
    }
}
