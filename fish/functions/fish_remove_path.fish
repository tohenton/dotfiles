# Complement to the built-in fish_add_path.
# https://github.com/fish-shell/fish-shell/issues/8604
function fish_remove_path --description 'Remove one or more directories from $fish_user_paths'
    for p in $argv
        if set -l index (contains -i -- $p $fish_user_paths)
            set -e fish_user_paths[$index]
            echo "Removed $p from the path"
        end
    end
end
