# https://github.com/fish-shell/fish-shell/issues/8604
function remove-path
    if set -l index (contains -i "$argv" $fish_user_paths)
        set -e fish_user_paths[$index]
        echo "Remove $argv from the path"
    end
end
