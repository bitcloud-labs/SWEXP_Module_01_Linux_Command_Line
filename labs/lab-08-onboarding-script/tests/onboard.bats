setup() {
  LAB_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  SOL="$LAB_DIR/solution.sh"
  WORK="$(mktemp -d)"
}
teardown() { rm -rf "$WORK"; }

@test "creates the projects dir and the marker" {
  run bash "$SOL" "$WORK/box"
  [ "$status" -eq 0 ]
  [ -d "$WORK/box/projects" ]
  [ -f "$WORK/box/.onboarded" ]
}

@test "is idempotent — a second run still succeeds" {
  bash "$SOL" "$WORK/box" >/dev/null
  run bash "$SOL" "$WORK/box"
  [ "$status" -eq 0 ]
  [ -d "$WORK/box/projects" ]
}

@test "fails when a required command is missing" {
  export REQUIRE="git definitely-not-a-real-cmd-xyz"
  run bash "$SOL" "$WORK/box"
  unset REQUIRE
  [ "$status" -ne 0 ]
}
