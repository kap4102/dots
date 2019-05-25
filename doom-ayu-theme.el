;;; doom-ayu-theme.el
(require 'doom-themes)

;;
(defgroup doom-ayu-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-ayu-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-ayu-theme
  :type 'boolean)

(defcustom doom-ayu-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-ayu-theme
  :type 'boolean)

(defcustom doom-ayu-comment-bg doom-ayu-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-ayu-theme
  :type 'boolean)

(defcustom doom-ayu-padded-modeline nil
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-ayu-theme
  :type '(or integer boolean))

;;
(def-doom-theme doom-ayu
  "Doom ayu theme"

  ;; name        default   256       16
  ((bg         '("#0F1419" nil       nil            ))
   (bg-alt     '("#212B36" nil       nil            ))
   (base0      '("#1D1A0F" "#1C1C1C" "black"        ))
   (base1      '("#39341E" "#303030" "brightblack"  ))
   (base2      '("#564D2D" "#444444" "brightblack"  ))
   (base3      '("#73673C" "#5F5F5F" "brightblack"  ))
   (base4      '("#90814B" "#87875F" "brightblack"  ))
   (base5      '("#AA995C" "#AF875F" "brightblack"  ))
   (base6      '("#B9AB79" "#AFAF87" "brightblack"  ))
   (base7      '("#C8BD96" "#D7AF87" "brightblack"  ))
   (base8      '("#D7CFB2" "#D7D7AF" "white"        ))
   (fg-alt     '("#EBE7D9" "#E4E4E4" "brightwhite"  ))
   (fg         '("#E6E1CF" "#DADADA" "white"        ))

   (grey       base4)
   (red        '("#FF3333" "#FF5F5F" "red"          ))
   (orange     '("#FF9556" "#FF875F" "brightred"    ))
   (green      '("#B8CC52" "#AFD75F" "green"        ))
   (teal       '("#EAFE84" "#D7FF87" "brightgreen"  ))
   (yellow     '("#FFF779" "#FFFF87" "yellow"       ))
   (blue       '("#68D5FF" "#5FD7FF" "brightblue"   ))
   (dark-blue  '("#36A3D9" "#5FAFD7" "blue"         ))
   (magenta    '("#FFA3AA" "#FFAFAF" "magenta"      ))
   (violet     '("#F07178" "#FF5F87" "brightmagenta"))
   (cyan       '("#C7FFFD" "#D7FFFF" "brightcyan"   ))
   (dark-cyan  '("#95E6CB" "#87D7D7" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-lighten bg 0.05))
   (selection      dark-blue)
   (builtin        blue)
   (comments       (if doom-ayu-brighter-comments dark-cyan base5))
   (doc-comments   (doom-lighten (if doom-ayu-brighter-comments dark-cyan base5) 0.25))
   (constants      red)
   (functions      yellow)
   (keywords       blue)
   (methods        cyan)
   (operators      blue)
   (type           yellow)
   (strings        teal)
   (variables      cyan)
   (numbers        magenta)
   (region         dark-blue)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright doom-ayu-brighter-modeline)
   (-modeline-pad
    (when doom-ayu-padded-modeline
      (if (integerp doom-ayu-padded-modeline) doom-ayu-padded-modeline 4)))

   (modeline-fg     nil)
   (modeline-fg-alt base5)

   (modeline-bg
    (if -modeline-bright
        base3
        `(,(doom-darken (car bg) 0.15) ,@(cdr base0))))
   (modeline-bg-l
    (if -modeline-bright
        base3
        `(,(doom-darken (car bg) 0.1) ,@(cdr base0))))
   (modeline-bg-inactive   (doom-darken bg 0.1))
   (modeline-bg-inactive-l `(,(car bg) ,@(cdr base1))))


  ;; --- extra faces ------------------------
  ((elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   ((line-number &override) :foreground fg-alt)
   ((line-number-current-line &override) :foreground fg)
   ((line-number &override) :background (doom-darken bg 0.025))

   (font-lock-comment-face
    :foreground comments
    :background (if doom-ayu-comment-bg (doom-lighten bg 0.05)))
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments)

   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if -modeline-bright base8 highlight))
   (mode-line-buffer-id
    :foreground highlight)

   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   (telephone-line-accent-active
    :inherit 'mode-line
    :background (doom-lighten bg 0.2))
   (telephone-line-accent-inactive
    :inherit 'mode-line
    :background (doom-lighten bg 0.05))

   ;; --- major-mode faces -------------------
   ;; css-mode / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   ;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   (markdown-code-face :background (doom-lighten base3 0.05))

   ;; org-mode
   (org-hide :foreground hidden)
   (org-block :background base2)
   (org-block-begin-line :background base2 :foreground comments)
   (solaire-org-hide-face :foreground hidden))


  ;; --- extra variables ---------------------
  ;; ()
  )

;;; doom-ayu-theme.el ends here