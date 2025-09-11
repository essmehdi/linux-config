import QtQuick.Layouts
import qs.common
import qs.theme
import qs.services
import QtQuick
import QtQuick.Layouts

Bubble {
	id: internetBubble
	property var foregroundColor: Internet.connected ? Appearance.colors.success : Appearance.colors.surfacePrimaryForeground
	color: Internet.connected ? Appearance.colors.surface : Appearance.colors.danger 

	signal clicked

	RowLayout {
		id: layout

		Icon {
			iconName: Internet.connected ? "network-transmit-receive-symbolic" : "network-offline-symbolic"
			color: internetBubble.foregroundColor
		}

		StyledText {
			text: Internet.connected ? "Connected" : Internet.needsPortal ? "Portal needed" : "Disconnected"
			color: internetBubble.foregroundColor
		}

		Separator {
			visible: Internet.ipAddress != ""
			color: !Internet.connected ? Appearance.colors.surfacePrimaryForeground : Appearance.colors.subtle
		}

		StyledText {
			visible: Internet.ipAddress != ""
			text: Internet.ipAddress
			color: Internet.connected ? Appearance.colors.surfaceSecondaryForeground : Appearance.colors.surfacePrimaryForeground 
		}
	}

	Behavior on color {
		ColorAnimation {
			duration: 200
			easing.type: Easing.InOutQuad
		}
	}
}
