{
  programs.git = {
    enable = true;
    userName = "";
    userEmail = "";

    aliases = {
      hist = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
      out = "log @{u}..";
      last = "log -1 HEAD";
      prev = "diff HEAD~1 --staged";

      la = "config --get-regexp ^alias";

      h = "help";
      s = "status";
      f = "fetch";
      p = "pull";
      pu = "push";
      d = "diff";
      ds = "diff --staged";
      l = "log";

      c = "commit";
      ca = "commit --amend";

      sw = "switch --ignore-other-worktrees";

      rb = "rebase";
      rbi = "rebase -i";
      rbc = "rebase --continue";
      rba = "rebase --abort";

      rt = "restore";
      rts = "restore --staged";

      unstage = "reset HEAD --";
      undo = "reset HEAD~1 --soft";
      redo = "reset 'HEAD@{1}' --soft"; # use only immediately after undo

      qs = "commit -a -m 'WIP: quick save' -n";

      ui = "!lazygit";
    };

    extraConfig = {
      advice = {
        detachedhead = false;
      };
      column = {
        ui = "auto";
      };
      color = {
        ui = true;
      };
      commit = {
        verbose = true;
      };
      core = {
        autocrlf = false;
        longpaths = true;
        pager = "bat";
      };
      branch = {
        sort = "committerdate";
      };
      diff = {
        algorithm = "histogram";
        colormoved = "plain";
        mnemonicprefix = true;
        renames = true;
        submodule = "log";
      };
      feature = {
        experimental = true;
      };
      fetch = {
        prune = true;
      };
      format = {
        pretty = "fuller";
      };
      help = {
        autocorrect = "prompt";
      };
      log = {
        data = "iso-local";
      };
      merge = {
        conflictstyle = "zdiff3";
      };
      pull = {
        rebase = true;
      };
      push = {
        autosetupremote = true;
        default = "current";
        useforceifincludes = true;
      };
      rebase = {
        autostash = true;
      };
      rerere = {
        enabled = true;
      };
      safe = {
        directory = "*";
      };
      stash = {
        showpatch = true;
      };
      status = {
        submodulesummary = true;
        showstash = true;
      };
      tag = {
        sort = "version:refname";
      };
    };
    ignores = [
      ".jj"
      ".direnv"
      "result"
    ];
  };
  programs.git-cliff.enable = true;
}
