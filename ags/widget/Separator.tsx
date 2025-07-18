export default function Separator({ noSpace = false }: { noSpace?: boolean }) {
  return (
    <label
      class="separator"
      label="•"
      marginStart={noSpace ? 0 : 5}
      marginEnd={noSpace ? 0 : 5}
    />
  );
}
