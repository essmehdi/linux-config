import { With } from "ags";
import { createPoll } from "ags/time";
import Separator from "./Separator";

export default function Clock() {
  const timePoll = createPoll("", 1000, "date +'%d %b %Y|%H:%M'");
  return (
    <box name="Clock" class="bubble">
      <With value={timePoll}>
        {(t) => {
          const [date, time] = t.split("|");
          return (
            <box>
              <label label={date} useMarkup />
              <Separator />
              <label label={time} useMarkup />
            </box>
          );
        }}
      </With>
    </box>
  );
}
