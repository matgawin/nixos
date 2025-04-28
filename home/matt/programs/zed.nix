{
  programs.zed-editor = {
    enable = true;
    userSettings = {
      vim_mode = true;
      vim = {
        use_system_clipboard = "always";
        use_multiline_find = false;
        use_smartcase_find = true;
        toggle_relative_line_numbers = true;
      };
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      auto_update = false;
      auto_update_extensions = {
        docker-compose = false;
        dockerfile = false;
        html = false;
      };
      autosave = "on_window_change";
      format_on_save = "off";
      confirm_quit = true;
      max_tabs = 5;
      cursor_blink = false;
      ensure_final_newline_on_save = false;
      always_treat_brackets_as_autoclosed = true;
      double_click_in_multibuffer = "open";
      restore_on_startup = "last_session";
      autoscroll_on_clicks = true;
      formatter = "language_server";
      seed_search_query_from_cursor = "always";
      use_system_path_prompts = false;
      relative_line_numbers = true;
      show_completions_on_input = true;
      show_edit_predictions = true;
      features = {
        edit_prediction_provider = "copilot";
        copilot = true;
      };
      buffer_font_family = "MesloLGS Nerd Font";
      buffer_font_size = 12;
      buffer_font_weight = 80;
      buffer_line_height = {
        custom = 1.4;
      };
      ui_font_family = "MesloLGS Nerd Font";
      ui_font_size = 12;
      ui_font_weight = 80;
      show_whitespaces = "boundary";
      vertical_scroll_margin = 5;
      horizontal_scroll_margin = 10;
      icon_theme = "VSCode Icons (Dark)";
      theme = {
        mode = "dark";
        light = "Nordfox";
        dark = "Nordfox";
      };
      experimental.theme_overrides = {
        text.accent = "#ffffffff";
        editor.invisible = "#FFFFFF08";
      };
      active_pane_modifiers = {
        border_size = 0.5;
        inactive_opacity = 0.8;
        magnification = 1.0;
      };
      tab_size = 4;
      tabs = {
        git_status = true;
        show_diagnostics = "errors";
        show_close_button = "hidden";
        activate_on_close = "neighbour";
      };
      journal = {
        hour_format = "hour24";
      };
      show_wrap_guides = true;
      wrap_guides = [
        80
        120
      ];
      indent_guides = {
        enabled = true;
      };
      git = {
        inline_blame = {
          enabled = true;
          min_column = 60;
          delay_ms = 1000;
        };
        git_gutter = "tracked_files";
        gutter_debounce = 1000;
      };
      assistant = {
        default_model = {
          provider = "copilot_chat";
          model = "claude-3.7-sonnet-thought";
        };
        version = "2";
        enabled = true;
        button = true;
        provider = null;
        dock = "right";
      };
      project_panel = {
        dock = "left";
        auto_reveal_entries = false;
        show_diagnostics = "errors";
        entry_spacing = "standard";
        indent_size = 10;
        default_width = 220;
      };
      terminal = {
        env = {
          EDITOR = "zed";
          NO_TMUX = "1";
        };
        font_family = "MesloLGS Nerd Font";
        shell = {
          program = "zsh";
        };
      };
      lsp = {
        nil = {
          initialization_options = {
            formatting = {
              command = [
                "nixfmt"
              ];
            };
          };
        };
      };
      collaboration_panel = {
        button = false;
      };
      chat_panel = {
        button = "never";
      };
      jupyter = {
        kernel_selections = {
          tsx = "deno";
        };
      };
      calls = {
        mute_on_join = true;
      };
      diagnostics = {
        include_warnings = false;
      };
      file_finder = {
        modal_max_width = "large";
      };
      file_types = {
        JSON = [
          "out"
        ];
      };
    };
    userKeymaps = [
      {
        bindings = {
          alt-l = "workspace::ActivatePaneRight";
          alt-h = "workspace::ActivatePaneLeft";
          "ctrl-k *" = null;
          ctrl-k = null;
        };
      }
      {
        context = "Editor && vim_mode == insert";
        bindings = {
          ctrl-h = "editor::Backspace";
          ctrl-c = "editor::ShowEditPrediction";
          ctrl-l = "editor::AcceptPartialEditPrediction";
          ctrl-j = "editor::NextEditPrediction";
          "alt-." = "editor::AcceptEditPrediction";
          ctrl-k = "editor::PreviousEditPrediction";
        };
      }
      {
        context = "Workspace";
        bindings = {
          "alt-x g" = [
            "task::Spawn"
            { task_name = "open_lazygit"; }
          ];
          "alt-x c" = [
            "task::Spawn"
            { task_name = "open_vs_code"; }
          ];
          "alt-x f" = [
            "task::Spawn"
            { task_name = "hurl_run_file"; }
          ];
          "alt-x d" = [
            "task::Spawn"
            { task_name = "hurl_run_dir"; }
          ];
          "alt-x s" = [
            "task::Spawn"
            { task_name = "hurl_run_selected"; }
          ];
        };
      }
      {
        context = "Workspace";
        bindings = {
          ctrl-s = "workspace::SaveAll";
        };
      }
      {
        context = "Pane";
        bindings = {
          ctrl-tab = "pane::ActivateNextItem";
          ctrl-shift-tab = "pane::ActivatePreviousItem";
        };
      }
      {
        context = "Editor && vim_mode == visual";
        bindings = {
          p = [
            "vim::Paste"
            { preserve_clipboard = true; }
          ];
          S = "vim::PushAddSurrounds";
        };
      }
      {
        context = "Editor";
        bindings = {
          "ctrl-," = null;
        };
      }
      {
        context = "Editor && vim_mode == normal";
        bindings = {
          s = [
            "vim::PushSneak"
            { }
          ];
          S = [
            "vim::PushSneakBackward"
            { }
          ];
        };
      }
    ];
  };

  xdg.configFile."zed/tasks.json".text = ''
    [
        {
            "label": "open_lazygit",
            "command": "lazygit -p $ZED_WORKTREE_ROOT",
            "env": {
                "EDITOR": "zed --wait",
                "NO_TMUX": "1"
            },
            "use_new_terminal": false,
            "allow_concurrent_runs": false,
            "reveal": "always",
            "hide": "on_success",
            "shell": {
                "program": "zsh"
            }
        },
        {
            "label": "open_vs_code",
            "command": "code $ZED_WORKTREE_ROOT $ZED_RELATIVE_FILE",
            "env": {
                "NO_TMUX": "1"
            },
            "use_new_terminal": false,
            "allow_concurrent_runs": false,
            "reveal": "never",
            "hide": "always",
            "shell": {
                "program": "zsh"
            }
        },
        {
            "label": "hurl_run_file",
            "command": "hurl $ZED_FILENAME | jq > $ZED_STEM.out",
            "env": {
                "NO_TMUX": "1"
            },
            "use_new_terminal": false,
            "allow_concurrent_runs": false,
            "reveal": "no_focus",
            "hide": "on_success",
            "cwd": "$ZED_DIRNAME",
            "shell": {
                "program": "zsh"
            }
        },
        {
            "label": "hurl_run_dir",
            "command": "hurl . | jq > $ZED_STEM.out",
            "env": {
                "NO_TMUX": "1"
            },
            "use_new_terminal": false,
            "allow_concurrent_runs": false,
            "reveal": "no_focus",
            "hide": "on_success",
            "cwd": "$ZED_DIRNAME",
            "shell": {
                "program": "zsh"
            }
        },
        {
            "label": "hurl_run_selected",
            "command": "echo '$ZED_SELECTED_TEXT' | hurl | jq > $ZED_STEM.out",
            "env": {
                "NO_TMUX": "1"
            },
            "use_new_terminal": false,
            "allow_concurrent_runs": false,
            "reveal": "no_focus",
            "hide": "on_success",
            "cwd": "$ZED_DIRNAME",
            "shell": {
                "program": "zsh"
            }
        }
    ]
  '';
}
