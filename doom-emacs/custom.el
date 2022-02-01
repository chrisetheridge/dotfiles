(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
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
