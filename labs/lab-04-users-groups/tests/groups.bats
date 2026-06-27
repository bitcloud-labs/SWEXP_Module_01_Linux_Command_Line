setup() {
  LAB_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  SOL="$LAB_DIR/solution.sh"
  GRP="$LAB_DIR/fixtures/group"
}

@test "lists all members of the payments group, one per line" {
  run bash "$SOL" payments "$GRP"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "alice" ]
  [ "${lines[1]}" = "bob" ]
  [ "${lines[2]}" = "carol" ]
  [ "${#lines[@]}" -eq 3 ]
}

@test "lists the single member of the web group" {
  run bash "$SOL" web "$GRP"
  [ "$status" -eq 0 ]
  [ "$output" = "dave" ]
}

@test "prints nothing for an empty group but still succeeds" {
  run bash "$SOL" empty "$GRP"
  [ "$status" -eq 0 ]
  [ -z "$output" ]
}
