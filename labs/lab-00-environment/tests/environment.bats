setup() {
  LAB_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  SOL="$LAB_DIR/solution.sh"
  OSREL="$LAB_DIR/fixtures/os-release"
  WORK="$(mktemp -d)"
}
teardown() { rm -rf "$WORK"; }

@test "prints the PRETTY_NAME value without quotes" {
  run bash "$SOL" "$OSREL"
  [ "$status" -eq 0 ]
  [ "$output" = "Ubuntu 24.04.1 LTS" ]
}

@test "works on a different os-release file" {
  printf 'ID=debian\nPRETTY_NAME="Debian GNU/Linux 12 (bookworm)"\nVERSION_ID="12"\n' > "$WORK/os-release"
  run bash "$SOL" "$WORK/os-release"
  [ "$status" -eq 0 ]
  [ "$output" = "Debian GNU/Linux 12 (bookworm)" ]
}

@test "output contains no surrounding double quotes" {
  run bash "$SOL" "$OSREL"
  [ "$status" -eq 0 ]
  ! echo "$output" | grep -q '"'
}
