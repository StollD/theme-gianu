# name: Gianu
function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function fish_prompt
  set -l cyan (set_color cyan)
  set -l yellow (set_color yellow)
  set -l red (set_color red)
  set -l green (set_color green)
  set -l white (set_color white)
  set -l normal (set_color normal)


  set -l cwd $cyan(basename (prompt_pwd))

  if [ (_git_branch_name) ]
    set -l git_branch $yellow(_git_branch_name)
    set git_info "$normal$yellow$git_branch"

    if [ (_is_git_dirty) ]
      set -l dirty "*"
      set git_info "$git_info$dirty"
    end

    set git_info " $git_info$normal"
  end

  echo -n -s $normal '[' $green (whoami) '@' (hostname -s) $normal ' ' $cwd  $git_info $normal ']$ '
end

