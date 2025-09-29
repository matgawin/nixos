{pkgs, ...}: {
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      SDL2
      SDL2_image
      SDL2_mixer
      SDL2_ttf
      libGL
      libGLU
      mesa
      wayland
      libxkbcommon
      xorg.libX11
      xorg.libXcursor
      xorg.libXrandr
      xorg.libXi
      xorg.libXext
      xorg.libXfixes
      vulkan-loader
      alsa-lib
      libpulseaudio
      pipewire
      glib
      gtk3
      cairo
      pango
      gdk-pixbuf
      atk
      zlib
      stdenv.cc.cc.lib
    ];
  };
}
