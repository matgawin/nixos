{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ack
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
