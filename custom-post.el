;;; custom-post.el --- Configuration overrides for Centaur Emacs
;;; Commentary:
;; 1. FORCE DISABLE VERTICO POSFRAME (CHILDFRAME)
;; We use 'with-eval-after-load' to wait until vertico-posframe is actually loaded,
;; then we immediately disable it
;;; Code:
(with-eval-after-load 'vertico-posframe
  (vertico-posframe-mode -1))

(with-eval-after-load 'dashboard
  (defun my/refresh-dashboard-gui ()
    "Refresh the dashboard when a GUI client connects."
    (run-with-timer 0.1 nil
                    (lambda ()
                      (when (display-graphic-p)
                        ;; The only variable we force is the 'permission' to draw icons.
                        ;; All other settings (which icons to draw, which banner to use)
                        ;; differ to what you loaded in 'init-dashboard.el'.
                        (setq dashboard-display-icons-p t)

                        ;; Switch to the dashboard buffer
                        (let ((buffer (get-buffer-create "*dashboard*")))
                          (switch-to-buffer buffer)
                          ;; Force a redraw using the settings from init-dashboard.el
                          (with-current-buffer buffer
                            (dashboard-refresh-buffer)))))))

  ;; Hook this repair function to new client frames
  (add-hook 'server-after-make-frame-hook #'my/refresh-dashboard-gui)

  ;; Ensure dashboard is the default buffer choice
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))))


(provide 'custom-post)
