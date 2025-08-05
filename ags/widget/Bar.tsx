import app from "ags/gtk4/app";
import { Astal, Gtk, Gdk } from "ags/gtk4";
import { execAsync } from "ags/process";
import { createPoll } from "ags/time";
import Clock from "./Clock";
import LeftBubbles from "./LeftBubble";
import RightBubbles from "./RightBubble";

export default function Bar({ gdkmonitor }: { gdkmonitor: Gdk.Monitor }) {
  const time = createPoll("", 1000, "date +'%d %b %Y %H:%M'");
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      visible
      name="bar"
      class="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={app}
    >
      <box homogeneous orientation={Gtk.Orientation.HORIZONTAL}>
        <LeftBubbles />
        <RightBubbles />
      </box>
    </window>
  );
}
