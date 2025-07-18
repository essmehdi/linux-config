import { Gtk } from "ags/gtk4";
import Workspaces from "./Workspaces";
import Clock from "./Clock";

export default function LeftBubbles() {
  return (
    <box orientation={Gtk.Orientation.HORIZONTAL} spacing={5}>
      <Clock />
    </box>
  );
}
