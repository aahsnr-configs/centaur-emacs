;; init-evil.el --- Initialize DAP configurations.	-*- lexical-binding: t -*-
;;; Evil configuration
;; Copyright (C) 2023-2025 Vincent Zhang

;;; Code
(use-package evil
  :demand t
  :init
  ;; Core behavior from Doom
  (setq evil-want-C-g-bindings t
        evil-want-C-i-jump nil
        evil-want-C-u-scroll t
        evil-want-C-u-delete t
        evil-want-C-w-delete t
        evil-want-Y-yank-to-eol t
        evil-want-abbrev-expand-on-insert-exit nil
        evil-want-integration t
        evil-want-keybinding nil
        evil-symbol-word-search t

        ;; Cursor appearance
        evil-default-cursor t
        evil-normal-state-cursor 'box
        evil-emacs-state-cursor 'box
        evil-insert-state-cursor 'bar
        evil-visual-state-cursor 'hollow
        evil-replace-state-cursor 'hbar
        evil-operator-state-cursor 'hollow

        ;; Search and highlighting
        evil-ex-search-vim-style-regexp t
        evil-ex-visual-char-range t
        evil-ex-interactive-search-highlight 'selected-window

        ;; Mode line
        evil-mode-line-format nil

        ;; Suppress "beginning/end of line" errors in macros
        evil-kbd-macro-suppress-motion-error t

        ;; Don't move cursor back when exiting insert mode
        evil-move-cursor-back nil

        ;; Fine undo - separate each action
        evil-want-fine-undo t

        ;; Don't move cursor beyond EOL
        evil-move-beyond-eol nil

        ;; Better search wrapping
        evil-search-wrap t
        evil-magic t
        evil-echo-state t
        evil-indent-convert-tabs t
        evil-ex-substitute-global t
        evil-insert-skip-empty-lines t
        evil-v$-excludes-newline t
        evil-respect-visual-line-mode t

        ;; Split window behavior
        evil-split-window-below t
        evil-vsplit-window-right t

        ;; Doom-specific: don't clobber the region on C-u
        evil-want-C-u-delete t

        ;; More vim-like behavior
        evil-want-Y-yank-to-eol t
        evil-want-fine-undo t)

  :config
  (evil-mode 1)
  (evil-select-search-module 'evil-search-module 'evil-search)

  ;; Set shift width
  (setq-default evil-shift-width tab-width)

  ;; Make evil-mode play nice with custom modes
  (evil-set-initial-state 'special-mode 'motion)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)

  ;; Don't interfere with localleader key
  (define-key evil-motion-state-map "\\" nil)

  ;; Make movement keys work on visual lines
  (define-key evil-motion-state-map "j" 'evil-next-visual-line)
  (define-key evil-motion-state-map "k" 'evil-previous-visual-line)
  (define-key evil-motion-state-map "gj" 'evil-next-line)
  (define-key evil-motion-state-map "gk" 'evil-previous-line))

(use-package evil-collection
  :after evil
  :init
  (setq evil-collection-setup-minibuffer t
        evil-collection-want-unimpaired-p nil)
  :config
  (evil-collection-init))

(use-package evil-nerd-commenter :after evil)
(use-package evil-numbers :after evil)
(use-package evil-args :after evil)
(use-package evil-anzu  :after evil)
(use-package evil-exchange :after evil :config (evil-exchange-install))
(use-package evil-indent-plus :after evil :config (evil-indent-plus-default-bindings))
(use-package evil-visualstar :hook (evil-mode . global-evil-visualstar-mode))
(use-package evil-snipe :after evil :config (evil-snipe-mode 1) (evil-snipe-override-mode 1))

(use-package evil-lion
  :after evil
  :hook (prog-mode . evil-lion-mode))

(use-package evil-multiedit :after evil :config (evil-multiedit-default-keybinds))
(use-package evil-goggles :hook (evil-mode . evil-goggles-mode) :custom (evil-goggles-duration 0.1))

(use-package goto-chg
  :after evil
  :commands (goto-last-change goto-last-change-reverse)
  :config
  (evil-define-key 'normal 'global (kbd "g;") 'goto-last-change)
  (evil-define-key 'normal 'global (kbd "g,") 'goto-last-change-reverse))

;; evil-quickscope: Visual aid for f/F/t/T motions
(use-package evil-quickscope
  :after evil
  :hook (prog-mode . turn-on-evil-quickscope-mode)
  :custom
  (evil-quickscope-cross-lines t)
  (evil-quickscope-accepted-chars "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"))

(use-package evil-surround
  :after evil
  :commands global-evil-surround-mode
  :custom
  (evil-surround-pairs-alist
   '((?\( . ("(" . ")"))
     (?\[ . ("[" . "]"))
     (?\{ . ("{" . "}"))

     (?\) . ("(" . ")"))
     (?\] . ("[" . "]"))
     (?\} . ("{" . "}"))

     (?< . ("<" . ">"))
     (?> . ("<" . ">"))))
  :hook (after-init . global-evil-surround-mode))

(use-package evil-matchit
  :after evil
  :config
  (global-evil-matchit-mode 1))

(use-package evil-textobj-anyblock
  :after evil
  :config
  (define-key evil-inner-text-objects-map "b" 'evil-textobj-anyblock-inner-block)
  (define-key evil-outer-text-objects-map "b" 'evil-textobj-anyblock-a-block))

(use-package evil-embrace
  :after evil-surround
  :config
  (evil-embrace-enable-evil-surround-integration))

(provide 'init-evil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-evil.el ends here
