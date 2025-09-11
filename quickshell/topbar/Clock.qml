import Quickshell.Widgets
import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.common
import qs.topbar
import qs.services

Bubble {
    RowLayout {
        id: clockBubble
        anchors.centerIn: parent
        spacing: 5

        StyledText {
            text: SystemTime.date
        }

        Separator {}

        StyledText {
            text: SystemTime.time
        }
    }
}
