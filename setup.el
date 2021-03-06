(use-package ace-jump-mode
  :bind ("s-SPC" . ace-jump-mode))


(use-package ace-window
  :bind ("s-o" . ace-window))


(use-package ahg
  :defer t
  :commands (ahg-status)
  :config
  (progn
    (add-hook 'ahg-status-mode-hook 'turn-on-truncate-lines)
    (bind-keys
     :map ahg-status-mode-map
     ("<tab>" . ahg-status-diff)
     ("M-<delete>" . ahg-status-unmark-all))))


(use-package anaconda-mode
  :defer t
  :config
  (progn
    (bind-keys
     :map anaconda-mode-map
     ("M-?" . anaconda-mode-view-doc)
     ("M-." . anaconda-mode-goto)
     ("M-," . anaconda-nav-pop-marker))))


(use-package arc-mode
  :defer t
  :mode (("\\.egg$" . archive-mode)
         ("\\.\\(war\\|jar\\)$" . archive-mode))
  :config
  (progn
    (add-hook 'archive-mode-hook 'turn-on-truncate-lines)))


(use-package bookmark
  :defer t
  :config
  (progn
    (setq bookmark-save-flag 1
          bmkp-last-as-first-bookmark-file nil)
    (use-package bookmark+)))


(use-package browse-kill-ring
  :defer t
  :commands (browse-kill-ring)
  :config
  (setq browse-kill-ring-quit-action 'save-and-restore)
  :bind ("C-c y" . browse-kill-ring))


;; (use-package browse-url
;;   :config
;;   (when macosp
;;     (setq browse-url-browser-function 'browse-url-default-macosx-browser)))


(use-package bs
  :defer t
  :config
  (progn
    (setq bs-default-configuration       "all"
          bs-alternative-configuration   "files-and-scratch"
          bs-maximal-buffer-name-column  60
          bs-minimal-buffer-name-column  45
          bs-attributes-list '(("" 1 1 left bs--get-marked-string)
                               ("M" 1 1 left bs--get-modified-string)
                               ("R" 2 2 left bs--get-readonly-string)
                               ("Buffer" bs--get-name-length 10 left bs--get-name)
                               ("" 2 2 left "  ")
                               ("File" 12 12 left bs--get-file-name))
          bs-dont-show-regexp (concat
                               "\\*\\("
                               "vc"
                               "\\|cvs-commit"
                               "\\|python-pylint\\|Pymacs"
                               "\\|Completions"
                               "\\)\\*")))
  :bind (("C-<escape>" . bs-show)
         ("C-<tab>" . bs-show)))


(use-package buffer-move
  :bind (("<C-M-S-up>"    . buf-move-up)
         ("<C-M-S-down>"  . buf-move-down)
         ("<C-M-S-left>"  . buf-move-left)
         ("<C-M-S-right>" . buf-move-right)))


(use-package calc
  :defer t
  :config
  (progn
    (setq calc-display-trail nil)
    (add-hook 'calc-mode-hook
              (lambda ()
                (local-set-key [kp-separator] 'calcDigit-start)))))


(use-package calendar
  :defer t
  :config
  (progn
    (calendar-set-date-style 'iso)

    (add-hook 'diary-display-hook          'fancy-diary-display)
    (add-hook 'today-visible-calendar-hook 'calendar-mark-today)
    (add-hook 'list-diary-entries-hook     'sort-diary-entries t)

    (setq calendar-location-name           "Göteborg, SE"
          calendar-latitude                57.72 ; 57° 43' North
          calendar-longitude               11.97 ; 11° 58' East
          calendar-week-start-day          1
          calendar-offset                  0
          calendar-today-marker            'calendar-today-face
          view-calendar-holidays-initially nil
          calendar-date-display-form       '((format "%s-%02d-%02d"
                                                     year
                                                     (string-to-number month)
                                                     (string-to-number day)))
          view-diary-entries-initially     t
          mark-holidays-in-calendar        t
          mark-diary-entries-in-calendar   t
          calendar-time-display-form       '(24-hours ":" minutes)
          diary-display-hook               'fancy-diary-display
          holidays-in-diary-buffer         t
          diary-list-include-blanks        t
          diary-file                       (expand-file-name "~/.diary")
          calendar-day-name-array
          ["Söndag" "Måndag" "Tisdag" "Onsdag" "Torsdag" "Fredag" "Lördag"]
          calendar-month-name-array
          ["Januari" "Februari" "Mars" "April" "Maj" "Juni"
           "Juli" "Augusti" "September" "Oktober" "November" "December"]
          all-christian-calendar-holidays nil
          general-holidays                nil
          oriental-holidays               nil
          hebrew-holidays                 nil
          islamic-holidays                nil
          swedish-holidays
          ;; Se: http://www.kalender.se
          ;; och: http://hem.passagen.se/farila/holiday.htm
          '((holiday-fixed  1  1    "Nyårsdagen")
            (holiday-fixed  1  6    "Trettondedag jul")
            (holiday-fixed  2 14    "Alla hjärtans dag")
            (holiday-fixed  4 30    "Valborgmässoafton")
            (holiday-fixed  5  1    "Första maj/Valborg")
            (holiday-float  5  0 -1 "Mors dag") ; Sista söndagen i maj
            (holiday-fixed  6  6    "Sveriges nationaldag (svenska flaggans dag)")
            ;; Midsommardagen 2005-06-25
            (holiday-float 11  6  1 "Alla helgons dag") ; Första lördagen i nov.
            (holiday-float 11  0  2 "Fars dag") ; Andra söndagen i november
            (holiday-fixed 12 10    "Nobeldagen")
            (holiday-fixed 12 25    "Juldagen")
            (holiday-fixed 12 26    "Annandag jul")
            (holiday-advent 0 "Första advent")
            (holiday-easter-etc -2 "Långfredag")
            (holiday-easter-etc 0  "Påskdagen")
            (holiday-easter-etc 1  "Annandag påsk")
            (holiday-easter-etc 39 "Kristi himmelsfärds dag")
            (holiday-easter-etc 49 "Pingstdagen")
            (holiday-easter-etc 50 "Annandag pingst"))
          calendar-holidays
          (append
           general-holidays
           local-holidays
           other-holidays
           christian-holidays
           solar-holidays
           swedish-holidays))))


(use-package cc-mode
  :defer t
  :config
  (progn
    (add-hook 'c-mode-hook 'setup--c-mode-hook)
    (add-hook 'c++-mode-hook 'setup--c-mode-hook)

    (defconst setup--c-style
      `((c-recognize-knr-p . nil)
        (c-enable-xemacs-performance-kludge-p . t) ; speed up indentation in XEmacs
        ;;(c-echo-syntactic-information-p . t)
        ;;(c-basic-offset . 2)
        (c-comment-only-line-offset 0 . 0)
        (c-tab-always-indent . t)
        (c-indent-comments-syntactically-p . nil)
        (comment-column . 40)

        (c-cleanup-list . (;;brace-else-brace
                           ;;brace-elseif-brace
                           ;;brace-catch-brace
                           empty-defun-braces
                           defun-close-semi
                           list-close-comma
                           scope-operator))

        (c-offsets-alist . ((access-label          . -)
                            (arglist-close         . 0)
                            (arglist-intro         . +)
                            (brace-list-open       . +)
                            (case-label            . 0)
                            (func-decl-cont        . c-lineup-java-throws)
                            (inher-cont            . c-lineup-java-inher)
                            (inline-open           . 0)
                            (innamespace           . +)
                            (knr-argdecl           . 0)
                            (knr-argdecl-intro     . 0)
                            (label                 . *)
                            (namespace-open        . [0])
                            (namespace-close       . [0])
                            (statement-block-intro . +)
                            (statement-case-open   . +)
                            (statement-cont
                             .
                             (,(when (fboundp 'c-no-indent-after-java-annotations)
                                 'c-no-indent-after-java-annotations)
                              ,(when (fboundp 'c-lineup-assignments)
                                 'c-lineup-assignments)
                              +))
                            (stream-op             . c-lineup-streamop)
                            (substatement-label    . 0)
                            (substatement-open     . +)
                            (topmost-intro         . 0)
                            )))
      "C/C++ programming style.")

    (defun setup--set-c-style ()
      "Set the current buffer's c-style."
      (interactive)
      (make-local-variable 'c-tab-always-indent)
      (setq c-tab-always-indent t)
      (c-add-style "c-c++-style" setup--c-style t)
      (setq c-basic-offset 4))

    (defun setup--c-mode-hook ()
      (which-function-mode 1)
      (subword-mode 1)

      (setup--set-c-style)
      ;; (google-set-c-style)

      (set (make-local-variable 'compile-command)
           (concat "gmake -C " default-directory " all"))

      (c-toggle-electric-state -1)
      (c-toggle-auto-newline -1)
      ;; (c-toggle-hungry-state 1)
      (abbrev-mode 0)

      ;; (setq cppcm-debug nil
      ;;       cppcm-build-dirname "target/build-x86_64-linux-6-optimize")

      (require 'cpputils-cmake)
      (cppcm-reload-all)

      (setq-local eldoc-documentation-function #'ggtags-eldoc-function)
      (ggtags-mode 1)

      (eldoc-mode 1)

      (local-set-key (kbd "C-c C-g")
                     (lambda ()
                       (interactive)
                       (gud-gdb (concat "gdb --fullname " (cppcm-get-exe-path-current-buffer)))))

      (local-set-key (kbd "C-.") 'company-complete)
      (local-set-key (kbd "C-c o") 'ff-find-other-file)))
  :mode (("\\.[ch]$" . c-mode)
         ("\\.\\(cc\\|hh\\)$" . c++-mode)
         ("\\.\\(i\\|swg\\)$" . c++-mode)))


(use-package cmake-mode
  :defer t)


(use-package company
  :defer 5
  :config
  (progn
    (global-company-mode)
    (bind-key [remap completion-at-point] #'company-complete company-mode-map)
    (setq company-tooltip-align-annotations t
          company-show-numbers t)
    (add-to-list 'company-backends 'company-tern))
  :diminish company-mode)


(use-package company-anaconda
  :defer t
  :init
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-anaconda)))


(use-package company-c-headers
  :defer t
  :init
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-c-headers)))
;; (add-to-list 'company-c-headers-path-system "/usr/include/boost1.42")
;; (add-to-list 'company-c-headers-path-system "")
;; (add-to-list 'company-c-headers-path-system "")


(use-package cperl-mode
  :defer t
  :config
  (progn
    (defalias 'perl-mode 'cperl-mode)
    (fset 'perldoc 'cperl-perldoc)
    (setq interpreter-mode-alist
          (append '(("perl"     . perl-mode)
                    ("perl5"    . perl-mode)
                    ("miniperl" . perl-mode))
                  interpreter-mode-alist))

    (setq perl-indent-level                2
          perl-continued-statement-offset  2
          perl-continued-brace-offset      0
          perl-brace-offset                0
          perl-brace-imaginary-offset      0
          perl-label-offset               -2)

    (setq cperl-indent-level                2
          cperl-continued-statement-offset  2
          cperl-continued-brace-offset      0
          cperl-brace-offset                0
          cperl-brace-imaginary-offset      0
          cperl-label-offset               -2
          cperl-electric-keywords           t
          cperl-electric-parens             nil
          cperl-merge-trailing-else         nil
          cperl-under-as-char               t
          cperl-invalid-face                nil)))


(use-package css-mode
  :defer t
  :config
  (progn
    (setq cssm-indent-function 'cssm-c-style-indenter
          css-indent-level 2
          scss-compile-at-save nil)
    (add-hook 'css-mode-hook 'turn-on-rainbow-mode))
  :mode (("\\.css$" . css-mode)))


(use-package compile
  :bind (("C-c c" . compile)
         ("C-c C" . recompile))
  :config
  (progn
    (setq-default compilation-always-kill nil
                  compilation-ask-about-save t
                  compilation-scroll-output 'first-error
                  compilation-window-height 20
                  compile-command (concat "gmake -C " default-directory " all"))

    ;;(add-hook 'compilation-mode-hook 'toggle-truncate-lines)
    (add-hook 'compilation-mode-hook 'compilation-recenter-end-enable)))


;; (use-package diff-hl
;;   :init
;;   (progn
;;     (global-diff-hl-mode)))


(use-package diff-mode
  :defer t
  :commands diff-mode
  :config
  (progn
    (setq-default diff-switches "-uwd")

    (add-hook 'diff-mode-hook 'setup--diff-mode)

    (defun setup--diff-mode ()
      "diff-mode setup."
      (whitespace-mode 1))

    (bind-keys
     :map diff-mode-map
     ("w" . diff-ignore-whitespace-hunk)
     ("n" . diff-hunk-next)
     ("p" . diff-hunk-prev))))


(use-package dired
  :defer t
  :commands (dired-jump)
  :config
  (progn
    (setq dired-auto-revert-buffer t ; revert Dired buffer on revisiting
          dired-details-hidden-string ""
          dired-details-hide-link-targets nil
          dired-details-initially-hide nil
          dired-dwim-target t
          dired-listing-switches "-alhF"
          dired-ls-F-marks-symlinks t
          dired-omit-files "^\\.[^.]"
          dired-recursive-copies 'always
          dired-recursive-deletes 'top
          wdired-allow-to-change-permissions t)

    (use-package dired-x)
    (use-package dired-sort-menu+)
    (use-package dired-details
      :config (dired-details-install))

    (defun setup--dired-mode ()
      (dired-omit-mode 1)
      (turn-on-truncate-lines)
      (local-set-key (kbd "M-o") 'dired-omit-mode)
      (local-set-key (kbd "T")   'dired-do-touch))

    (add-hook 'dired-mode-hook 'setup--dired-mode)

    (unless (boundp 'dired-guess-shell-alist-user)
      (setq dired-guess-shell-alist-user '()))

    (cond
     (linuxp
      (add-to-list 'dired-guess-shell-alist-user
                   '("\\.\\(jpe?g\\|gif\\|png\\)\\'" "feh -drF --sort filename -D5 * &"))
      (add-to-list 'dired-guess-shell-alist-user
                   '("\\.\\(avi\\|mpg\\|wmv\\|mp4\\|mov\\|m4v\\)\\'" "mplayer -really-quiet * &"))
      (add-to-list 'dired-guess-shell-alist-user
                   '("\\.pdf\\'" "acroread * &" "evince * &"))
      (add-to-list 'dired-guess-shell-alist-user
                   '("\\.epub\\'" "FBReader * &" "evince * &"))))))


(use-package ediff
  :defer t
  :config
  (progn
    (setq-default ediff-ignore-similar-regions t)
    (setq ediff-window-setup-function 'ediff-setup-windows-plain
          ediff-split-window-function (lambda (&optional arg)
                                        (if (> (frame-width) 150)
                                            (split-window-horizontally arg)
                                          (split-window-vertically arg))))))


(use-package edit-env
  :commands (edit-env))


(use-package expand-region
  :bind (("C-+" . er/expand-region)
         ("C-?" . er/contract-region)))


(use-package find-dired
  :bind (("M-s D" . find-dired)
         ("M-s d" . find-grep-dired)
         ("M-s n" . find-name-dired)))


(use-package framemove
  :init
  (progn
    (windmove-default-keybindings 'shift)
    ;; Cannot wrap and have framemove do its thing at the same time.
    (setq windmove-wrap-around nil
          framemove-hook-into-windmove t)))


(use-package ggtags
  :commands ggtags-mode
  :diminish ggtags-mode)


(use-package gradle-mode
  :mode ("\\.gradle$" . gradle-mode))


(use-package grep
  :defer t
  :bind (("M-s f" . find-grep)
         ("M-s g" . grep)
         ("M-s r" . rgrep))
  :init
  (progn
    (setq grep-files-aliases
      '(("el" .    "*.el")
        ("c" .     "*.c")
        ("h" .     "*.h")
        ("cc" .    "*.hh *.hpp *.cc *.cpp")
        ("hh" .    "*.hh *.hpp *.cc *.cpp")))
    )
  :config
  (progn
    (grep-apply-setting 'grep-command "egrep -nH -e ")
    (grep-apply-setting
     'grep-find-command
     '("find . -type f -print0 | xargs -P4 -0 egrep -nH -e " . 52))

    (add-hook 'grep-mode-hook 'turn-on-truncate-lines)

    (add-to-list 'grep-find-ignored-directories "elpa")
    (add-to-list 'grep-find-ignored-directories "target")
    (add-to-list 'grep-find-ignored-directories "vendor")

    (use-package grep-a-lot
      :config (grep-a-lot-setup-keys))

    (let ((find-command "find . \\( -path '*/CVS' -o -path '*/.hg' -o -path '*/.git' \\) -prune -o -type f -print0"))
      (if macosp
          (setq grep-find-command
                (concat find-command " | xargs -0 " grep-command))
        (setq grep-find-command
              (concat find-command " | xargs -0 -e " grep-command))))))


(use-package groovy-mode
  :mode (("\\.grovvy$" . groovy-mode)
         ("\\.gradle$" . groovy-mode)))


(use-package gud
  :defer t
  :config
  (setq-default gdb-many-windows t
                gdb-use-separate-io-buffer t
                gud-tooltip-mode t))


(use-package hl-line
  :init
  (progn
    (use-package hl-line+)
    (global-hl-line-mode t)))


(use-package hl-tags-mode
  :commands (hl-tags-mode))


(use-package ibuffer
  :bind (([remap list-buffers] . ibuffer))
  :config (setq ibuffer-formats
                '((mark modified read-only vc-status-mini " "
                        (name 18 18 :left :elide)
                        " "
                        (size 9 -1 :right)
                        " "
                        (mode 16 16 :left :elide)
                        " "
                        (vc-status 16 16 :left)
                        " "
                        filename-and-process)
                  (mark modified read-only " "
                        (name 18 18 :left :elide)
                        " "
                        (size 9 -1 :right)
                        " "
                        (mode 16 16 :left :elide)
                        " " filename-and-process)
                  (mark " "
                        (name 16 -1)
                        " " filename))))


(use-package ibuffer-vc
  :defer t
  :init (add-hook 'ibuffer-hook
                  (lambda ()
                    (ibuffer-vc-set-filter-groups-by-vc-root)
                    (unless (eq ibuffer-sorting-mode 'alphabetic)
                      (ibuffer-do-sort-by-alphabetic)))))


(use-package iedit
  :bind ("M-RET" . iedit-mode))


;; (use-package ido
;;   :defer t
;;   :config
;;   (progn
;;     (use-package ido-hacks
;;       :init
;;       (ido-hacks-mode 1))
;;     (use-package flx-ido)
;;     ;; (use-package ido-ubiquitous)
;;     ;; (use-package ido-vertical-mode)
;;     (setq ido-use-faces t            ; I want to see the flx matches.
;;           ido-use-filename-at-point nil
;;           ido-vertical-define-keys 'C-n-C-p-up-down-left-right)
;;     (ido-mode 1)
;;     (flx-ido-mode 1)))
;;     ;; (ido-vertical-mode 1)
;;     ;;(ido-ubiquitous)))


(when (fboundp 'isearch-mode)
  (defun isearch--yank-current-word ()
    "Pull current word from buffer into search string."
    (interactive)
    (save-excursion
      (skip-syntax-backward "w_")
      (isearch-yank-internal
       (lambda ()
         (skip-syntax-forward "w_")
         (point)))))
  (bind-keys
   :map isearch-mode-map
   ("C-e" . isearch--yank-current-word)
   ("C-c" . isearch-toggle-case-fold)
   ("C-t" . isearch-toggle-regexp)
   ("C-^" . isearch-edit-string)))


(use-package ispell
  :defer t
  :bind (("C-c s b" . ispell-buffer)
         ("C-c s c" . ispell-comments-and-strings)
         ("C-c s d" . ispell-change-dictionary)
         ("C-c s r" . ispell-region)
         ("C-c s w" . ispell-word))
  :config
  (setq ispell-program-name "aspell"
        ispell-local-dictionary "english"
        ispell-silently-savep t
        ispell-help-in-bufferp 'electric))


;; (use-package java-mode
;;   :config
;;   (progn
;;     (defun setup--java-mode ()
;;       (setq tab-width 4)
;;       (idle-highlight-mode))
;;     (add-hook 'java-mode-hook #'setup--java-mode)

;;     (use-package generic-x
;;       :commands (java-manifest-generic-mode
;;                  java-properties-generic-mode)
;;       :mode (("MANIFEST.MF\\'" . java-manifest-generic-mode)
;;              ("\\.prop\\'" . java-properties-generic-mode)))))


(use-package js2-mode
  :defer t
  :init
  (progn
    (add-to-list 'magic-mode-alist '("#!/usr/bin/env node" . js2-mode)))
  :config
  (progn
    (setq-default
     js2-global-externs
     '("module" "require" "buster" "sinon" "assert" "refute"
       "setTimeout" "clearTimeout" "setInterval" "clearInterval"
       "location" "__dirname" "console" "JSON")
     js2-additional-externs
     '("$" "unsafeWindow" "localStorage" "jQuery"
       "setTimeout" "setInterval" "location" "console")
     js2-strict-missing-semi-warning nil
     js2-strict-trailing-comma-warning t)
    (setq
     js2-basic-offset 4
     js2-highlight-level 3
     js2-skip-preprocessor-directives t
     js2-use-font-lock-faces t)

    (defun setup--js2-mode ()
      (subword-mode 1)
      (flycheck-mode 1)
      (company-mode 1)
      (local-set-key (kbd "C-.") 'company-complete))

    (add-hook 'js2-mode-hook 'setup--js2-mode))
  :mode (("\\.js$" . js2-mode)
         ("\\.json$" . javascript-mode)))


(use-package lisp-mode
  :defer t
  :config
  (progn
    (use-package eldoc
      :diminish eldoc-mode
      :init (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode))
    (use-package elisp-slime-nav
      :diminish elisp-slime-nav-mode
      :init (add-hook 'emacs-lisp-mode-hook 'turn-on-elisp-slime-nav-mode))
    (use-package elint
      :commands 'elint-initialize
      :preface
      (defun elint-current-buffer ()
        (interactive)
        (elint-initialize)
        (elint-current-buffer))
      :bind ("C-c e E" . elint-current-buffer)
      :config
      (add-to-list 'elint-standard-variables 'current-prefix-arg)
      (add-to-list 'elint-standard-variables 'command-line-args-left)
      (add-to-list 'elint-standard-variables 'buffer-file-coding-system)
      (add-to-list 'elint-standard-variables 'emacs-major-version)
      (add-to-list 'elint-standard-variables 'window-system))
    (use-package ert
      :defer t
      :commands ert-run-tests-interactively
      :bind ("C-c e t" . ert-run-tests-interactively)
      :config
      (progn
        (put 'ert-deftest 'lisp-indent-function 'defun)
        (add-hook 'emacs-lisp-mode-hook
                  (lambda ()
                    (font-lock-add-keywords
                     nil
                     '(("(\\(\\<ert-deftest\\)\\>\\s *\\(\\sw+\\)?"
                        (1 font-lock-keyword-face nil t)
                        (2 font-lock-function-name-face nil t))))))))
    (bind-keys
     :map emacs-lisp-mode-map
     ("C-<f9>" . ert-run-tests-interactively)
     ("M-&" . lisp-complete-symbol)
     ("C-<delete>" . sp-kill-sexp)
     ("C-<backspace>" . sp-backward-kill-sexp)
     ("C-M-w" . sp-copy-sexp)
     ("C-)" . sp-forward-slurp-sexp)
     ("C-}" . sp-forward-barf-sexp)
     ("C-(" . sp-backward-slurp-sexp)
     ("C-{" . sp-backward-barf-sexp)
     ("C-M-t" . sp-transpose-sexp)
     ("M-q" . sp-indent-defun))

    (defun setup--emacs-lisp-mode ()
      (add-hook 'after-save-hook 'check-parens nil t)
      (company-mode 1)
      (local-set-key (kbd "C-.") 'company-complete))

    (add-hook 'emacs-lisp-mode-hook 'setup--emacs-lisp-mode))
  :mode ("Cask" . emacs-lisp-mode))


(use-package macrostep
  :bind ("C-c e m" . macrostep-expand))


(use-package magit
  :defer t
  :config
  (progn
    (setq magit-status-buffer-switch-function 'switch-to-buffer
          magit-restore-window-configuration t
          magit-diff-refine-hunk nil)
    (use-package magit-blame)
    (defadvice magit-diff-working-tree (after magit-diff-focus activate)
      "After execution, select the magit-diff buffer in the current window."
      (other-window 1))
    (fullframe magit-status magit-mode-quite-window)))


(use-package markdown-mode
  :mode (("README\\.md$" . gfm-mode)))


(use-package nuke-whitespace
  :config
  (progn
    (add-hook 'write-file-hooks 'nuke-trailing-whitespace)
    (add-to-list 'nuke-trailing-whitespace-always-major-modes 'emacs-lisp-mode)
    (add-to-list 'nuke-trailing-whitespace-always-major-modes 'python-mode)
    (add-to-list 'nuke-trailing-whitespace-always-major-modes 'ruby-mode)))


(use-package nxml-mode
  :defer t
  :config
  (progn
    (setq nxml-auto-insert-xml-declaration-flag nil
          nxml-bind-meta-tab-to-complete-flag t
          nxml-child-indent 2
          nxml-slash-auto-complete-flag t
          nxml-syntax-highlight-flag t
          rng-nxml-auto-validate-flag nil)
    (push '("<\\?xml" . nxml-mode) magic-mode-alist)
    (add-hook 'sgml-mode-hook 'turn-on-hl-tags-mode)
    (add-hook 'nxml-mode-hook 'turn-on-hl-tags-mode)))


(use-package openwith
  :defer t
  :config
  (progn
    (setq openwith-associations
          (list
           (list (openwith-make-extension-regexp
                  '("mpg" "mpeg" "mp3" "mp4"
                    "avi" "wmv" "wav" "mov" "flv"
                    "ogm" "ogg" "mkv"))
                 (if macosp "open" "mplayer")
                 '(file))
           (list (openwith-make-extension-regexp
                  '("xbm" "pbm" "pgm" "ppm" "pnm"
                    "png" "gif" "bmp" "tif" "jpeg" "jpg"))
                 (if macosp "open" "eog")
                 '(file))
           (list (openwith-make-extension-regexp
                  '("pdf")) ; "ps" "ps.gz" "dvi"))
                 (if macosp "open" "evince")
                 '(file))
           (list (openwith-make-extension-regexp
                  '("epub"))
                 (if macosp "open" "FBReader")
                 '(file))))
    (openwith-mode 1)))


(use-package org
  :defer t
  :init
  (setq org-replace-disputed-keys t
        org-export-backends '(ascii html md latex)) ; '(ascii html icalendar latex))
  :config
  (progn
    (setq
     org-clock-history-length 20
     org-clock-in-resume t
     org-hide-leading-stars nil
     org-level-color-stars-only t
     org-log-done 'time
     org-odd-levels-only nil
     org-reverse-note-order t
     org-src-fontify-natively t
     org-time-clocksum-format '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t)
     org-time-stamp-rounding-minutes '(0 5)
     org-use-speed-commands t)

    ;; (setq org-clock-persist t
    ;;       org-clock-persist-query-resume nil)
    ;; (org-clock-persistence-insinuate)

    (add-hook 'org-mode-hook 'setup--org-mode)

    (defun setup--org-mode ()
      (setq org-blank-before-new-entry '((heading . t)
                                         (plain-list-item . nil)))

      ;; Set program to use when opening PDF files.
      (if macosp
          (add-to-list 'org-file-apps '("\\.pdf\\'" . "open %s"))
        (add-to-list 'org-file-apps '("\\.pdf\\'" . "evince %s")))

      ;; Enable languages for in-buffer evaluation.
      (org-babel-do-load-languages
       'org-babel-load-languages
       '((emacs-lisp . t)
         (python . t)
         (ruby . t)
         (sh . t)))

      (local-set-key [M-up]          'outline-previous-visible-heading)
      (local-set-key [M-down]        'outline-next-visible-heading)
      (local-set-key [(control tab)] 'bs-show)))
  :bind (("M-m" . org-capture)
         ("C-c a" . org-agenda))
  :mode ("\\.org$" . org-mode))


(use-package paren
  :init
  (progn
    (show-paren-mode t)
    (setq show-paren-style 'parenthesis)))


(use-package php-mode
  :defer t
  :config
  (progn
    (setq php-extra-constants '())
    (add-hook 'php-mode-hook 'setup--php-mode)

    (defun setup--php-mode ()
      "PEAR/PHP setup."
      (setq case-fold-search t)
      (setq indent-tabs-mode nil)
      (setq fill-column 78)

      (subword-mode 1)

      (setq c-electric-flag nil)
      (setq c-basic-offset 4)

      (c-set-offset 'arglist-intro '+)
      (c-set-offset 'arglist-close '0)
      (c-set-offset 'case-label 2)

      (setq php-warned-bad-indent t)

      (local-set-key [C-f7] 'php-lint)
      (local-set-key [f7] 'phpcs))

    (defun php-lint ()
      "Performs a PHP lint check on the current file."
      (interactive)
      (let ((compilation-error-regexp-alist '(php))
            (compilation-error-regexp-alist-alist ()))
        (pushnew '(php "\\(syntax error.*\\) in \\(.*\\) on line \\([0-9]+\\)$" 2 3 nil nil 1)
                 compilation-error-regexp-alist-alist)
        (compile (concat "php -l -f \"" (buffer-file-name) "\""))))

    (defun phpcs ()
      "Performs a PHP code sniffer check on the current file."
      (interactive)
      (let ((compilation-error-regexp-alist '(php))
            (compilation-error-regexp-alist-alist ()))
        (pushnew '(php "\"\\([^\"]+\\)\",\\([0-9]+\\),\\([0-9]+\\),\\(warning\\|error\\),\\(.*\\)" 1 2 3 (5 . 6) 4)
                 ;; (pushnew '(php "\"\\([^\"]+\\)\",\\([0-9]+\\),\\([0-9]+\\),\\(\\(warning\\)\\|\\(error\\)\\),\\(.*\\)" 1 2 3 (5 . 6) 4)
                 compilation-error-regexp-alist-alist)
        ;; See:
        ;; * http://pear.php.net/manual/en/standards.php
        ;; * http://pear.php.net/manual/en/package.php.php-codesniffer.annotated-ruleset.php
        (compile (concat "phpcs"
                         " --standard=Zend"
                         " --report=csv"
                         " \"" (buffer-file-name) "\""))))))


(use-package printing
  :defer t
  :config
  (progn
    (pr-update-menus t)
    (setq lpr-command          "lpr"
          lpr-headers-switches "-h"
          ps-paper-type         'a4
          ps-print-color-p      nil
          ps-number-of-columns  2
          ps-landscape-mode     t)))


(use-package projectile
  :defer t
  :commands (projectile-mode helm-projectile)
  :config
  (progn
    (setq projectile-completion-system 'default)
    (use-package helm-projectile))
  :bind ("C-c p M" . projectile-mode))


(use-package protobuf-mode
  :mode ("\\.proto$" . protobuf-mode)
  :init
  (progn
    (defconst my-protobuf-style
      '((c-basic-offset . 4)
        (indent-tabs-mode . nil)))
    (add-hook 'protobuf-mode-hook
              (lambda () (c-add-style "my-style" my-protobuf-style t)))))


(use-package python
  :init
  (progn
    (add-hook 'python-mode-hook 'setup--python-mode)

    ;; (setenv "PYTHONPATH" (concat (if (getenv "PYTHONPATH") "$PYTHONPATH:" "")
    ;;                              (expand-file-name "bin/lib/python" user-emacs-directory))
    ;;         t)

    (defadvice pdb (before gud-query-cmdline activate)
      "Provide a better default command line when called interactively."
      (interactive
       (list (gud-query-cmdline 'pdb
                                (file-name-nondirectory buffer-file-name)))))

    (defun py-run ()
      "Run python on the file in the current buffer."
      (interactive)
      (compile (format "python \"%s\"" (buffer-file-name))))

    (defun setup--python-mode ()
      (which-function-mode 1)
      (subword-mode 1)

      ;;(setq py-python-command-args '( "-colors" "Linux"))

      (modify-syntax-entry ?\_ "_" python-mode-syntax-table)

      (require 'sphinx-doc)
      (sphinx-doc-mode 1)

      (eldoc-mode 1)

      (anaconda-mode 1)
      (company-mode 1)
      (flycheck-mode 1)

      (require 'tramp) ;; needed by pep8 and pylint
      (require 'python-pylint)
      (require 'python-pep8)

      (set (make-variable-buffer-local 'outline-regexp) "def\\|class ")
      (set (make-variable-buffer-local 'indent-tabs-mode) nil)

      (bind-keys
       :map subword-mode-map
       ("<M-left>"      . subword-backward)
       ("<M-right>"     . subword-forward)
       ("<C-left>"      . subword-backward)
       ("<C-right>"     . subword-forward)
       ("<C-backspace>" . subword-backward-kill))

      (local-set-key (kbd "C-.") 'company-complete)

      (local-set-key [f7]   'python-pylint)
      (local-set-key [C-f7] 'python-pep8)

      (local-set-key [f9]   'py-run)
      (local-set-key [S-f9] 'pdb)       ; defined in gud
      (local-set-key [C-f9] 'compile)
      (local-set-key [M-f9] 'recompile))))


(use-package rbenv
  :init
  (setq rbenv-show-active-ruby-in-modeline nil))
  ;; :config
  ;; (global-rbenv-mode))


(use-package re-builder
  :defer t
  :config
  (setq reb-re-syntax 'string))


(use-package ruby-mode
  :init
  (progn
    (setq ruby-deep-indent-paren nil)

    (add-hook 'ruby-mode-hook 'setup--ruby-mode)

    (defun ruby-run ()
      "Run ruby on the file in the current buffer."
      (interactive)
      (compile (concat "ruby " (buffer-file-name))))

    (defun setup--ruby-mode ()
      (which-function-mode 1)
      (subword-mode 1)
      (company-mode 1)
      (robe-mode 1)
      (inf-ruby-minor-mode 1)
      (inf-ruby-switch-setup)

      (minitest-mode 1)

      (require 'ruby-block)
      (ruby-block-mode t)
      (setq ruby-block-delay 0.1
            ruby-block-highlight-toggle 'overlay
            ruby-block-highlight-face 'isearch)

      (make-variable-buffer-local 'compilation-error-regexp-alist)
      (setq compilation-error-regexp-alist
            (append compilation-error-regexp-alist
                    (list (list
                           (concat
                            "\\(.*?\\)\\([0-9A-Za-z_./\:-]+\\.rb\\)"
                            ":\\([0-9]+\\)") 2 3))))

      (make-variable-buffer-local 'compile-command)
      (setq compile-command (concat "ruby " (buffer-file-name) " "))

      (local-set-key (kbd "C-.") 'company-complete)

      (local-set-key [f9]    'ruby-run)
      (local-set-key [C-f9]  'minitest-verify)
      (local-set-key [M-f9]  'minitest-verify-single)))
  :config
  (progn
    (use-package ruby-end :diminish ruby-end-mode)
    (use-package robe :diminish robe-mode))
  :mode (("Gemfile$" . ruby-mode)
         ("Rakefile$" . ruby-mode)
         ("Guardfile" . ruby-mode)
         ("Vagrantfile$" . ruby-mode)
         ("\\.watchr$" . ruby-mode)
         ("\\.rake$" . ruby-mode)
         ("\\.rb$" . ruby-mode)))


(use-package sh-script
  :init
  (setq sh-shell-file     "/bin/sh"
        sh-indentation    4
        sh-basic-offset   4
        sh-indent-comment t)
  :mode (("/\\.\\(my\\)?login$" . sh-mode)
         ("/\\.\\(my\\)?logout$" . sh-mode)
         ("/\\.\\(my\\)?t?cshrc$" . sh-mode)
         ("/\\.profile$" . sh-mode)
         ("/\\.xinitrc$" . sh-mode)
         ("\\.t?c?sh$" . sh-mode)))


(use-package shell
  :init
  (progn
    (setq explicit-shell-file-name "bash"
          shell-file-name shell-file-name
          shell-command-switch "-c")
    (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)))


(use-package shell-toggle
  :bind ("M-z" . shell-toggle))


(use-package savehist
  :init
  (progn
    (setq savehist-ignored-variables '(file-name-history))
    (savehist-mode 1)))


(use-package saveplace
  :init
  (progn
    (setq-default save-place t)
    (setq save-place-file (expand-file-name ".places" user-emacs-directory))))


(use-package scss-mode
  :defer t
  :config
  (progn
    (add-hook 'scss-mode-hook 'turn-on-rainbow-mode))
  :mode (("\\.scss$" . scss-mode)))


(use-package smartparens
  :defer t
  :commands (smartparens-mode
             smartparens-strict-mode
             show-smartparens-mode
             sp-kill-sexp sp-backward-kill-sexp
             sp-copy-sexp
             sp-forward-slurp-sexp
             sp-forward-barf-sexp
             sp-backward-slurp-sexp
             sp-backward-barf-sexp
             sp-transpose-sexp
             sp-indent-defun)
  :config
  (progn
    (setq sp-autoskip-closing-pair 'always
          sp-hybrid-kill-entire-symbol nil)
    ;;(show-smartparens-global-mode 1)
    (sp--populate-keymap
     '(("C-<delete>" . sp-kill-sexp)
       ("C-<backspace>" . sp-backward-kill-sexp)
       ("C-M-w" . sp-copy-sexp)
       ("C-)" . sp-forward-slurp-sexp)
       ("C-}" . sp-forward-barf-sexp)
       ("C-(" . sp-backward-slurp-sexp)
       ("C-{" . sp-backward-barf-sexp)
       ("C-M-t" . sp-transpose-sexp)
       ("M-q" . sp-indent-defun)))))


(use-package smooth-scrolling
  )


(use-package speedbar
  :config
  (progn
    (setq speedbar-default-position 'left
          speedbar-show-unknown-files t
          speedbar-update-flag t)))


(use-package sql
  :defer t
  :config
  (progn
    (setq plsql-indent 2)
    (add-hook 'sql-interactive-mode-hook 'setup--sql-interactive-mode)

    (defun sql-make-smart-buffer-name ()
      "Return a string that can be used to rename a SQLi buffer.

This is used to set `sql-alternate-buffer-name' within
`sql-interactive-mode'."
      (or (and (boundp 'sql-name) sql-name)
          (concat (if (not (string= "" sql-server))
                      (concat
                       (or (and (string-match "[0-9.]+" sql-server) sql-server)
                           (car (split-string sql-server "\\.")))
                       "/"))
                  sql-database)))
    (defun setup--sql-interactive-mode ()
      (turn-on-truncate-lines)
      (make-variable-buffer-local 'sql-input-ring-file-name)
      (setq sql-input-ring-file-name
            (expand-file-name
             (concat "history-" (symbol-name sql-product) ".sql")
             user-emacs-directory))
      (setq sql-alternate-buffer-name (sql-make-smart-buffer-name))
      (sql-rename-buffer))))


(use-package time
  :config
  (setq display-time-world-time-format "%Y-%m-%d %H:%M %Z"
        display-time-world-list '(("America/Los_Angeles" "San Fransisco")
                                  ("America/New_York" "New York")
                                  ("Europe/London" "London")
                                  ("Europe/Stockholm" "Stockholm")
                                  ("Asia/Tokyo" "Tokyo"))))


(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'forward))


(use-package vc
  :config
  (progn
    (setq vc-command-messages    t
          vc-follow-symlinks     t
          vc-consult-headers     t
          vc-keep-workfiles      t
          vc-make-backup-files   nil
          vc-dired-terse-display nil
          vc-dired-recurse       nil)
    (use-package vc-hg
      :config
      (setq hg-commit-allow-empty-message t
            vc-hg-diff-switches "--text"))

    (define-key vc-prefix-map "e" 'ediff-revision-current-buffer)
    (define-key vc-prefix-map "R" 'vc-resolve-conflicts)

    (fullframe vc-dir quit-window)

    (defun setup--cvs-mode ()
      (local-set-key [M-delete] 'cvs-mode-unmark-all-files)
      (local-set-key [return]   'cvs-mode-find-file))

    (add-hook 'cvs-mode-hook 'setup--cvs-mode)))


(use-package web-mode
  :defer t
  :config
  (progn
    (setq web-mode-enable-block-face t
          web-mode-enable-part-face t
          web-mode-disable-css-colorization nil
          web-mode-disable-auto-pairing nil))
  :mode (("\\.rhtml$" . web-mode)
         ("\\.\\(php\\|inc\\)$" . web-mode)))


(use-package webjump
  :defer t
  :config
  (progn
    (setq webjump-sites
          '(("Google" .
             [simple-query "www.google.com" "www.google.com/search?q=" ""])
            ("IMDB" .
             [simple-query "www.imdb.com" "www.imdb.com/Find?select=All&for=" ""])
            ("Wikipedia" .
             [simple-query "wikipedia.org" "wikipedia.org/wiki/" ""])
            ("Urban Dictionary" .
             [simple-query "www.urbandictionary.com"
                           "http://www.urbandictionary.com/define.php?term=" ""])
            ("Python 2.6" .
             [simple-query "http://docs.python.org/2.6"
                           "http://docs.python.org/release/2.6/search.html?q=" ""])
            ("Google Maps" .
             [simple-query "maps.google.com"
                           "http://maps.google.com/maps?q=" ""])
            ("Open Street Map" .
             [simple-query "openstreetmap.org"
                           "http://nominatim.openstreetmap.org/search?q=" "&polygon=1"])
            ("Internet Drafts" .
             [simple-query
              "www.ietf.org/ID.html"
              ,(concat "search.ietf.org/cgi-bin/htsearch?restrict="
                       (webjump-url-encode "http://www.ietf.org/internet-drafts/")
                       "&words=") ""])))))


(use-package woman
  :config
  (progn
    (fset 'man 'woman)
    (setq woman-use-own-frame nil
          woman-fontify       t
          woman-imenu         t
          Man-notify-method   'pushy)))


(use-package yaml-mode
  :mode ("\\.ya?ml$" . yaml-mode))


(use-package yasnippet
  :diminish yas-minor-mode
  :commands (snippet-mode yas-expand yas-minor-mode)
  :mode ("/\\.emacs\\.d/snippets/" . snippet-mode)
  :init
  (progn
    (setq yas-verbosity 0)
    (yas-global-mode 1)
    (setq-default yas-prompt-functions
                  '(yas/ido-prompt yas/completing-prompt)))
  :config
  (progn
    (load "snippet-helpers")
    (let ((snippets-dir (expand-file-name "snippets" user-emacs-directory)))
      (yas-load-directory snippets-dir)
      (setq yas-snippet-dirs snippets-dir))))


(provide 'setup)
