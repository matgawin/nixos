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
                options "caps:escape"
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

    layer-rule {
        match namespace="^noctalia-overview*"
        place-within-backdrop true
    }

    layer-rule {
        match namespace="^rofi$"
        shadow {
            on
        }
    }

    layout {
        gaps 6

        center-focused-column "on-overflow"
        background-color "transparent"

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.75
        }

        default-column-width { proportion 0.75; }

        focus-ring {
            width 1
            active-color "#88C0D0"
            inactive-color "#4C566A"
        }

        border {
            off
        }

        tab-indicator {
            hide-when-single-tab
            place-within-column
            gap 2
            width 4
            position "left"
            gaps-between-tabs 2
            corner-radius 8
            active-color "green"
            inactive-color "gray"
            urgent-color "yellow"
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

    workspace "6" { open-on-output "HDMI-A-1"; }
    workspace "7" { open-on-output "HDMI-A-1"; }

    window-rule {
        match app-id=r#"^brave-browser$"#
        open-on-workspace "1"
        opacity 1.0
        default-column-width { proportion 0.8; }
    }

    window-rule {
        match app-id="zen"
        open-on-workspace "1"
        opacity 1.0
        default-column-width { proportion 0.8; }
    }

    window-rule {
        match app-id=r#"^dev.zed.Zed$"#
        open-on-workspace "6"
        tiled-state true
        default-column-width { proportion 0.8; }
    }

    window-rule {
        match app-id=r#"^Alacritty$"#
        open-on-workspace "6"
        default-column-width { proportion 0.8; }
    }

    window-rule {
        match app-id=r#"^org\.telegram\.desktop$"#
        open-on-workspace "7"
    }

    window-rule {
        match app-id=r#"^FreeTube$"#
        open-on-workspace "7"
        default-column-width { proportion 0.8; }
        opacity 1.0
    }

    window-rule {
        match app-id=r#"^spotify$"#
        open-on-workspace "7"
        default-column-width { proportion 0.8; }
    }

    window-rule {
        match app-id=r#"^steam$"#
        open-on-workspace "7"
        default-column-width { proportion 0.8; }
    }

    window-rule {
        open-focused true
        geometry-corner-radius 20
        clip-to-geometry true
    }

    window-rule {
        match is-window-cast-target=true

        focus-ring {
            active-color "#f38ba8"
            inactive-color "#7d0d2d"
        }

        border {
            inactive-color "#7d0d2d"
        }
     }

     window-rule {
         match is-focused=false
         opacity 0.98
     }

     window-rule {
         match app-id=r#"org.quickshell$"#
         open-floating true
     }

    spawn-at-startup "bash" "-c" "wl-paset --watch cliphist store &"
    spawn-at-startup "fetch-bing-wallpaper"
    spawn-at-startup "noctalia-shell"
    spawn-sh-at-startup "sleep 2 && DISPLAY=:0 ${pkgs.xorg.xhost}/bin/xhost +local:"
    spawn-sh-at-startup "sleep 5 && ${pkgs.kdePackages.kdeconnect-kde}/bin/kdeconnect-indicator"

    prefer-no-csd

    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    environment {
        NIXOS_OZONE_WL "1"
        MOZ_ENABLE_WAYLAND "1"
        XDG_CURRENT_DESKTOP "niri"
        QT_QPA_PLATFORM "wayland"
        ELECTRON_OZONE_PLATFORM_HINT "auto"
        QT_QPA_PLATFORMTHEME "gtk3"
        QT_QPA_PLATFORMTHEME_QT6 "gtk3"
    }

    recent-windows {
        binds {
            Mod+Tab         { next-window; }
            Mod+Shift+Tab   { previous-window; }
            Mod+grave       { next-window     filter="app-id"; }
            Mod+Shift+grave { previous-window filter="app-id"; }
        }
    }

    debug {
        honor-xdg-activation-with-invalid-serial
    }

    binds {
        Mod+Shift+Slash { show-hotkey-overlay; }

        Mod+Return { spawn "sh" "-c" "NO_TMUX=1 alacritty --class QuickShell"; }
        Mod+D { spawn "noctalia-shell" "ipc" "call" "launcher" "toggle"; }

        Mod+X { spawn "kill-with-confirm"; }
        Mod+MouseMiddle { spawn "kill-with-confirm"; }

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
        Mod+F { expand-column-to-available-width; }
        Mod+Ctrl+F { fullscreen-window; }

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

        Mod+Shift+D { spawn-sh "niri msg action set-column-width 50% && niri msg action focus-column-right && niri msg action set-column-width 50% && niri msg action focus-column-left"; }

        Print { screenshot; }

        Mod+Shift+X { spawn "noctalia-shell" "ipc" "call" "lockScreen" "lock"; }
        Mod+Shift+S { spawn "systemctl" "suspend"; }

        Mod+Shift+E { quit; }

        XF86AudioPlay allow-when-locked=true { spawn "noctalia-shell" "ipc" "call" "media" "playPause"; }
        XF86AudioNext allow-when-locked=true { spawn "noctalia-shell" "ipc" "call" "media" "next"; }
        XF86AudioPrev allow-when-locked=true { spawn "noctalia-shell" "ipc" "call" "media" "previous"; }

        XF86AudioMute allow-when-locked=true { spawn "noctalia-shell" "ipc" "call" "volume" "muteOutput"; }

        XF86AudioLowerVolume allow-when-locked=true { spawn-sh "${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%"; }
        XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%"; }
    }
  '';
}
