pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
	id: batteryService

	readonly property UPowerDevice device: UPower.displayDevice
	readonly property real percentage: device.ready ? Math.round(device.percentage * 100) : 0
}
