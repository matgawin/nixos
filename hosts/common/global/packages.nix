{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # slstatus
    ack
    bat
    cowsay
    curl
    fd
    firefox
    fortune
    fzf
    gcc
    git
    jujutsu
    kdePackages.kdeconnect-kde
    libva
    libva-utils
    ripgrep
    unzip
    usbutils
    vim
    vlc
    vulkan-extension-layer
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    wget
    xclip
    xfce.thunar
  ];
}
