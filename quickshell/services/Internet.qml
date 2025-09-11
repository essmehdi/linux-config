pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: internetService
    property bool connected: false
	property bool needsPortal: false
	property string ipAddress: ""

    Process {
        id: internetCheckCommand
        command: ["nmcli", "networking", "connectivity", "check"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                internetService.connected = this.text.includes("full");
                internetService.needsPortal = this.text.includes("portal");
            }
        }
    }

    Process {
        id: nmStateMonitor
        command: ["gdbus", "monitor", "--system", "--dest", "org.freedesktop.NetworkManager"]
        running: true

        stdout: SplitParser {
            splitMarker: "\n"
            onRead: line => {
				ipGetter.running = true
                let idx = line.indexOf("'Connectivity'");
				if (idx !== -1) {
                    let value = line[idx + 24];
                    internetService.connected = value === "4";
                    internetService.needsPortal = value === "2";
                }
            }
        }
    }

	Process {
		id: ipGetter
		command: ["nu", "-c", 'ip -j -4 addr show scope global | from json | where {|it| $it.operstate == "UP"} | each {|it| $it.addr_info.0} | where {|it| $it.label | str starts-with "enp"} | if ($in | length) > 0 { get 0 | $"($in.local)/($in.prefixlen)" } else { "" }']
		running: true

		stdout: StdioCollector {
			onStreamFinished: {
				internetService.ipAddress = this.text.trim()
			}	
		}
	}
}
