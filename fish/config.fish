## Fish minimal config
# Hide welcome message
set fish_greeting
# (All other configuration is now modularized in conf.d/*.fish)
# pnpm
set -gx PNPM_HOME "/home/rafi/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
