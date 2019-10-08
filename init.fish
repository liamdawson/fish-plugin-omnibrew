if not type -q brew
  set -l possible_paths /home/linuxbrew/.linuxbrew/bin "$HOME/.linuxbrew/bin"

  for bin_dir in $possible_paths
    if test -x "$bin_dir/brew"
      set -gx PATH $PATH $bin_dir
      break
    end
  end
end

if type -q brew
  if test (uname) = "Linux"
    set -gx HOMEBREW_PREFIX (brew --prefix)

    # need to append rather than prepend, or libraries get mixed
    set -gx PATH $PATH "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin"

    set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
    set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/Homebrew"
    set -q MANPATH; or set MANPATH ''; set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH;
    set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH;
  else
    brew shellenv | source
  end
end
