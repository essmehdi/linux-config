import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import qs.theme

pragma ComponentBehavior: Bound

Image {
		required property var iconName
		property var color: Appearance.colors.surfacePrimaryForeground
		property var size: 12

    id: icon
    fillMode: Image.PreserveAspectFit
    Layout.preferredWidth: size
    Layout.preferredHeight: size
    source: Quickshell.iconPath(iconName)
    layer.enabled: true
		antialiasing: true
		smooth: true
		mipmap: true
		sourceSize.width: size * 4
		sourceSize.height: size * 4
    layer.effect: MultiEffect {
        brightness: 1.0
        colorization: 1.0
        colorizationColor: icon.color 
    }
}
