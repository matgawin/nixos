{pkgs, ...}: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;

    extraPackages = epkgs:
      with epkgs; [
        # Evil mode
        evil
        evil-collection
        evil-surround
        evil-commentary

        # UI improvements
        doom-themes
        doom-modeline
        all-the-icons

        # Completion
        ivy
        counsel
        swiper
        company

        # Git
        magit

        # General utilities
        which-key
        use-package
        general

        # Language support
        nix-mode
        markdown-mode

        # File management
        treemacs
        treemacs-evil
      ];

    extraConfig = ''
      ;; Basic settings
      (setq inhibit-startup-message t)
      (scroll-bar-mode -1)
      (tool-bar-mode -1)
      (tooltip-mode -1)
      (menu-bar-mode -1)
      (set-fringe-mode 10)

      ;; Line numbers
      (global-display-line-numbers-mode t)
      (setq display-line-numbers-type 'relative)

      ;; Theme
      (load-theme 'doom-one t)

      ;; Session management - restore last open files
      (desktop-save-mode 1)
      (setq desktop-dirname "~/.emacs.d/")
      (setq desktop-base-file-name "emacs-desktop")
      (setq desktop-restore-eager 5)  ; restore first 5 buffers immediately
      (setq desktop-lazy-verbose nil)
      (setq desktop-lazy-idle-delay 2)

      ;; Recent files
      (recentf-mode 1)
      (setq recentf-max-menu-items 25)
      (setq recentf-max-saved-items 25)

      ;; Auto-save desktop
      (add-hook 'auto-save-hook (lambda () (desktop-save-in-desktop-dir)))

      ;; Evil mode
      (setq evil-want-integration t)
      (setq evil-want-keybinding nil)
      (setq evil-want-C-u-scroll t)
      (setq evil-want-C-i-jump nil)
      (require 'evil)
      (evil-mode 1)
      (evil-collection-init)

      ;; Doom modeline
      (require 'doom-modeline)
      (doom-modeline-mode 1)

      ;; Ivy completion
      (ivy-mode 1)
      (setq ivy-use-virtual-buffers t)
      (setq enable-recursive-minibuffers t)

      ;; Which-key
      (which-key-mode)

      ;; Company mode
      (add-hook 'after-init-hook 'global-company-mode)

      ;; Key bindings for recent files (Evil mode compatible)
      (evil-leader/set-key
        "fr" 'recentf-open-files)
    '';
  };
}
