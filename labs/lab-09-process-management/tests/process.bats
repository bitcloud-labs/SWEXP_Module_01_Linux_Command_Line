setup() {
  LAB_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  SOL="$LAB_DIR/solution.sh"
  PS="$LAB_DIR/fixtures/ps.txt"
  WORK="$(mktemp -d)"
}
teardown() { rm -rf "$WORK"; }

@test "prints the PID of the highest-%CPU process" {
  run bash "$SOL" "$PS"
  [ "$status" -eq 0 ]
  [ "$output" = "1337" ]
}

@test "ignores the header row" {
  run bash "$SOL" "$PS"
  [ "$status" -eq 0 ]
  ! echo "$output" | grep -qi 'pid'
}

@test "works on a different table" {
  printf 'USER PID %%CPU %%MEM CMD\n'      >  "$WORK/ps.txt"
  printf 'dev 200 4.0 1.0 a\n'             >> "$WORK/ps.txt"
  printf 'dev 201 50.5 1.0 b\n'            >> "$WORK/ps.txt"
  printf 'dev 202 9.9 1.0 c\n'             >> "$WORK/ps.txt"
  run bash "$SOL" "$WORK/ps.txt"
  [ "$status" -eq 0 ]
  [ "$output" = "201" ]
}
