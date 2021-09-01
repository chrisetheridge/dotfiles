;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; User
(setq user-full-name "Chris Etheridge"
      user-mail-address "chrise@cognician.com")

;; Visual
(setq doom-font (font-spec :family "Fira Code" :size 12))
(setq display-line-numbers-type t)
(setq doom-theme 'doom-flatwhite)

;; Modeline
(display-time-mode 1)
(display-battery-mode 1)
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-enable-word-count t)
(setq doom-modeline-modal-icon t)

;; Org
(setq org-directory "~/org/")

;; Company
(setq company-idle-delay 0.3)
(setq company-show-numbers t)
(setq company-tooltip-align-annotations t)

;; windmove
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings 'super))

;; Projectile
(after! projectile
  ;; ignored files
  (setq projectile-globally-ignored-files
        (cl-union projectile-globally-ignored-files
                  '(".DS_Store"
                    ".lein-repl-history"
                    "*.gz"
                    "*.pyc"
                    "*.png"
                    "*.jpg"
                    "*.jar"
                    "*.retry"
                    "*.svg"
                    "*.tar.gz"
                    "*.tgz"
                    "*.zip")))
  ;; ignored directories
  (setq projectile-globally-ignored-directories
        (cl-union projectile-globally-ignored-directories
                  '(".git"
                    ".ignore"
                    ".cljs_rhino_repl"
                    ".svn"
                    "out"
                    "node_modules"
                    "resources/public/js/compiled"
                    ".shadow-cljs/"))))

;; Clojure
(after! clojure-mode
  (setq clojure-align-forms-automatically t)
  (define-clojure-indent
    ;; Compojure
    (GET 'defun)
    (POST 'defun)
    (context 'defun)
    (cj/GET 'defun)
    (cj/POST 'defun )
    (cj/context 'defun)
    ;; Tufte (profiling)
    (tufte/p 'defun)
    (tufte/profile 'defun)))

;; CIDER (clojure)
(after! cider
  (setq
   cider-repl-pop-to-buffer-on-connect nil
   cider-show-error-buffer nil
   cider-font-lock-reader-conditionals nil
   cider-repl-use-clojure-font-lock t
   cider-font-lock-dynamically t))

;; Keybindings
(global-set-key (kbd "C-k") 'paredit-kill)
(global-set-key (kbd "s-(") 'paredit-wrap-sexp)
(global-set-key (kbd "s-}") 'paredit-wrap-curly)
(global-set-key (kbd "s-[" ) 'paredit-wrap-square)
(global-set-key (kbd "s-r") 'sp-splice-sexp-killing-around)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)

(after! counsel
  (setq counsel-rg-base-command "rg -M 240 -C 2 --with-filename --no-heading --line-number %s || true"))

;; Custom load/switch theme functions
;; Prevents old theme customizations clashing with new theme
;; Also gets around unsafe theme code warning
(defun sw/load-doom-theme (theme)
  "Disable active themes and load a Doom theme."
  (interactive (list (intern (completing-read "Theme: "
                                              (->> (custom-available-themes)
                                                   (-map #'symbol-name)
                                                   (--select (string-prefix-p "doom-" it)))))))
  (ap/switch-theme theme)

  (set-face-foreground 'org-indent (face-background 'default)))

(defun sw/switch-theme (theme)
  "Disable active themes and load THEME."
  (interactive (list (intern (completing-read "Theme: "
                                              (->> (custom-available-themes)
                                                   (-map #'symbol-name))))))
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme theme 'no-confirm))
