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
   cider-font-lock-dynamically t
   cider-save-file-on-load t
   nrepl-log-messages t
   cider-redirect-server-output-to-repl nil
   cider-print-fn nil))


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

;; (require 'nano)

(require 'nano-base-colors)
(require 'nano-faces)

;; (require 'nano-theme-light)
(require 'nano-theme-dark)
(require 'nano-theme)
(require 'nano-help)
(require 'nano-splash)
(require 'nano-modeline)
(require 'nano-layout)
;; (require 'nano-defaults)
(require 'nano-session)
;; (require 'nano-bindings)
(require 'nano-counsel)
(require 'nano-colors)
;; (require 'nano-minibuffer)

(setq nano-font-family-monospaced "Roboto Mono")
(setq nano-font-family-proportional "Roboto Mono")
(setq nano-font-size 12)

(defun nano-theme-overrides ()
  (set-face-attribute 'cursor nil
                      :background (face-foreground 'nano-face-default))
  (set-face-attribute 'window-divider nil
                      :foreground (face-background 'nano-face-default))
  (set-face-attribute 'window-divider-first-pixel nil
                      :foreground nano-color-background)
  (set-face-attribute 'window-divider-last-pixel nil
                      :foreground nano-color-background)
  (set-face-foreground 'vertical-border nano-color-subtle)

  (set-face-attribute 'mode-line nil
                      :foreground (if (display-graphic-p)
                                      (face-background 'nano-face-default)
                                    (face-foreground 'nano-face-default))
                      :background (face-background 'nano-face-default)
                      :underline  (if (display-graphic-p)
                                      (face-background 'nano-face-subtle)
                                    t)
                      :overline nil
                      :box nil)

  (set-face-attribute 'mode-line-inactive nil
                      :foreground (if (display-graphic-p)
                                      (face-background 'nano-face-default)
                                    (face-foreground 'nano-face-default))
                      :background (face-background 'nano-face-default)
                      :underline (if (display-graphic-p)
                                     (face-background 'nano-face-subtle)
                                   t)
                      :overline nil
                      :inherit nil
                      :box nil))

(nano-faces)
;; (nano-theme-set-dark)
;; (nano-theme)

(custom-set-faces!
  '(window-divider :foreground "#2E3440")
  '(window-divider-first-pixel :foreground "#2E3440")
  '(window-divider-last-pixel :foreground "#2E3440")
  '(mode-line :foreground "#2E3440"
              :background "#2E3440"
              :underline "#434C5E"
              :overline nil
              :box nil )
  '(mode-line-inactive :foreground "#2E3440"
                       :background "#2E3440"
                       :underline "#434C5E"
                       :overline nil
                       :inherit nil
                       :box nil)
  '(header-line :weight light
                :foreground "#2E3440"
                :background "#2E3440"
                :overline nil
                :underline nil
                :box nil
                :inherit nil))

;; No startup  screen
(setq inhibit-startup-screen t)

;; No startup message
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)

;; No message in scratch buffer
(setq initial-scratch-message nil)

;; Initial buffer
(setq initial-buffer-choice nil)

;; No frame title
(setq frame-title-format nil)

;; No file dialog
(setq use-file-dialog nil)

;; No dialog box
(setq use-dialog-box nil)

;; No popup windows
(setq pop-up-windows nil)

;; No empty line indicators
(setq indicate-empty-lines nil)

;; No cursor in inactive windows
(setq cursor-in-non-selected-windows nil)

;; Text mode is initial mode
(setq initial-major-mode 'text-mode)

;; Text mode is default major mode
(setq default-major-mode 'text-mode)

;; Moderate font lock
(setq font-lock-maximum-decoration nil)

;; No limit on font lock
(setq font-lock-maximum-size nil)

;; No line break space points
(setq auto-fill-mode nil)

;; Fill column at 80
(setq fill-column 80)

;; No confirmation for visiting non-existent files
(setq confirm-nonexistent-file-or-buffer nil)

;; Completion style, see
;; gnu.org/software/emacs/manual/html_node/emacs/Completion-Styles.html
(setq completion-styles '(basic substring))

;; Use RET to open org-mode links, including those in quick-help.org
(setq org-return-follows-link t)

;; Mouse active in terminal
(unless (display-graphic-p)
  (xterm-mouse-mode 1)
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line))

;; No scroll bars
(if (fboundp 'scroll-bar-mode) (set-scroll-bar-mode nil))

;; No toolbar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; No menu bar
(if (display-graphic-p)
    (menu-bar-mode t) ;; When nil, focus problem on OSX
  (menu-bar-mode -1))

;; Navigate windows using shift+direction
;; (windmove-default-keybindings)

;; Tab behavior
;; (setq tab-always-indent 'complete)
;; (global-company-mode)
;; (define-key company-mode-map [remap indent-for-tab-command]
;;   #'company-indent-or-complete-common)

;; Pixel scroll (as opposed to char scrool)
;; (pixel-scroll-mode t)

;; Make sure clipboard works properly in tty mode on OSX
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(when (and (not (display-graphic-p))
           (eq system-type 'darwin))
    (setq interprogram-cut-function 'paste-to-osx)
    (setq interprogram-paste-function 'copy-from-osx))

;; y/n for  answering yes/no questions
(fset 'yes-or-no-p 'y-or-n-p)

;; No tabs
(setq-default indent-tabs-mode nil)

;; Tab.space equivalence
(setq-default tab-width 4)

;; Size of temporary buffers
(temp-buffer-resize-mode)
(setq temp-buffer-max-height 8)

;; Minimum window height
(setq window-min-height 1)

;; Buffer encoding
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment   'utf-8)

;; Unique buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse
      uniquify-separator " • "
      uniquify-after-kill-buffer-p t
      uniquify-ignore-buffers-re "^\\*")

;; Default shell in term
(unless (eq system-type 'windows-nt)
  (setq-default shell-file-name "/bin/zsh")
  (setq explicit-shell-file-name "/bin/zsh"))

;; Kill term buffer when exiting
(defadvice term-sentinel (around my-advice-term-sentinel (proc msg))
  (if (memq (process-status proc) '(signal exit))
      (let ((buffer (process-buffer proc)))
        ad-do-it
        (kill-buffer buffer))
    ad-do-it))

(ad-activate 'term-sentinel)

(setq lsp-file-watch-threshold 10000
      lsp-enable-indentation nil
      lsp-ui-doc-show-with-cursor t
      lsp-ui-doc-enhanced-markdown t
      lsp-ui-doc-include-signature t
      lsp-ui-doc-max-height 20)

(setq display-line-numbers-type 'relative)

(setq lsp-rust-server 'rust-analyzer)

(setq lsp-rust-analyzer-server-display-inlay-hints t)
