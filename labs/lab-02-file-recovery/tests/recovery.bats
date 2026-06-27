setup() {
  LAB_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  SOL="$LAB_DIR/solution.sh"
  WORK="$(mktemp -d)"
  mkdir -p "$WORK/dump/stray"
  printf 'a\n' > "$WORK/dump/app.log"
  printf 'b\n' > "$WORK/dump/stray/worker.log"
  printf 'c\n' > "$WORK/dump/notes.txt"          # not a .log
  printf 'd\n' > "$WORK/dump/config.conf"         # not a .log
}
teardown() { rm -rf "$WORK"; }

@test "recovers all .log files into recovered/" {
  run bash "$SOL" "$WORK/dump"
  [ "$status" -eq 0 ]
  [ -f "$WORK/dump/recovered/app.log" ]
  [ -f "$WORK/dump/recovered/worker.log" ]
}

@test "does not recover non-log files" {
  bash "$SOL" "$WORK/dump" >/dev/null
  [ ! -f "$WORK/dump/recovered/notes.txt" ]
  [ ! -f "$WORK/dump/recovered/config.conf" ]
}

@test "recovered exactly two log files" {
  bash "$SOL" "$WORK/dump" >/dev/null
  run bash -c "find '$WORK/dump/recovered' -name '*.log' -type f | wc -l"
  [ "$output" -eq 2 ]
}
