setup() {
  LAB_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  SOL="$LAB_DIR/solution.sh"
  SS="$LAB_DIR/fixtures/ss.txt"
}

@test "lists unique listening ports sorted ascending" {
  run bash "$SOL" "$SS"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "22" ]
  [ "${lines[1]}" = "80" ]
  [ "${lines[2]}" = "5432" ]
  [ "${lines[3]}" = "8080" ]
  [ "${#lines[@]}" -eq 4 ]
}

@test "de-duplicates ports that appear on both IPv4 and IPv6" {
  run bash "$SOL" "$SS"
  [ "$status" -eq 0 ]
  [ "$(echo "$output" | grep -c '^80$')" -eq 1 ]
  [ "$(echo "$output" | grep -c '^22$')" -eq 1 ]
}

@test "omits the header line from the output" {
  run bash "$SOL" "$SS"
  ! echo "$output" | grep -qi 'port'
}
