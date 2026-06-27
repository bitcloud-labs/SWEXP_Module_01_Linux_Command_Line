setup() {
  LAB_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  SOL="$LAB_DIR/solution.sh"
  WORK="$(mktemp -d)"
  mkdir -p "$WORK/dotfiles" "$WORK/home"
  printf 'export EDITOR=vim\n' > "$WORK/dotfiles/bashrc"
  printf '[user]\n  name = dev\n'  > "$WORK/dotfiles/gitconfig"
}
teardown() { rm -rf "$WORK"; }

@test "creates symlinks named .<file> in home pointing at the source" {
  run bash "$SOL" "$WORK/dotfiles" "$WORK/home"
  [ "$status" -eq 0 ]
  [ -L "$WORK/home/.bashrc" ]
  [ -L "$WORK/home/.gitconfig" ]
  [ "$(readlink "$WORK/home/.bashrc")" = "$WORK/dotfiles/bashrc" ]
}

@test "the symlink resolves to the source content" {
  bash "$SOL" "$WORK/dotfiles" "$WORK/home" >/dev/null
  run cat "$WORK/home/.gitconfig"
  echo "$output" | grep -q 'name = dev'
}

@test "is idempotent — a second run still succeeds with the same links" {
  bash "$SOL" "$WORK/dotfiles" "$WORK/home" >/dev/null
  run bash "$SOL" "$WORK/dotfiles" "$WORK/home"
  [ "$status" -eq 0 ]
  [ -L "$WORK/home/.bashrc" ]
  [ "$(readlink "$WORK/home/.bashrc")" = "$WORK/dotfiles/bashrc" ]
}
