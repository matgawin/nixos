{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "";
        email = "";
      };
      aliases = {
        bk = ["bookmark"];
        l = ["log"];
        h = ["help"];
        c = ["commit"];
        d = ["diff"];
        s = ["st"];
        p = ["git" "push"];
        pu = ["git" "pull"];
      };
      ui = {
        default-command = ["st"];
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
      templates = {
        draft_commit_description = ''
          concat(
            surround(
                "\nJJ: This commit contains the following changes:\n", "",
                indent("JJ:     ", diff.stat(72)),
            ),
            "\nJJ: ignore-rest\n",
            diff.git(),
          )
        '';
      };
    };
  };
}
