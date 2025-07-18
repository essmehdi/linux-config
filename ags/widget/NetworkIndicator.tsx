import { createBinding, createState, onCleanup, With } from "ags";
import { Gtk } from "ags/gtk4";
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

  return (
    <box>
      <With value={isConnected}>
        {(connected) => (
          <box name="Network" class={"bubble " + (connected ? "up" : "down")}>
            {connected ? (
              <box orientation={Gtk.Orientation.HORIZONTAL} spacing={5}>
                <image iconName="network-wired-symbolic" pixelSize={12} />
                <label label="Operational" />
                <With value={ipAddresses}>
                  {(addresses) => {
                    return (
                      <box spacing={5} visible={addresses.length > 0}>
                        <Separator noSpace />
                        <label name="Ip" label={addresses[0].get_address()} />
                      </box>
                    );
                  }}
                </With>
              </box>
            ) : (
              <box orientation={Gtk.Orientation.HORIZONTAL} spacing={5}>
                <image
                  iconName="network-wired-disconnected-symbolic"
                  pixelSize={12}
                />
                <label label="Down" />
              </box>
            )}
          </box>
        )}
      </With>
    </box>
  );
}
