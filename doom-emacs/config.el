;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; User
(setq user-full-name "Chris Etheridge"
      user-mail-address "chrise@cognician.com")

;; Visual
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 12))

(setq doom-theme 'doom-nord)

;; Company
(after! company-mode
  (setq company-idle-delay 0.3)
  (setq company-show-numbers t)
  (setq company-tooltip-align-annotations t))

;; windmove
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings 'super))

;; Projectile
(after! projectile
  ;; ignored files
  (setq projectile-globally-ignored-files
        (cl-union projectile-globally-ignored-files
                  '(".DS_Store"
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
                    "resources/public/cljs"
                    ".shadow-cljs/"))))

;; clojure-mode
;; lsp
;; cider
;; flycheck + flycheck-clj-kondo

;; Clojure

(after! clojure-mode
  (setq clojure-align-forms-automatically t)
  (paredit-mode))

;; CIDER (clojure)

(after! cider
  (setq
   cider-repl-pop-to-buffer-on-connect nil
   cider-show-error-buffer nil
   cider-font-lock-reader-conditionals nil
   cider-repl-use-clojure-font-lock t
   cider-font-lock-dynamically t
   cider-save-file-on-load nil
   nrepl-log-messages nil
   cider-show-error-buffer t
   cider-redirect-server-output-to-repl t)
  (require 'flycheck-clj-kondo))

(menu-bar-mode -1)

(after! lsp-mode
  (setq lsp-semantic-tokens-enable nil
        lsp-idle-delay 0.3
        lsp-headerline-breadcrumb-enable nil
        lsp-ui-sideline-enable t
        lsp-file-watch-threshold 5000
        lsp-enable-indentation t
        lsp-ui-doc-show-with-cursor t
        lsp-ui-doc-enhanced-markdown t
        lsp-ui-doc-include-signature t
        lsp-ui-doc-max-height 25
        +format-with-lsp nil))

(after! flycheck-mode
  (setq flycheck-display-errors-delay 1
        flycheck-idle-change-delay 0.3))

;; Keybindings
(global-set-key (kbd "C-k") 'paredit-kill)
(global-set-key (kbd "s-(") 'paredit-wrap-sexp)
(global-set-key (kbd "s-}") 'paredit-wrap-curly)
(global-set-key (kbd "s-[" ) 'paredit-wrap-square)
(global-set-key (kbd "s-r") 'sp-splice-sexp-killing-around)

(global-set-key (kbd "M-s-<right>") 'paredit-forward-slurp-sexp)
(global-set-key (kbd "M-s-<left>") 'paredit-backward-slurp-sexp)

(global-set-key (kbd "C-M-c") 'sp-copy-sexp)
(global-set-key (kbd "C-M-SPC") 'sp-mark-sexp)

(global-set-key (kbd "C-x b") 'ivy-switch-buffer)

(after! counsel
  (setq counsel-rg-base-command "rg -M 200 -C 2 --with-filename --no-heading --line-number %s || true"))

(set-formatter! 'cljfmt '("cljfmt" ("--edn=%s" (concat (projectile-project-root)
                                                       ".cljfmt.edn"))))
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(setq display-line-numbers-type 't)

(after! rust-mode-hook
  (setq lsp-rust-server 'rust-analyzer)
  (setq lsp-rust-analyzer-server-display-inlay-hints t))

;; Copilot

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))
