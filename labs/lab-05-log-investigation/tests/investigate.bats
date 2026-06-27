setup() {
  LAB_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  SOL="$LAB_DIR/solution.sh"
  LOG="$LAB_DIR/fixtures/access.log"
}

@test "identifies the busiest client IP" {
  run bash "$SOL" "$LOG"
  [ "$status" -eq 0 ]
  echo "$output" | grep -Eq '^busiest[[:space:]]+10\.0\.0\.7$'
}

@test "counts all 4xx and 5xx responses" {
  run bash "$SOL" "$LOG"
  [ "$status" -eq 0 ]
  echo "$output" | grep -Eq '^errors[[:space:]]+5$'
}

@test "does not count 2xx responses as errors" {
  run bash "$SOL" "$LOG"
  [ "$status" -eq 0 ]
  ! echo "$output" | grep -Eq '^errors[[:space:]]+10$'
}
