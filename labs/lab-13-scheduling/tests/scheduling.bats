setup() {
  LAB_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  SOL="$LAB_DIR/solution.sh"
}

@test "emits the exact weekday-09:00 schedule with the command" {
  run bash "$SOL" '/usr/local/bin/backup.sh'
  [ "$status" -eq 0 ]
  [ "$output" = "0 9 * * 1-5 /usr/local/bin/backup.sh" ]
}

@test "the schedule expression is exactly five fields" {
  run bash "$SOL" 'true'
  [ "$status" -eq 0 ]
  sched="$(echo "$output" | awk '{print $1, $2, $3, $4, $5}')"
  [ "$sched" = "0 9 * * 1-5" ]
}

@test "carries a different command through unchanged" {
  run bash "$SOL" 'date >> /tmp/run.log'
  [ "$status" -eq 0 ]
  [ "$output" = "0 9 * * 1-5 date >> /tmp/run.log" ]
}
