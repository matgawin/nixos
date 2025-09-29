{pkgs, ...}: {
  home.file.".config/niri/config.kdl".text = ''
      hotkey-overlay {
          skip-at-startup
      }

      input {
        focus-follows-mouse max-scroll-amount="10%"
        workspace-auto-back-and-forth

        keyboard {
            xkb {
                layout "pl"
            }
            numlock
        }
    }

    output "DP-3" {
        mode "1920x1080@60"
    }

    output "HDMI-A-1" {
        mode "1920x1080@100"
        focus-at-startup
    }

    layout {
        gaps 2

        center-focused-column "never"

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }

        default-column-width { proportion 0.5; }

        focus-ring {
            width 1
            active-color "#88C0D0"
            inactive-color "#4C566A"
        }

        border {
            off
        }
    }

    animations {
        slowdown 0.2
    }

    gestures {
        hot-corners {
            off
        }
    }

    workspace "1" { open-on-output "DP-3"; }
    workspace "2" { open-on-output "DP-3"; }
    workspace "3" { open-on-output "DP-3"; }
    workspace "4" { open-on-output "DP-3"; }
    workspace "5" { open-on-output "DP-3"; }

    workspace "6" { open-on-output "HDMI-A-1"; }
    workspace "7" { open-on-output "HDMI-A-1"; }
    workspace "8" { open-on-output "HDMI-A-1"; }
    workspace "9" { open-on-output "HDMI-A-1"; }
    workspace "10" { open-on-output "HDMI-A-1"; }

    window-rule {
        match app-id=r#"^brave-browser$"#
        open-on-workspace "1"
        default-column-width { proportion 1.0; }
    }

    window-rule {
        match app-id=r#"^dev.zed.Zed$"#
        open-on-workspace "6"
        default-column-width { proportion 1.0; }
    }

    window-rule {
        match app-id=r#"^Alacritty$"#
        open-on-workspace "7"
        default-column-width { proportion 1.0; }
    }

    window-rule {
        match app-id=r#"^org\.telegram\.desktop$"#
        open-on-workspace "8"
    }

    window-rule {
        match app-id=r#"^FreeTube$"#
        open-on-workspace "9"
        default-column-width { proportion 1.0; }
    }

    window-rule {
        match app-id=r#"^spotify$"#
        open-on-workspace "10"
    }

    window-rule {
        match app-id=r#"^steam$"#
        open-on-workspace "9"
    }

    window-rule {
        open-focused true
     }

    spawn-sh-at-startup "sleep 2 && DISPLAY=:0 ${pkgs.xorg.xhost}/bin/xhost +local:"
    spawn-at-startup "${pkgs.waybar}/bin/waybar"
    spawn-at-startup "fetch-bing-wallpaper"
    spawn-at-startup "${pkgs.blueman}/bin/blueman-applet"
    spawn-sh-at-startup "sleep 5 && ${pkgs.kdePackages.kdeconnect-kde}/bin/kdeconnect-indicator"

    prefer-no-csd

    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    environment {
        NIXOS_OZONE_WL "1"
        MOZ_ENABLE_WAYLAND "1"
    }

    binds {
        Mod+Shift+Slash { show-hotkey-overlay; }

        Mod+Return { spawn "sh" "-c" "NO_TMUX=1 alacritty --class QuickShell"; }
        Mod+D { spawn "${pkgs.rofi}/bin/rofi" "-show" "drun"; }

        Mod+X { spawn "kill-with-confirm"; }
        Mod+O repeat=false { toggle-overview; }
        Mod+T { toggle-column-tabbed-display; }

        Mod+Left  { focus-column-left; }
        Mod+Down  { focus-window-down; }
        Mod+Up    { focus-window-up; }
        Mod+Right { focus-column-right; }
        Mod+H     { focus-column-left; }
        Mod+J     { focus-window-down; }
        Mod+K     { focus-window-up; }
        Mod+L     { focus-column-right; }

        Mod+Ctrl+Left  { move-column-left; }
        Mod+Ctrl+Down  { move-window-down; }
        Mod+Ctrl+Up    { move-window-up; }
        Mod+Ctrl+Right { move-column-right; }
        Mod+Ctrl+H     { move-column-left; }
        Mod+Ctrl+J     { move-window-down; }
        Mod+Ctrl+K     { move-window-up; }
        Mod+Ctrl+L     { move-column-right; }

        Mod+Home { focus-column-first; }
        Mod+End  { focus-column-last; }
        Mod+Ctrl+Home { move-column-to-first; }
        Mod+Ctrl+End  { move-column-to-last; }

        Mod+Comma { focus-monitor-left; }
        Mod+Period { focus-monitor-right; }

        Mod+Shift+Comma { move-column-to-monitor-left; }
        Mod+Shift+Period { move-column-to-monitor-right; }

        Mod+Page_Up cooldown-ms=150 { focus-workspace-up; }
        Mod+Page_Down cooldown-ms=150 { focus-workspace-down; }

        Mod+1 { focus-workspace "1"; }
        Mod+2 { focus-workspace "2"; }
        Mod+3 { focus-workspace "3"; }
        Mod+4 { focus-workspace "4"; }
        Mod+5 { focus-workspace "5"; }
        Mod+6 { focus-workspace "6"; }
        Mod+7 { focus-workspace "7"; }
        Mod+8 { focus-workspace "8"; }
        Mod+9 { focus-workspace "9"; }
        Mod+0 { focus-workspace "10"; }

        // Keychron additional keys
        Ctrl+F1 { focus-workspace "6"; }
        Ctrl+F2 { focus-workspace "7"; }
        Ctrl+F3 { focus-workspace "8"; }
        Ctrl+F4 { focus-workspace "9"; }
        Ctrl+F5 { focus-workspace "10"; }

        Mod+Shift+1 { move-column-to-workspace "1"; }
        Mod+Shift+2 { move-column-to-workspace "2"; }
        Mod+Shift+3 { move-column-to-workspace "3"; }
        Mod+Shift+4 { move-column-to-workspace "4"; }
        Mod+Shift+5 { move-column-to-workspace "5"; }
        Mod+Shift+6 { move-column-to-workspace "6"; }
        Mod+Shift+7 { move-column-to-workspace "7"; }
        Mod+Shift+8 { move-column-to-workspace "8"; }
        Mod+Shift+9 { move-column-to-workspace "9"; }
        Mod+Shift+0 { move-column-to-workspace "10"; }

        Mod+Shift+F { maximize-column; }
        Mod+F { fullscreen-window; }
        Mod+Ctrl+F { expand-column-to-available-width; }

        Mod+M { toggle-window-floating; }
        Mod+Space { center-column; }

        Mod+R { switch-preset-column-width; }
        Mod+Shift+R { switch-preset-window-height; }

        Mod+V { consume-or-expel-window-left; }
        Mod+B { consume-or-expel-window-right; }

        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }
        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }

        Print { screenshot; }

        Mod+Shift+X { spawn "lock-screen"; }
        Mod+Shift+S { spawn "lock-and-suspend"; }

        Mod+Shift+E { quit; }

        XF86AudioPlay allow-when-locked=true { spawn "${pkgs.playerctl}/bin/playerctl" "play-pause"; }
        XF86AudioNext allow-when-locked=true { spawn "${pkgs.playerctl}/bin/playerctl" "next"; }
        XF86AudioPrev allow-when-locked=true { spawn "${pkgs.playerctl}/bin/playerctl" "previous"; }

        XF86AudioMute allow-when-locked=true { spawn-sh "${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn-sh "${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%"; }
        XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%"; }
    }
  '';
}
