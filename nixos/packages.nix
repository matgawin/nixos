{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # slstatus
    xfce.thunar
    unzip
    ack
    fzf
    fd
    ripgrep
    firefox
    xclip
    gcc
    vim
    wget
    git
    jujutsu
    curl
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    vulkan-extension-layer
    libva
    libva-utils
    usbutils
    vlc
    bat
  ];
}
