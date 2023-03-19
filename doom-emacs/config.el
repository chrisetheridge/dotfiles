;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; User
(setq user-full-name "Chris Etheridge"
      user-mail-address "chrise@cognician.com")

;; Visual
(setq doom-font (font-spec :family "Roboto Mono" :size 12))
(setq display-line-numbers-type t)
(setq doom-theme 'doom-nord)

;; Modeline
(display-time-mode 1)
;; (setq doom-modeline-major-mode-icon t)
;; (setq doom-modeline-enable-word-count t)
;; (setq doom-modeline-modal-icon t)

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
   cider-font-lock-dynamically t
   cider-save-file-on-load t
   nrepl-log-messages nil
   cider-redirect-server-output-to-repl t
   cider-print-fn 'pprint)
  (require 'flycheck-clj-kondo))

(after! lsp-mode
  (setq lsp-semantic-tokens-enable nil
        lsp-idle-delay 0.2
        lsp-diagnostics-provider :none))

(after! flycheck-mode
  (setq flycheck-display-errors-delay 0.1
        flycheck-idle-change-delay 0.1))

(defun cog/cognician-clerk ()
  (interactive)
  (cider-interactive-eval (concat
                           "(nextjournal.clerk/show! (java.io.StringReader. "
                           (format "%S" (buffer-substring-no-properties (point-min) (point-max)))
                           "))")))

;; Keybindings
(global-set-key (kbd "C-k") 'paredit-kill)
(global-set-key (kbd "s-(") 'paredit-wrap-sexp)
(global-set-key (kbd "s-}") 'paredit-wrap-curly)
(global-set-key (kbd "s-[" ) 'paredit-wrap-square)
(global-set-key (kbd "s-r") 'sp-splice-sexp-killing-around)

(global-set-key (kbd "M-s-<right>") 'paredit-forward-slurp-sexp)
(global-set-key (kbd "M-s-<left>") 'paredit-backward-slurp-sexp)

(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-x p")
                 (lambda ()
                   (interactive)
                   (cider-eval-print-last-sexp 't)))

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
  (sw/switch-theme theme))

(defun sw/switch-theme (theme)
  "Disable active themes and load THEME."
  (interactive (list (intern (completing-read "Theme: "
                                              (->> (custom-available-themes)
                                                   (-map #'symbol-name))))))
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme theme 'no-confirm))

(define-key global-map (kbd "<S-down-mouse-1>") 'mouse-save-then-kill)

(set-formatter! 'cljfmt '("cljfmt" ("--edn=%s" (concat (projectile-project-root)
                                                       ".cljfmt.edn"))))

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(setq lsp-file-watch-threshold 10000
      lsp-enable-indentation nil
      lsp-ui-doc-show-with-cursor t
      lsp-ui-doc-enhanced-markdown t
      lsp-ui-doc-include-signature t
      lsp-ui-doc-max-height 20)

(setq display-line-numbers-type 'relative)

(setq lsp-rust-server 'rust-analyzer)

(setq lsp-rust-analyzer-server-display-inlay-hints t)
