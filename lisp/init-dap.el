;; init-dap.el --- Initialize DAP configurations.	-*- lexical-binding: t -*-

;; Copyright (C) 2023-2025 Vincent Zhang

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
;; Debug Adapter Protocol (DAP) configurations.
;;

;;; Code:

(eval-when-compile
  (require 'init-const))

(when emacs/>=29p
  (use-package dap-mode
    :bind (("<f5>" . dap-debug)
           ("M-<f5>" . dap-hydra))
    :custom
    (dap-auto-configure-features '(sessions locals controls tooltip))
    :config
    ;; Enable dap-mode globally
    (dap-mode 1)

    ;; Enable dap-ui-mode for additional debugging UI
    (dap-ui-mode 1)

    ;; Enable tooltip support (hover to see variable values)
    (tooltip-mode 1)

    ;; Load the built-in dap-hydra
    (require 'dap-hydra)

    ;; Save buffers on startup, useful for interpreted languages
    (add-hook 'dap-stopped-hook
              (defun dap--save-on-start ()
                (save-some-buffers t t)))

    ;; Display hydra when debugger stops (e.g., at breakpoint)
    (add-hook 'dap-stopped-hook
              (lambda (arg) (call-interactively #'dap-hydra)))))

(provide 'init-dap)

;; (eval-when-compile
;;   (require 'init-const))

;; (when emacs/>=29p
;;   (use-package dap-mode
;;     :bind (("<f5>" . dap-debug)
;;            ("M-<f5>" . dap-hydra/body))
;;     :custom
;;     ;; Enable only the features you want
;;     (dap-auto-configure-features '(sessions locals controls tooltip))
;;     :pretty-hydra
;;     ((:title (pretty-hydra-title "Debug" 'codicon "nf-cod-debug")
;;       :color pink :quit-key ("q" "C-g"))
;;      ("Stepping"
;;       (("n" dap-next "next")
;;        ("s" dap-step-in "step in")
;;        ("o" dap-step-out "step out")
;;        ("c" dap-continue "continue")
;;        ("k" dap-disconnect "disconnect")
;;        ("r" dap-debug-restart "restart")
;;        ("D" dap-delete-session "delete session"))
;;       "Switch"
;;       (("t" dap-switch-thread "thread")
;;        ("w" dap-ui-expressions-add "watch")
;;        ("S" dap-ui-sessions "sessions")
;;        ("R" dap-ui-repl "repl"))
;;       "Breakpoints"
;;       (("b" dap-breakpoint-toggle "toggle")
;;        ("l" dap-breakpoint-log-message "log")
;;        ("e" dap-breakpoint-condition "condition")
;;        ("h" dap-breakpoint-hit-condition "hit count")
;;        ("B" dap-breakpoint-delete-all "clear"))
;;       "Debug"
;;       (("d" dap-debug "debug")
;;        ("E" dap-debug-edit-template "edit template")
;;        ("L" dap-debug-last "debug last")
;;        ("Q" dap-disconnect "quit" :exit t))))
;;     :config
;;     ;; Enable dap-mode globally
;;     (dap-mode 1)

;;     ;; Enable dap-ui-mode for additional debugging UI
;;     (dap-ui-mode 1)

;;     ;; Enable tooltip support (hover to see variable values)
;;     (tooltip-mode 1)

;;     ;; Save buffers on startup, useful for interpreted languages
;;     (add-hook 'dap-stopped-hook
;;               (defun dap--save-on-start ()
;;                 (save-some-buffers t t)))

;;     ;; Display hydra when debugger stops (e.g., at breakpoint)
;;     (add-hook 'dap-stopped-hook
;;               (lambda (arg) (call-interactively #'dap-hydra/body)))))

;; (provide 'init-dap)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-dap.el ends here
