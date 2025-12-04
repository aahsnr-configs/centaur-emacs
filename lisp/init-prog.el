;; init-prog.el --- Initialize programming configurations.	-*- lexical-binding: t -*-

;; Copyright (C) 2006-2025 Vincent Zhang

;; Author: Vincent Zhang <seagle0128@gmail.com>
;; URL: https://github.com/seagle0128/.emacs.d

;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;

;;; Commentary:
;;
;; General programming configurations.
;;

;;; Code:

(eval-when-compile
  (require 'init-const)
  (require 'init-custom))

(declare-function centaur-treesit-available-p "init-funcs")
(declare-function childframe-workable-p "init-funcs")

;; ---------------------------------------------------------------------------
;; Code Display & Utilities
;; ---------------------------------------------------------------------------

;; Prettify Symbols (e.g., display “lambda” as “λ”)
(use-package prog-mode
  :ensure nil
  :hook (prog-mode . prettify-symbols-mode)
  :init
  (setq-default prettify-symbols-alist centaur-prettify-symbols-alist)
  (setq prettify-symbols-unprettify-at-point 'right-edge))

;; Tree-sitter support
(when (centaur-treesit-available-p)
  ;; Automatic Tree-sitter grammar management
  (use-package treesit-auto
    :hook (after-init . global-treesit-auto-mode)
    :init (setq treesit-auto-install 'prompt))

  ;; Code folding indicators using Tree-sitter
  (use-package treesit-fold-indicators
    :ensure treesit-fold
    :hook (after-init . global-treesit-fold-indicators-mode)
    :init (setq treesit-fold-indicators-priority -1)))

;;; Commented out in favor of lsp-mode stuff
;;; Show function arglist or variable docstring
(use-package eldoc
  :ensure nil
  :diminish
  :config
  (when (childframe-workable-p)
    (use-package eldoc-mouse
      :diminish
      :bind (:map eldoc-mouse-mode-map
             ("C-h ." . eldoc-mouse-pop-doc-at-cursor))
      :hook (eglot-managed-mode emacs-lisp-mode)
      :init (setq eldoc-mouse-posframe-border-color (face-background 'posframe-border nil t))
      :config
      (tooltip-mode -1)                 ; Conflict with `track-mouse'
      (add-to-list 'eldoc-mouse-posframe-override-parameters
                   `(background-color . ,(face-background 'tooltip nil t))))))

;; Cross-referencing commands
(use-package xref
  :autoload xref-show-definitions-completing-read
  :bind (("M-g ." . xref-find-definitions)
         ("M-g ," . xref-go-back))
  :init
  ;; Use faster search tool
  (when (executable-find "rg")
    (setq xref-search-program 'ripgrep))

  ;; Select from xref candidates in minibuffer
  (setq xref-show-definitions-function #'xref-show-definitions-completing-read
        xref-show-xrefs-function #'xref-show-definitions-completing-read))

;; ;; Code styles
;; Run commands quickly
(use-package quickrun
  :bind (("C-<f5>" . quickrun)
         ("C-c X"  . quickrun)))

;; Fish shell mode and auto-formatting
(use-package fish-mode
  :commands fish_indent-before-save
  :defines eglot-server-programs
  :hook (fish-mode . (lambda ()
                       "Integrate `fish_indent` formatting with Fish shell mode."
                       (add-hook 'before-save-hook #'fish_indent-before-save)))
  :config
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 '(fish-mode . ("fish-lsp" "start")))))


(use-package envrc
  :hook (after-init . envrc-global-mode))

(provide 'init-prog)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-prog.el ends here
