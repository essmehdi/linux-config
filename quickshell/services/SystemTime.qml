pragma Singleton
import Quickshell

Singleton {
	id: timeService

	readonly property string time: {
		Qt.formatDateTime(clock.date, "hh:mm")
	}

	readonly property string date: {
		Qt.formatDateTime(clock.date, "d MMM yyyy")
	}

	SystemClock {
		id: clock
		precision: SystemClock.Seconds
	}
}
