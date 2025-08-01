import { createBinding, With } from "ags";
import AstalBattery from "gi://AstalBattery";

const battery = AstalBattery.get_default();

export default function Battery() {
  const batteryLevel = createBinding(battery, "percentage");
  const batteryIcon = createBinding(battery, "iconName");

  const percentageText = batteryLevel((l) => `${Math.round(l * 100)}%`);

  return (
    <box name="Battery" class="bubble" spacing={5}>
      <image iconName={batteryIcon} pixelSize={12} />
      <label label={percentageText} />
    </box>
  );
}
