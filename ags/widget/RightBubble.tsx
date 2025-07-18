import Clock from "./Clock";
import { Gtk } from "ags/gtk4";
import NetworkIndicator from "./NetworkIndicator";
import Volume from "./Volume";
import Battery from "./Battery";

export default function RightBubbles() {
  return (
    <box
      halign={Gtk.Align.END}
      orientation={Gtk.Orientation.HORIZONTAL}
      spacing={5}
    >
      <NetworkIndicator />
      <Volume />
      <Battery />
    </box>
  );
}
