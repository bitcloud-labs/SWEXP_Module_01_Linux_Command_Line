setup() {
  LAB_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  SOL="$LAB_DIR/solution.sh"
  FIX="$LAB_DIR/fixtures"
  WORK="$(mktemp -d)"
  # Assemble a self-contained audit dir from the fixtures.
  cp "$FIX/df.txt" "$FIX/installed.txt" "$FIX/wanted.txt" "$FIX/threshold" "$WORK/"
  mkdir -p "$WORK/app"
  printf 'secret\n' > "$WORK/app/leak.conf"; chmod 666 "$WORK/app/leak.conf"  # world-writable
  printf 'ok\n'     > "$WORK/app/safe.txt";  chmod 644 "$WORK/app/safe.txt"
}
teardown() { rm -rf "$WORK"; }

@test "report contains all three section headers in order" {
  run bash "$SOL" "$WORK"
  [ "$status" -eq 0 ]
  echo "$output" | grep -q '== WORLD-WRITABLE =='
  echo "$output" | grep -q '== DISK OVER THRESHOLD =='
  echo "$output" | grep -q '== MISSING PACKAGES =='
  ww="$(echo "$output" | grep -n '== WORLD-WRITABLE ==' | cut -d: -f1)"
  dk="$(echo "$output" | grep -n '== DISK OVER THRESHOLD ==' | cut -d: -f1)"
  pk="$(echo "$output" | grep -n '== MISSING PACKAGES ==' | cut -d: -f1)"
  [ "$ww" -lt "$dk" ]
  [ "$dk" -lt "$pk" ]
}

@test "flags the world-writable file but not the safe one" {
  run bash "$SOL" "$WORK"
  [ "$status" -eq 0 ]
  echo "$output" | grep -q 'leak.conf'
  ! echo "$output" | grep -q 'safe.txt'
}

@test "flags over-threshold filesystems from df.txt" {
  run bash "$SOL" "$WORK"
  [ "$status" -eq 0 ]
  echo "$output" | grep -q '/data'
  echo "$output" | grep -q '/var/log'
  ! echo "$output" | grep -Eq '[[:space:]]/$'
}

@test "lists packages that are wanted but not installed" {
  run bash "$SOL" "$WORK"
  [ "$status" -eq 0 ]
  echo "$output" | grep -qx '  ufw'
  echo "$output" | grep -qx '  fail2ban'
  ! echo "$output" | grep -qx '  git'
  ! echo "$output" | grep -qx '  curl'
}
