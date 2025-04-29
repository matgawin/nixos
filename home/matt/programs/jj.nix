{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "";
        email = "";
      };
      aliases = {
        bk = [ "bookmark" ];
        l = [ "log" ];
        h = [ "help" ];
        c = [ "commit" ];
        d = [ "diff" ];
        s = [ "st" ];
      };
      ui = {
        default-command = [ "st" ];
        pager = "bat";
        paginate = "auto";
      };
      ui.streampager = {
        interface = "quit-if-one-page";
      };
      revsets = {
        log = "present(@) | ancestors(immutable_heads().., 10) | present(trunk())";
      };
      template-aliases = {
        "format_short_signature(signature)" = "signature.name()";
      };
    };
  };
}
