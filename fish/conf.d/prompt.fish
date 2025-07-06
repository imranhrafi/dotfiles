## Starship prompt and prompt customization
if type starship >/dev/null 2>&1; and status --is-interactive
    source (starship init fish --print-full-init | psub)
end

# Root prompt customization
if test (id -u) -eq 0
    set -x fish_color_cwd red
end