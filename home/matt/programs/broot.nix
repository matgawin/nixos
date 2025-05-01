{
  programs.broot = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      default_flags = "gps";
      show_selection_mark = true;
      quit_on_last_cancel = true;
      verbs = [
        {
          invocation = "edit";
          shortcut = "e";
          key = "enter";
          apply_to = "text_file";
          execution = "$EDITOR {file}";
          leave_broot = false;
        }
        {
          invocation = "create {subpath}";
          execution = "$EDITOR {directory}/{subpath}";
          leave_broot = false;
        }
        {
          invocation = "git_diff";
          shortcut = "gd";
          leave_broot = false;
          execution = "git difftool -y {file}";
        }
        {
          invocation = "git_fetch";
          shortcut = "gf";
          leave_broot = false;
          execution = "git fetch";
        }
        {
          invocation = "backup {version}";
          key = "ctrl-b";
          leave_broot = false;
          auto_exec = false;
          execution = "cp -r {file} {parent}/{file-stem}-{version}{file-dot-extension}";
        }
        {
          invocation = "terminal";
          key = "alt-t";
          execution = "$SHELL";
          set_working_dir = true;
          leave_broot = false;
        }
        {
          invocation = "home";
          key = "ctrl-home";
          internal = "home";
          execution = "=focus ~";
        }
        {
          key = "alt-g";
          execution = "=toggle_git_status";
        }
        {
          key = "F5";
          external = "cp -r {file} {other-panel-directory}";
          leave_broot = false;
        }
        {
          key = "F6";
          external = "mv {file} {other-panel-directory}";
          leave_broot = false;
        }
        {
          key = "ctrl-t";
          internal = "toggle_preview";
        }
      ];
    };
  };
}
