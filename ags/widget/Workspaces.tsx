import { createBinding, For } from "ags";
import AstalHyprland from "gi://AstalHyprland";

const hyprland = AstalHyprland.get_default();

export default function Workspaces() {
  const workspaces = createBinding(hyprland, "workspaces");

  return (
    <For each={workspaces}>
      {(workspace) => {
        const classes = ["workspace"];
        if (workspace.clients.length > 0) {
          classes.push("not-empty");
        }
        return (
          <button class={classes.join(" ")}>
            <label label={workspace.name} />
          </button>
        );
      }}
    </For>
  );
}
