setup() {
  LAB_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  SOL="$LAB_DIR/solution.sh"
  WORK="$(mktemp -d)"
  # Build a small known tree: 3 files, 2 dirs (sub, sub/deep).
  mkdir -p "$WORK/tree/sub/deep"
  printf 'aaa\n'            > "$WORK/tree/small.txt"          # 4 bytes
  printf 'medium-content\n' > "$WORK/tree/sub/mid.log"        # 15 bytes
  head -c 200 /dev/zero    > "$WORK/tree/sub/deep/biggest.bin" # 200 bytes (largest)
}
teardown() { rm -rf "$WORK"; }

@test "reports the file count" {
  run bash "$SOL" "$WORK/tree"
  [ "$status" -eq 0 ]
  echo "$output" | grep -Eq '^files[[:space:]]+3$'
}

@test "reports the directory count" {
  run bash "$SOL" "$WORK/tree"
  [ "$status" -eq 0 ]
  echo "$output" | grep -Eq '^dirs[[:space:]]+2$'
}

@test "reports the basename of the largest file" {
  run bash "$SOL" "$WORK/tree"
  [ "$status" -eq 0 ]
  echo "$output" | grep -Eq '^largest[[:space:]]+biggest\.bin$'
}
