;;;ロードパスの設定
;; Emacs 23より前のバージョンを利用しているときは
;; user-emacs-directory変数が未定義のため次の設定を追加
(when (< emacs-major-version 23)
  (defvar user-emacs-directory "~/.emacs.d/"))

;;load-pathを追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))
;;ロードパスの追加
(add-to-load-path "elisp" "conf" "public_repos")



;; ローカルに合わせた環境の設定
(set-locale-environment nil)


;;;キーバインドの設定
;;改行と同時にインデント
;; C-mにnewline-and-indentを割り当てる
(global-set-key (kbd "C-m") 'newline-and-indent)
;;折り返しトグルコマンド
(global-set-key (kbd "C-c l") 'toggle-truncate-lines)
;;"C-t"でウィンドウを切り替える。初期値はtranspose-chars
(global-set-key (kbd "C-t") 'other-window)



;;;文字コードの設定
;;ロケールの設定
(set-language-environment "Japanese")
;;文字コードの優先度
(prefer-coding-system 'utf-8)
;;Max OS Xの場合ファイル名の設定
(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))
;;Windowsの場合のファイル名の設定
(when (eq window-system 'w32)
  (set-file-name-coding-system 'cp932)
  (setq locale-coding-system 'cp932))


;;;フレームの設定
;; メニューバーを消す
(menu-bar-mode 0)
;;ツールバーを消す
(tool-bar-mode 0)
;;カラム番号も表示
(column-number-mode t)



;;;
;;;表示・装飾の設定
;;;
(when (require 'color-theme nil t)
  (color-theme-initialize))
;;文字色
(set-face-foreground 'default "White")
;;背景色
(set-face-background 'default "DimGrey")
;;大きく表示
(set-face-attribute 'default nil
:height 130)
;; asciiフォント
;(set-face-attribute 'default nil
;		    :family "Lucida Console"
;		    :height 120)
(set-fontset-font
 nil 'japanese-jisx0208
(font-spec :family "Hiragino Mincho Pro"))
;;
;;対応する括弧を強調
(show-paren-mode t)
(setq show-paren-style 'expression)


;; 画像ファイルを表示
(auto-image-file-mode t)


;;;フック
;;ファイルが#!から始まる場合に、+xを付けて保存する
(add-hook 'after-save-hook
	  'executable-make-buffer-file-executable-if-script-p)

;;auto-installの設定
(when (require 'auto-install nil t)
  ;;インストールするディレクトリ
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup))


;;;php-mode
(autoload 'php-mode "php-mode")
(setq auto-mode-alist
(cons '("\\.php\\'" . php-mode) auto-mode-alist))
(setq php-mode-force-pear t)
(add-hook 'php-mode-user-hook
'(lambda ()
(setq php-manual-path "user/local/share/php/doc/html")
(setq php-manual-url "http://www.phppro.jp/phpmanual/")))


;css editing mode
(autoload 'css-mode "css-mode")
(setq auto-mode-alist
      (cons '("\\.css\\'" . css-mode) auto-mode-alist))
(setq cssm-indent-functioin #'cssm-c-style-indenter)

(require 'mmm-mode)
(setq mmm-global-mode 'maybe)
;(set-face-background 'mmm-default-submode-face nil)
(mmm-add-classes
'((embedded-css
:submode css-mode
:front "<style[^>]*>"
:back "</style>")))
(mmm-add-mode-ext-class nil "\\.html\\'" 'embedded-css)


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
