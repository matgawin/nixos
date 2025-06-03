{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "";
        email = "";
      };
      revset-aliases = {
        "immutable_heads()" = "tags() | untracked_remote_bookmarks() | (trunk().. & ~mine())";
        "closest_bookmark(to)" = "heads(::to & bookmarks())";
      };
      aliases = {
        bk = ["bookmark"];
        c = ["commit"];
        d = ["diff"];
        ds = ["describe"];
        h = ["help"];

        l = ["log"];
        lf = ["log" "-T" "builtin_log_compact_full_description"];
        ll = ["log" "-T" "builtin_log_compact" "-r" "all()"];
        ls = ["log" "-n" "5"];
        lss = ["log" "-T" "change_id.shortest(4) ++ \" \" ++ description.first_line()" "-n" "10"];

        p = ["git" "push"];
        pa = ["git" "push" "--allow-new"];
        pi = ["git" "push" "--ignore-immutable"];
        pu = ["git" "pull"];

        s = ["st"];
        tug = ["bookmark" "move" "--from" "closest_bookmark(@-)" "--to" "@-"];

        w = ["workspace"];
        wl = ["workspace" "list"];
      };
      snapshot = {
        "max-new-file-size" = "10MiB";
      };
      ui = {
        default-command = ["st"];
        pager = "bat --style=numbers";
        paginate = "auto";
      };
      ui.streampager = {
        interface = "quit-if-one-page";
      };
      revsets = {
        log = "present(@) | ancestors(immutable_heads().., 10) | present(trunk())";
        "short-prefixes" = "(@ | parents(@, 5):: | heads(bookmarks() | mutable())) & ~immutable_heads()";
      };
      template-aliases = {
        "format_short_signature(signature)" = "signature.email().local()";
        "format_short_id(id)" = "id.shortest(6)";
        "commit_timestamp(commit)" = "commit.committer().timestamp()";
        "format_timestamp(timestamp)" = "timestamp.local().format('%d.%m.%y')";
      };
      templates = {
        draft_commit_description = ''
          concat(
            coalesce(description, default_commit_description, "\n"),
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
