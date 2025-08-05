import AstalTray from "gi://AstalTray";
import { For, createBinding } from "ags";

const tray = AstalTray.get_default();

export default function Tray() {
  const items = createBinding(tray, "items");

  return (
    <box class="bubble" name="Tray">
      <For each={items}>
        {(item) => {
          return (
            <box>
              <image iconName={item.get_icon_name()} />
              <label label={item.get_title()} />
            </box>
          );
        }}
      </For>
    </box>
  );
}
