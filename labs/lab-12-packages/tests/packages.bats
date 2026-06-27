setup() {
  LAB_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  SOL="$LAB_DIR/solution.sh"
  INST="$LAB_DIR/fixtures/installed.txt"
}

@test "reports only the missing packages" {
  run bash "$SOL" "$INST" git tree htop curl
  [ "$status" -eq 0 ]
  echo "$output" | grep -qx 'tree'
  echo "$output" | grep -qx 'htop'
  ! echo "$output" | grep -qx 'git'
  ! echo "$output" | grep -qx 'curl'
}

@test "prints nothing when all packages are installed" {
  run bash "$SOL" "$INST" git curl vim
  [ "$status" -eq 0 ]
  [ -z "$output" ]
}

@test "does not partial-match (vi must not match vim)" {
  run bash "$SOL" "$INST" vi
  [ "$status" -eq 0 ]
  echo "$output" | grep -qx 'vi'
}
