import qs.services
import qs.common
import qs.theme
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell
import QtQuick
import QtQuick.Effects
import Quickshell.Services.UPower

Bubble {
    RowLayout {
        property string icon: SystemBattery.device.iconName
        Icon {
            iconName: parent.icon
            color: Appearance.colors.surfacePrimaryForeground
        }

        StyledText {
            text: SystemBattery.percentage + "%"
        }
    }
}
