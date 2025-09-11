import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: panelRoot
    // the screen from the screens list will be injected into this
    // property
    required property var modelData

    // we can then set the window's screen to the injected property
    screen: modelData

    anchors {
        top: true
        left: true
        right: true
    }

    margins {
				top: 10
        left: 10
        right: 10
    }

    implicitHeight: 25

    color: "transparent"

    RowLayout {
        id: barContent
        anchors.fill: parent
        spacing: 10

        Clock {
            implicitHeight: panelRoot.implicitHeight
        }

        Item {
            Layout.fillWidth: true
        }

        RowLayout {
            id: rightBarContent
            spacing: 5

						Internet {
							implicitHeight: panelRoot.implicitHeight
						}

            Volume {
                implicitHeight: panelRoot.implicitHeight
            }

            Battery {
                implicitHeight: panelRoot.implicitHeight
            }
        }
    }
}
