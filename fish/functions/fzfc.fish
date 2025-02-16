function fzfc
    fzf --preview='bat --color=always --highlight-line {2} {1}' --delimiter : --preview-window=down,+{2}+3/2
end
