import Quickshell
import qs.topbar

Variants {
    model: Quickshell.screens

    delegate: TopBar {
        modelData: item
    }
}
