setup() {
  LAB_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  SOL="$LAB_DIR/solution.sh"
  WORK="$(mktemp -d)"
  printf 'API_KEY=shhh\n' > "$WORK/secrets.env"; chmod 666 "$WORK/secrets.env"
  printf 'data\n' > "$WORK/open.bin"; chmod 662 "$WORK/open.bin"   # world-writable
  printf 'ok\n'   > "$WORK/safe.txt"; chmod 644 "$WORK/safe.txt"
}
teardown() { rm -rf "$WORK"; }

@test "secrets.env is tightened to 640" {
  bash "$SOL" "$WORK" >/dev/null
  run stat -c '%a' "$WORK/secrets.env"
  [ "$output" = "640" ]
}

@test "world-writable files are reported" {
  run bash "$SOL" "$WORK"
  [ "$status" -eq 0 ]
  echo "$output" | grep -q 'open.bin'
}

@test "safe files are not flagged as world-writable" {
  run bash "$SOL" "$WORK"
  ! echo "$output" | grep -q 'safe.txt'
}
