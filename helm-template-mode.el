;;; helm-template-mode.el --- Syntax highlighter mode for Helm chart templates

;; Copyright (C) 2021 Sergej Alikov <sergej@alikov.com>

;; Author: Sergej Alikov
;; Keywords: languages helm

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

;;; Commentary:

;; A simple, highlight-only mode for editing Helm chart templates in Emacs.

;;; Code:

;; TODO: Better definitions for custom faces (light/dark background support, etc)

(defface helm-template-untemplated-face
  '((t :foreground "gray60"))
  "Face for the untemplated text"
  :group 'foo-faces)

(defvar helm-template-braces-face 'helm-template-braces-face "Face name to use for braces.")
(defface helm-template-braces-face
  '((t :foreground "dark red" :weight bold))
  "Face for the braces text"
  :group 'foo-faces)

(defun helm-template-region-for-current-line ()
  "Move point to the begining of a region, and return the end of the region, stop at EOL."
  (progn
    (re-search-backward
     "{{" (save-excursion (re-search-backward "^") (point)) t)
    (save-excursion
      ;; Ensure there are even number of quotes between the begining and the end.
      (re-search-forward
       "{{[^\"]*?\\(\"[^\"]*?\"[^\"]*?\\)*?[^\"]*?}}" (save-excursion (re-search-forward "$") (point)) t)
      (point))))

(defvar helm-template-font-lock-keywords
  '(("{{-? ?/\\*"
     (0 font-lock-comment-delimiter-face)
     ("\\(\\(.\\|\n\\)*\\)\\(?:\\*/-?}}\\)"
      (save-excursion (re-search-forward "\\*/-?}}") (point))
      (re-search-backward "{{-? ?/\\*")
      (1 font-lock-comment-face))
     ("\\*/-?}}"
      (save-excursion (re-search-forward "\\*/-?}}") (point))
      nil
      (0 font-lock-comment-delimiter-face)))
    ("\\({{-?\\)\\(?: */[^*]\\| +[^/ ]\\|[^/ -]\\)"
     (1 helm-template-braces-face)
     ("\".*?\""
      (helm-template-region-for-current-line)
      nil
      (0 font-lock-string-face))
     ("\\$[a-zA-Z0-9_]*"
      (helm-template-region-for-current-line)
      nil
      (0 font-lock-variable-name-face))
     ("\\.[a-zA-Z0-9_]*\\|true\\|false"
      (helm-template-region-for-current-line)
      nil
      (0 font-lock-constant-face))
     ("\\<[0-9]+\\>"
      (helm-template-region-for-current-line)
      nil
      (0 font-lock-type-face))
     (":=\\||"
      (helm-template-region-for-current-line)
      nil
      (0 font-lock-keyword-face))
     ;; Keywords and operators. See optimized-regexes.el
     ("\\<\\(?:block\\|define\\|e\\(?:lse\\|nd\\)\\|if\\|range\\|template\\|with\\)\\>"
      (helm-template-region-for-current-line)
      nil
      (0 font-lock-keyword-face))
     ;; Functions built into the (Golang) templating engine. See optimized-regexes.el
     ("\\<\\(?:from\\(?:Json\\(?:Array\\)?\\|Yaml\\(?:Array\\)?\\)\\|in\\(?:clude\\|dex\\)\\|list\\|required\\|t\\(?:\\(?:o\\(?:\\(?:To\\|Ya\\)m\\)\\|p\\)l\\)\\)\\>"
      (helm-template-region-for-current-line)
      nil
      (0 font-lock-builtin-face))
     ;; Helm functions. See optimized-regexes.el
     ("\\<\\(?:a\\(?:bbrev\\(?:both\\)?\\|d\\(?:d1?\\|ler32sum\\)\\|go\\|\\(?:ppe\\)?nd\\)\\|b\\(?:32\\(?:\\(?:de\\|en\\)c\\)\\|64\\(?:\\(?:de\\|en\\)c\\)\\|ase\\|uildCustomCert\\)\\|c\\(?:a\\(?:melcase\\|t\\)\\|eil\\|leanext\\|o\\(?:alesce\\|mpact\\|n\\(?:cat\\|tains\\)\\)\\)\\|d\\(?:ate\\(?:InZone\\|Modify\\)?\\|e\\(?:cryptAES\\|ep\\(?:Copy\\|equal\\)\\|fault\\|rivePassword\\)\\|i\\(?:ct\\|[rv]\\)\\|uration\\(?:Round\\)?\\)\\|e\\(?:mpty\\|ncryptAES\\|q\\)\\|f\\(?:ail\\|irst\\|loor\\)\\|g\\(?:e\\(?:n\\(?:CA\\|PrivateKey\\|S\\(?:\\(?:elfS\\)?ignedCert\\)\\)\\|t\\(?:HostByName\\)?\\)\\|[et]\\)\\|h\\(?:as\\(?:Key\\|\\(?:Pre\\|Suf\\)fix\\)?\\|t\\(?:mlDate\\(?:InZone\\)?\\|passwd\\)\\)\\|i\\(?:n\\(?:dent\\|itials?\\)\\|sAbs\\)\\|k\\(?:e\\(?:babcase\\|ys\\)\\|ind\\(?:Is\\|Of\\)\\)\\|l\\(?:ast\\|en\\|o\\(?:okup\\|wer\\)\\|[et]\\)\\|m\\(?:ax\\|erge\\(?:Overwrite\\)?\\|in\\|od\\|u\\(?:l\\|st\\(?:Append\\|Compact\\|D\\(?:\\(?:ateModif\\|eepCop\\)y\\)\\|First\\|Has\\|Initial\\|Last\\|Merge\\(?:Overwrite\\)?\\|Prepend\\|Re\\(?:gex\\(?:Find\\(?:All\\)?\\|Match\\|ReplaceAll\\(?:Literal\\)?\\|Split\\)\\|st\\|verse\\)\\|Slice\\|To\\(?:Date\\|\\(?:Pretty\\|Raw\\)?Json\\)\\|Uniq\\|Without\\)\\)\\)\\|n\\(?:e\\|indent\\|o\\(?:space\\|[tw]\\)\\)\\|o\\(?:mit\\|r\\)\\|p\\(?:ick\\|lu\\(?:ck\\|ral\\)\\|r\\(?:epend\\|int\\(?:f\\|ln\\)?\\)\\)\\|quote\\|r\\(?:and\\(?:A\\(?:lpha\\(?:Num\\)?\\|scii\\)\\|Numeric\\)\\|e\\(?:gex\\(?:Find\\(?:All\\)?\\|Match\\|ReplaceAll\\(?:Literal\\)?\\|Split\\)\\|p\\(?:eat\\|lace\\)\\|st\\|verse\\)\\|ound\\)\\|s\\(?:e\\(?:mver\\(?:Compare\\)?\\|[qt]\\)\\|h\\(?:a\\(?:\\(?:1\\|256\\)sum\\)\\|uffle\\)\\|lice\\|nakecase\\|quote\\|ub\\(?:str\\)?\\|wapcase\\)\\|t\\(?:ernary\\|itle\\|o\\(?:D\\(?:ate\\|ecimal\\)\\|Json\\|PrettyJson\\|RawJson\\|Strings\\)\\|r\\(?:im\\(?:All\\|\\(?:Pre\\|Suf\\)fix\\)?\\|unc\\)\\|ype\\(?:Is\\(?:Like\\)?\\|Of\\)\\)\\|u\\(?:n\\(?:i\\(?:q\\|xEpoch\\)\\|set\\|ti\\(?:l\\(?:Step\\)?\\|tle\\)\\)\\|pper\\|rl\\(?:Join\\|Parse\\|query\\)\\|uidv4\\)\\|values\\|w\\(?:ithout\\|rap\\(?:With\\)?\\)\\)\\>"
      (helm-template-region-for-current-line)
      nil
      (0 font-lock-function-name-face))
     ("-?}}"
      (helm-template-region-for-current-line)
      nil
      (0 helm-template-braces-face))))
  "Keyword highlighting specification for `helm-template-mode'.")


(define-derived-mode helm-template-mode text-mode "helm"
  "major mode for editing helm templates."
  (buffer-face-set 'helm-template-untemplated-face)
  (setq-local font-lock-defaults '(helm-template-font-lock-keywords))
  (setq-local font-lock-multiline t)
  ;; TODO: Extend region function to enable rehighlightin existing comment
  ;;       blocks on truncation.
  ;; (add-hook 'font-lock-extend-region-functions 'helm-template-lock-extend-region)
  )

;; Add the mode to the `features' list
(provide 'helm-template-mode)

;;; helm-template-mode.el ends here
