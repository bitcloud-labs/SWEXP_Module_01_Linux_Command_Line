setup() {
  LAB_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  SOL="$LAB_DIR/solution.sh"
  DF="$LAB_DIR/fixtures/df.txt"
}

@test "reports filesystems above an 80% threshold" {
  run bash "$SOL" "$DF" 80
  [ "$status" -eq 0 ]
  echo "$output" | grep -qx '/data'
  echo "$output" | grep -qx '/var/log'
  [ "${#lines[@]}" -eq 2 ]
}

@test "does not report filesystems at or below the threshold" {
  run bash "$SOL" "$DF" 80
  [ "$status" -eq 0 ]
  ! echo "$output" | grep -qx '/'
  ! echo "$output" | grep -qx '/boot/efi'
}

@test "a higher threshold narrows the result to the fullest filesystem" {
  run bash "$SOL" "$DF" 95
  [ "$status" -eq 0 ]
  [ "$output" = "/var/log" ]
}
