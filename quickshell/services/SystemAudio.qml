pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
	id: audioService
	readonly property PwNode sink: Pipewire.defaultAudioSink

	signal volumeChanged

	PwObjectTracker {
		objects: [Pipewire.defaultAudioSink]
	}

}
