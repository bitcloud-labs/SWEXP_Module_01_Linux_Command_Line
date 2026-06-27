setup() {
  LAB_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  SOL="$LAB_DIR/solution.sh"
}

@test "emits a Host block with all four directives" {
  run bash "$SOL" prod 203.0.113.10 deploy '~/.ssh/swexp_ed25519'
  [ "$status" -eq 0 ]
  echo "$output" | grep -Eq '^Host[[:space:]]+prod$'
  echo "$output" | grep -Eq 'HostName[[:space:]]+203\.0\.113\.10'
  echo "$output" | grep -Eq 'User[[:space:]]+deploy'
  echo "$output" | grep -Eq 'IdentityFile[[:space:]]+~/\.ssh/swexp_ed25519'
}

@test "the Host line is the first line and not indented" {
  run bash "$SOL" staging 198.51.100.5 ci '~/.ssh/id_ed25519'
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Host staging" ]
}

@test "reflects different arguments" {
  run bash "$SOL" db 10.0.0.5 postgres '/home/dev/.ssh/db_key'
  [ "$status" -eq 0 ]
  echo "$output" | grep -Eq '^Host[[:space:]]+db$'
  echo "$output" | grep -q '10.0.0.5'
  echo "$output" | grep -q 'postgres'
  echo "$output" | grep -q '/home/dev/.ssh/db_key'
}
