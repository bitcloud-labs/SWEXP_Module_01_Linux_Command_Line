setup() {
  LAB_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  SOL="$LAB_DIR/solution.sh"
  LOG="$LAB_DIR/fixtures/access.log"
  WORK="$(mktemp -d)"
  cd "$WORK"
}
teardown() { rm -rf "$WORK"; }

@test "status tally puts '2 200' on top" {
  run bash "$SOL" "$LOG"
  [ "$status" -eq 0 ]
  echo "$output" | grep -Eq '^[[:space:]]*2[[:space:]]+200'
}

@test "produces the same tally from stdin" {
  run bash -c "cat '$LOG' | bash '$SOL'"
  [ "$status" -eq 0 ]
  echo "$output" | grep -Eq '2[[:space:]]+200'
}

@test "tees exactly the two 5xx lines to errors.log" {
  bash "$SOL" "$LOG" >/dev/null
  [ -f errors.log ]
  run wc -l < errors.log
  [ "$output" -eq 2 ]
}
