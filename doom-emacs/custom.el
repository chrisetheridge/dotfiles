(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("6f4421bf31387397f6710b6f6381c448d1a71944d9e9da4e0057b3fe5d6f2fad" "84b14a0a41bb2728568d40c545280dbe7d6891221e7fbe7c2b1c54a3f5959289" "3d47380bf5aa650e7b8e049e7ae54cdada54d0637e7bac39e4cc6afb44e8463b" "6c98bc9f39e8f8fd6da5b9c74a624cbb3782b4be8abae8fd84cbc43053d7c175" "3d54650e34fa27561eb81fc3ceed504970cc553cfd37f46e8a80ec32254a3ec3" default))
 '(package-selected-packages '(base16-theme))
 '(safe-local-variable-values
   '((format-all-formatters
      ("Clojure" fuck))
     (format-all-formatters
      ("Clojure"
       (cljfmt "--edn" ".cljfmt.edn")))
     (format-all-formatters
      ("Clojure"
       (cljfmt "--edn=.cljfmt.edn")))
     (cider-ns-refresh-after-fn . "dev/start")
     (cider-ns-refresh-before-fn . "dev/stop")
     (cider-ns-refresh-after-fn . "cognician.server-daemon/start-web")
     (cider-ns-refresh-before-fn . "cognician.server-daemon/stop-web")))
 '(warning-suppress-types '((before-save-hook))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'customize-group 'disabled nil)
