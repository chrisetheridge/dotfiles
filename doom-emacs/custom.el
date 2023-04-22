(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cider-redirect-server-output-to-repl nil)
 '(custom-safe-themes
   '("d68c9ccf19deeda80f99efdd3a05ad6de8b8fb209e91e4f45cbccbe102e77872" "c4063322b5011829f7fdd7509979b5823e8eea2abf1fe5572ec4b7af1dd78519" "1704976a1797342a1b4ea7a75bdbb3be1569f4619134341bd5a4c1cfb16abad4" "db5b906ccc66db25ccd23fc531a213a1afb500d717125d526d8ff67df768f2fc" default))
 '(hl-todo-keyword-faces
   '(("TODO" warning bold)
     ("FIXME" error bold)
     ("HACK" font-lock-constant-face bold)
     ("REVIEW" font-lock-keyword-face bold)
     ("DEPRECATED" font-lock-doc-face bold)
     ("NOTE" success bold)
     ("BUG" error bold)
     ("XXX" font-lock-constant-face bold)
     ("todo" warning bold)))
 '(package-selected-packages
   '(lsp-treemacs flycheck-clojure autothemer flycheck-clj-kondo tree-sitter-langs clj-decompiler smex))
 '(safe-local-variable-values
   '((cider-ns-refresh-after-fn . "cognician.server-daemon/start-web")
     (cider-ns-refresh-before-fn . "cognician.server-daemon/stop-web"))))
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
(put 'customize-group 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ts-fold-replacement-face ((t (:foreground unspecified :box nil :inherit font-lock-comment-face :weight light)))))
