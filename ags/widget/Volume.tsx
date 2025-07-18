import { createBinding, createState, onCleanup, With } from "ags";
import AstalWp from "gi://AstalWp";

const wp = AstalWp.get_default();
const defaultSpeaker = wp!.audio.defaultSpeaker;

function getVolumeIconName(level: number, muted: boolean = false) {
  if (muted || level === 0) {
    return "audio-volume-muted-symbolic";
  }

  switch (true) {
    case level <= 100 && level >= 66:
      return "audio-volume-high-symbolic";
    case level < 66 && level >= 33:
      return "audio-volume-medium-symbolic";
    default:
      return "audio-volume-low-symbolic";
  }
}

export default function Volume() {
  const [status, setStatus] = createState({
    volume: defaultSpeaker.volume,
    muted: defaultSpeaker.mute,
    icon: defaultSpeaker.volumeIcon,
  });

  const volumeChangeHandler = defaultSpeaker.connect(
    "notify::volume",
    (speaker) => {
      setStatus((v) => ({ ...v, volume: speaker.volume }));
    },
  );
  const muteChangeHandler = defaultSpeaker.connect(
    "notify::mute",
    (speaker) => {
      setStatus((v) => ({ ...v, muted: speaker.mute }));
    },
  );
  const iconChangeHandler = defaultSpeaker.connect(
    "notify::volume-icon",
    (speaker) => {
      setStatus((v) => ({ ...v, icon: speaker.volumeIcon }));
    },
  );

  onCleanup(() => {
    defaultSpeaker.disconnect(volumeChangeHandler);
    defaultSpeaker.disconnect(muteChangeHandler);
    defaultSpeaker.disconnect(iconChangeHandler);
  });

  return (
    <box>
      <With value={status}>
        {(s) => {
          return (
            <box
              name="Volume"
              class={"bubble" + (s.volume === 0 || s.muted ? " muted" : "")}
              spacing={5}
            >
              <image iconName={s.icon} pixelSize={12} />
              <label label={`${Math.round(s.volume * 100)}%`} />
            </box>
          );
        }}
      </With>
    </box>
  );
}
