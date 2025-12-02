{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ack
    android-tools
    bash
    curl
    firefox
    fzf
    gcc
    git
    libva
    libva-utils
    unzip
    usbutils
    vim
    vulkan-extension-layer
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    wget
    xarchiver
    xclip
  ];
}
