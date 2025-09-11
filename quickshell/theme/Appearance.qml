pragma Singleton

import QtQuick
import Quickshell

Singleton {
	id: theme

	readonly property Colors colors: Colors {}
	readonly property FontSize fontSize: FontSize {}

	component Colors: QtObject {
		readonly property string surface: "#1f1d2e"
		readonly property string surfacePrimaryForeground: "#e0def4"
		readonly property string surfaceSecondaryForeground: "#908caa"
		readonly property string lightSurfacePrimaryForeground: "#191724"

		readonly property string muted: "#6e6a86"
		readonly property string subtle: "#524f67"

		readonly property string danger: "#eb6f92"
		readonly property string success: "#f6c177"
	}

	component FontSize: QtObject {
		readonly property int base: 14
	}
}
