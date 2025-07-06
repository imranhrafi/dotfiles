## Environment Variables and Setup
set VIRTUAL_ENV_DISABLE_PROMPT 1
set -xU MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -xU MANROFFOPT -c
set -x SHELL /usr/bin/fish

# Qt theme for qtile
if type qtile >/dev/null 2>&1
    set -x QT_QPA_PLATFORMTHEME qt5ct
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH