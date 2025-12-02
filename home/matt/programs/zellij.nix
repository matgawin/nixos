{pkgs, ...}: let
  forgetVersion = "0.4.2";
  forgotWasm = pkgs.fetchurl {
    url = "https://github.com/karimould/zellij-forgot/releases/download/${forgetVersion}/zellij_forgot.wasm";
    sha256 = "sha256-MRlBRVGdvcEoaFtFb5cDdDePoZ/J2nQvvkoyG6zkSds=";
  };
in {
  programs.zellij = {
    enable = true;
    enableZshIntegration = false;
    attachExistingSession = false;
    exitShellOnExit = false;
    layouts = {};
    extraConfig = ''
      load_plugins {
        "${forgotWasm}"
      }
      keybinds {
        normal {
          bind "F1" {
            LaunchOrFocusPlugin "file:${forgotWasm}" {
              floating true
            };
          }
        }
      }
      env {
        ZELLIJ_AUTO_ATTACH "true"
        ZELLIJ_AUTO_EXIT "true"
      }
    '';
    settings = {
      default_shell = "zsh";
      show_startup_tips = false;
      show_release_notes = false;

      on_force_close = "detach";
      default_mode = "normal";
      copy_on_select = false;

      pane_frames = false;
      mouse_mode = true;
      advanced_mouse_actions = false;

      scroll_buffer_size = 100000;
      pane_viewport_serialization = true;
      scrollback_lines_to_serialize = 1000;
    };
  };
}
