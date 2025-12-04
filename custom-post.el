;;; custom-post.el --- Configuration overrides for Centaur Emacs
;;; Commentary:
;; 1. FORCE DISABLE VERTICO POSFRAME (CHILDFRAME)
;; We use 'with-eval-after-load' to wait until vertico-posframe is actually loaded,
;; then we immediately disable it
;;; Code:
(with-eval-after-load 'vertico-posframe
  (vertico-posframe-mode -1))

(provide 'custom-post)
