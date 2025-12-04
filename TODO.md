# TODOs
## Pretasks
- [ ] **Centaur Emacs** Need to determine which files I have changed and which modules I have omitted; compare with fork for the task

## Core Tasks for Centaur Emacs
- [ ] Use both flycheck, apheleia with lsp-mode; keep eglot in init-lsp.el to avoid errors
- [ ] Integrate modules from scimax - these modules must not be changed
- [ ] Completely refactor init-org.el module making sure it integrates with scimax modules
- [ ] Create an init-keymaps.el module and start replacing keybindings in centaur emacs using general.el

## Files/Modules - Centaur Emacs
- [ ] init.el [Changed]
- [ ] init-ai.el
- [x] init-base.el
- [x] init-bookmark.el
- [ ] init-c.el
- [ ] init-calendar.el
- [x] init-check.el [Changed]
    - [ ] replace flymake with flycheck
- [-] init-completion.el
    - [ ] May need to change certain keybindings
- [x] init-const.el
- [x] init-custom.el
- [ ] init-dap.el
- [x] init-dashboard.el
- [ ] init-dict.el
- [x] init-dired.el
- [ ] init-docker.el
- [-] init-edit.el
    - [ ] Use doom emacs like keybindings and general keybindings
    - [ ] Replace flyspell with jinx
    - [ ] Replace vundo with undo-fu-session and edit to evil to use it
- [x] init-elisp.el
- [ ] init-elixir.el
- [ ] init-eshell.el
- [ ] init-evil.el
- [x] init-funcs.el
- [ ] init-go.el
- [x] init-highlight.el
- [-] init-hydra.el
     - [ ] change the keybinding for toggles-body/hydra
- [-] init-ibuffer.el
     - [ ] change keybinding for launching ibuffer
- [-] init-kill-ring.el
- [ ] init-lsp.el
     - [ ] make sure it does not conflict with scimax
- [x] init-markdown.el
- [-] init-org.el
     - [ ] need to make a lot of changes suited to my needs
- [x] init-package.el
- [ ] init-player.el
- [ ] init-prog.el
- [x] init-python.el
- [x] init-reader.el
- [ ] init-ruby.el
- [ ] init-rust.el
- [ ] init-shell.el
- [-] init-snippet.el
     - [ ] do I need eglot integration using yasnippet-capf
- [-] init-treemacs.el
     - [ ] add doom emacs like or mnemonic keybindings using general.el
     - [ ] fix weird fonts in treemacs side window
- [-] init-ui.el
      - [ ] set doom like keybindings for default-text-scale
- [x] init-utils.el
- [x] init-vcs.el
- [ ] init-web.el
- [-] init-window.el
      - [ ] integrate with flycheck instead of flymake
      - [ ] add evil inspired keybindings for window management
- [x] init-workspace.el

## Needed Modules - Scimax 
- [ ] scimax-jinx.el
- [ ] words.el
- [ ] scimax-md.el
- [ ] scimax-lob.el

# Issue
- [ ] **Important**: eval-when-compile error - probably due to a missing required module in *init.el*
