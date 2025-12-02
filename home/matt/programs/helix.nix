{ ... }: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "nightfox";
      editor = {
        line-number = "relative";
        mouse = true;
        rulers = [
          80
          120
        ];
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        file-picker = {
          hidden = false;
        };
        indent-guides = {
          render = true;
        };
      };
    };
  };
}
