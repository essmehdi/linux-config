import { createBinding, createState, onCleanup, With } from "ags";
import { Gtk } from "ags/gtk4";
import { exec } from "ags/process";
import Astal from "gi://Astal?version=4.0";
import AstalNetwork from "gi://AstalNetwork";
import Separator from "./Separator";

const network = AstalNetwork.get_default();

export default function NetworkIndicator() {
	const connectivity = createBinding(network, "connectivity");
	const isConnected = connectivity(
		(state) => state === AstalNetwork.Connectivity.FULL,
	);
	const ipAddresses = createBinding(
		network.wired.device.ip4Config,
		"addresses",
	);
	const ipAddress = ipAddresses(ips => ips[0]?.get_address() ?? null)

	function onClick(self: Gtk.Button) {
		try {
			const out = exec("nu /home/mehdi/.config/ags/scripts/connect-to-network.nu");
			console.log("Connect to network: ", out);
		} catch (err) {
			console.error(err);
		}
	}

	return (
		<button name="Network" class={isConnected(c => "bubble " + (c ? "up" : "down"))} onClicked={onClick}>
			<box orientation={Gtk.Orientation.HORIZONTAL} valign={Gtk.Align.CENTER} spacing={5}>
				<image iconName={isConnected(c => c ? "network-wired-symbolic" : "network-wired-disconnected-symbolic")} pixelSize={12} />
				<label label={isConnected(c => c ? "Operational" : "Down. Click to connect using portal")} />
				<box spacing={5} visible={isConnected}>
					<Separator noSpace />
					<label name="Ip" label={ipAddress} />
				</box>
			</box>
		</button>
	);
}
