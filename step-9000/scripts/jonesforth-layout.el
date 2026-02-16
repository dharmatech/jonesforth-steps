
(global-auto-revert-mode 1)
(setq auto-revert-interval 1)             ; check disk every second
(setq auto-revert-verbose nil)            ; silence mode-line messages
(load-theme 'deeper-blue t)

(require 'hideshow)
(require 'org)

(defconst jonesforth-layout--file
  (or load-file-name (buffer-file-name))
  "Path to this layout file.")

(defvar-local jonesforth-layout--last-synced-line nil
  "Last jonesforth.S line number synced from trace.tree.org heading.")

(defvar-local jonesforth-layout--line-highlight-overlay nil
  "Overlay used for temporary source line highlighting.")

(defvar-local jonesforth-layout--symbol-highlight-regexps nil
  "List of regexps currently toggled on by jonesforth layout helper.")

(defvar-local jonesforth-layout--highlight-symbol-tracked nil
  "List of symbol names toggled on via highlight-symbol integration.")

(defvar-local jonesforth-layout--sync-enabled t
  "When non-nil, trace headings sync jonesforth.S line position.")

(defun jonesforth-layout--trace-heading-line-number ()
  "Return leading line number from current Org heading, or nil."
  (when (org-at-heading-p)
    (save-excursion
      (beginning-of-line)
      (when (looking-at "^\\*+\\s-+\\([0-9]+\\)\\b")
        (string-to-number (match-string 1))))))

(defun jonesforth-layout--flash-source-line (source-buffer pos)
  "Highlight line at POS in SOURCE-BUFFER until next sync."
  (with-current-buffer source-buffer
    (save-excursion
      (goto-char pos)
      (when (overlayp jonesforth-layout--line-highlight-overlay)
        (delete-overlay jonesforth-layout--line-highlight-overlay))
      (setq jonesforth-layout--line-highlight-overlay
            (make-overlay (line-beginning-position) (line-end-position)))
      (overlay-put jonesforth-layout--line-highlight-overlay 'face 'highlight))))

(defun jonesforth-layout--goto-source-line (line-number)
  "Move jonesforth.S window point to LINE-NUMBER."
  (let* ((source-buffer (or (get-file-buffer "jonesforth.S")
                            (get-buffer "jonesforth.S")))
         (source-window (and source-buffer
                             (get-buffer-window source-buffer t))))
    (when source-buffer
      (let ((pos (with-current-buffer source-buffer
                   (save-excursion
                     (goto-char (point-min))
                     (forward-line (1- (max 1 line-number)))
                     (point)))))
        (when source-window
          (save-selected-window
            (with-selected-window source-window
              (set-window-point source-window pos)
              (recenter))))
        (jonesforth-layout--flash-source-line source-buffer pos)))))

(defun jonesforth-layout-sync-from-trace-heading ()
  "Sync jonesforth.S view to numbered headings in trace.tree.org."
  (let ((line-number (and jonesforth-layout--sync-enabled
                          (jonesforth-layout--trace-heading-line-number))))
    (when (and line-number
               (not (equal line-number jonesforth-layout--last-synced-line)))
      (setq jonesforth-layout--last-synced-line line-number)
      (jonesforth-layout--goto-source-line line-number))))

(defun jonesforth-layout-toggle-symbol-highlight ()
  "Toggle highlighting for the symbol at point in current buffer."
  (interactive)
  (let* ((symbol (thing-at-point 'symbol t))
         (regexp (and symbol (concat "\\_<" (regexp-quote symbol) "\\_>"))))
    (unless symbol
      (user-error "No symbol at point"))
    (if (fboundp 'highlight-symbol-at-point)
        (let ((already-highlighted
               (or (member symbol jonesforth-layout--highlight-symbol-tracked)
                   (and (boundp 'highlight-symbol-list)
                        (member symbol highlight-symbol-list)))))
          (if already-highlighted
              (progn
                (if (fboundp 'highlight-symbol-remove-symbol)
                    (highlight-symbol-remove-symbol)
                  (unhighlight-regexp regexp))
                (setq jonesforth-layout--highlight-symbol-tracked
                      (delete symbol jonesforth-layout--highlight-symbol-tracked)))
            (highlight-symbol-at-point)
            (push symbol jonesforth-layout--highlight-symbol-tracked)))
      (if (member regexp jonesforth-layout--symbol-highlight-regexps)
          (progn
            (unhighlight-regexp regexp)
            (setq jonesforth-layout--symbol-highlight-regexps
                  (delete regexp jonesforth-layout--symbol-highlight-regexps)))
        (highlight-regexp regexp 'hi-yellow)
        (push regexp jonesforth-layout--symbol-highlight-regexps)))))

(defun jonesforth-layout-show-help ()
  "Show jonesforth layout keybindings."
  (interactive)
  (message "Jonesforth keys: F1 help, F6 toggle symbol highlight, F8 toggle trace sync, TAB fold/unfold (jonesforth.S)"))

(defun jonesforth-layout-toggle-sync ()
  "Toggle trace-to-source sync on or off."
  (interactive)
  (let ((trace-buffer (or (get-file-buffer "trace.tree.org")
                          (get-buffer "trace.tree.org"))))
    (unless trace-buffer
      (user-error "trace.tree.org is not open"))
    (with-current-buffer trace-buffer
      (setq jonesforth-layout--sync-enabled (not jonesforth-layout--sync-enabled))
      (message "Trace sync %s" (if jonesforth-layout--sync-enabled "enabled" "disabled")))))

(defun jonesforth-layout-org-cycle-stable ()
  "Run `org-cycle' while keeping current heading at a stable screen position."
  (interactive)
  (let ((win (selected-window))
        (start (window-start))
        (pt (point)))
    (call-interactively #'org-cycle)
    (set-window-start win start t)
    (goto-char pt)))

(defun jonesforth-hs-forward-sexp (&optional arg)
  "Move forward across one foldable asm block for hideshow."
  (let ((n (or arg 1)))
    (dotimes (_ n)
      (cond
       ((looking-at "[[:space:]]*/\\*")
        (re-search-forward "\\*/" nil 'move))
       ((looking-at "[[:space:]]*\\.macro\\b")
        (re-search-forward "^[[:space:]]*\\.endm\\b" nil 'move))
       (t
        (forward-sexp 1))))))

(add-to-list 'hs-special-modes-alist
             '(asm-mode
               "/\\*\\|^[[:space:]]*\\.macro\\b"
               "\\*/\\|^[[:space:]]*\\.endm\\b"
               nil
               jonesforth-hs-forward-sexp))
(add-hook 'asm-mode-hook #'hs-minor-mode)

(defun jonesforth-layout ()
  "Open jonesforth layout for terminal Emacs."
  (setq scroll-conservatively 101)        ; >100 gives near line-by-line scrolling
  (delete-other-windows)
  (find-file "jonesforth.S")              ; left
  (read-only-mode 1)
  (display-line-numbers-mode 1)
  (setq-local truncate-lines t)
  (local-set-key (kbd "<f1>") #'jonesforth-layout-show-help)
  (local-set-key (kbd "TAB") #'hs-toggle-hiding)
  (local-set-key (kbd "<tab>") #'hs-toggle-hiding)
  (local-set-key (kbd "<f6>") #'jonesforth-layout-toggle-symbol-highlight)
  (local-set-key (kbd "<f8>") #'jonesforth-layout-toggle-sync)
  (split-window-right)
  (other-window 1)
  (find-file "trace.tree.org")            ; right
  (read-only-mode 1)
  (setq-local org-cycle-hook
              (remove 'org-optimize-window-after-visibility-change
                      org-cycle-hook))
  (local-set-key (kbd "TAB") #'jonesforth-layout-org-cycle-stable)
  (local-set-key (kbd "<tab>") #'jonesforth-layout-org-cycle-stable)
  (local-set-key (kbd "<f1>") #'jonesforth-layout-show-help)
  (local-set-key (kbd "<f6>") #'jonesforth-layout-toggle-symbol-highlight)
  (local-set-key (kbd "<f8>") #'jonesforth-layout-toggle-sync)
  (setq-local jonesforth-layout--last-synced-line nil)
  (setq-local jonesforth-layout--sync-enabled t)
  (add-hook 'post-command-hook #'jonesforth-layout-sync-from-trace-heading nil t))

(defun jonesforth-layout-reload ()
  "Reload layout file from disk and apply the layout."
  (interactive)
  (unless jonesforth-layout--file
    (user-error "Cannot determine layout file path"))
  (load-file jonesforth-layout--file))

(jonesforth-layout)
