;;; nand2tetris-asm-mode.el --- Major mode for editing nand2tetris ASM files -*- lexical-binding: t -*-
(defgroup nand2tetris-asm '()
  "Major mode for editing nand2tetris ASM files."
  :group 'languages)

(defconst nand2tetris-asm--label-regexp
  "([a-zA-Z_]+)"
  "Regular expresssion matching a label.")

(defconst nand2tetris-asm-font-lock-keywords
  (let ((function-regexp (regexp-opt '("JMP" "JLE" "JLT" "JEQ" "JNE" "JGT" "JGE") 'words)))
    (list
     `(,function-regexp . (1 font-lock-function-name-face))
     `(,nand2tetris-asm--label-regexp . font-lock-keyword-face)
     '("@[a-zA-Z_0-9]+" . font-lock-constant-face)))
  "Minimal highlighting for 'nand2tetris-asm-mode'.")

(defconst nand2tetris-asm-mode-syntax-table
  (let ((table (make-syntax-table)))
    ;; Comments.
    (modify-syntax-entry ?/ ". 12b" table)
    (modify-syntax-entry ?\n "> b" table)
    table)
  "Syntax table for 'nand2tetris-asm-mode'.")

;;;###autoload
(define-derived-mode nand2tetris-asm-mode prog-mode "nand2tetris-asm"
  "nand2tetris-asm-mode is a major mode for editing .asm files written using in nand2tetris assembly language."
  :syntax-table nand2tetris-asm-mode-syntax-table
  (setq-local font-lock-defaults '(nand2tetris-asm-font-lock-keywords ;; keywords
                                   nil  ;; keywords-only
                                   nil  ;; case-fold
                                   nil  ;; syntax-alist
                                   nil  ;; syntax-begin
                                   ))
  ;; TODO: (setq-local indent-line-function #'nand2tetris-asm-indent-line))
  (setq-local comment-start "// ")
  (setq-local comment-start-skip "//+[\t ]*")
  (setq-local comment-end "")
  (add-hook 'syntax-propertize-extend-region-functions
            #'syntax-propertize-multiline 'append 'local))
(provide 'nand-tetris-asm-mode)
;;; nand2tetris-asm-mode.el ends here
