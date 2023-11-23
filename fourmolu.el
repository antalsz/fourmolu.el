;;; fourmolu.el --- Format Haskell source code using the "fourmolu" program -*- lexical-binding: t -*-

;; Author: Antal Spector-Zabusky <antal.b.sz@gmail.com>
;; Maintainer: Antal Spector-Zabusky
;; Version: 0.2.0-snapshot
;; URL: https://github.com/antalsz/fourmolu.el
;; Keywords: files, tools
;; Package-Requires: ((emacs "24") (reformatter "0.4"))

;; This file is NOT part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Provides a minor mode and commands for easily using the "fourmolu"
;; program to reformat Haskell code.
;;
;; Based on Vasily Yorkin's "ormolu.el"
;; (https://github.com/vyorkin/ormolu.el).

;;; Code:

(require 'reformatter)

(defgroup fourmolu nil
  "Integration with the \"fourmolu\" formatting program."
  :prefix "fourmolu-"
  :group 'haskell)

(defcustom fourmolu-process-path "fourmolu"
  "Location where the fourmolu executable is located."
  :group 'fourmolu
  :type 'string
  :safe #'stringp)

(defcustom fourmolu-extra-args '()
  "Extra arguments to give to fourmolu."
  :group 'fourmolu
  :type 'sexp
  :safe #'listp)

(defcustom fourmolu-no-cabal nil
  "Whether to use the --no-cabal flag."
  :group 'fourmolu
  :type 'boolean
  :safe #'booleanp)

(defvar fourmolu-mode-map (make-sparse-keymap)
  "Local keymap used for `fourmolu-format-on-save-mode`.")

;;;###autoload (autoload 'fourmolu-format-buffer "fourmolu" nil t)
;;;###autoload (autoload 'fourmolu-format-region "fourmolu" nil t)
;;;###autoload (autoload 'fourmolu-format-on-save-mode "fourmolu" nil t)
(reformatter-define fourmolu-format
  :program fourmolu-process-path
  :args (append (if (and (not fourmolu-no-cabal) buffer-file-name)
                    `("--stdin-input-file" ,buffer-file-name)
                  '("--no-cabal")) fourmolu-extra-args)
  :group 'fourmolu
  :lighter " Fo"
  :keymap fourmolu-mode-map)

(defalias 'fourmolu 'fourmolu-format-buffer)

(provide 'fourmolu)

;;; fourmolu.el ends here
