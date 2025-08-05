import app from "ags/gtk4/app";
import style from "./style.scss";
import Gtk from "gi://Gtk";
import Bar from "./widget/Bar";
import { For, createBinding } from "ags";

function main() {
  const monitors = createBinding(app, "monitors");

  return (
    <For each={monitors} cleanup={(win) => (win as Gtk.Window).destroy()}>
      {(monitor) => <Bar gdkmonitor={monitor} />}
    </For>
  );
}

app.start({ css: style, main });
