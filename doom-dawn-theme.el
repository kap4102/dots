;;; doom-dawn-theme.el
(require 'doom-themes)

;;
(defgroup doom-dawn-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-dawn-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-dawn-theme
  :type 'boolean)

(defcustom doom-dawn-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-dawn-theme
  :type 'boolean)

(defcustom doom-dawn-comment-bg doom-dawn-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-dawn-theme
  :type 'boolean)

(defcustom doom-dawn-padded-modeline nil
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-dawn-theme
  :type '(or integer boolean))

;;
(def-doom-theme doom-dawn
  "Doom dawn theme"

  ;; name        default   256       16
  ((bg         '("#181B20" nil       nil            ))
   (bg-alt     '("#2B313A" nil       nil            ))
   (base0      '("#100E0D" "#121212" "black"        ))
   (base1      '("#201D19" "#1C1C1C" "brightblack"  ))
   (base2      '("#302B26" "#262626" "brightblack"  ))
   (base3      '("#3F3A32" "#3A3A3A" "brightblack"  ))
   (base4      '("#4F483F" "#444444" "brightblack"  ))
   (base5      '("#5F574B" "#585858" "brightblack"  ))
   (base6      '("#6F6558" "#626262" "brightblack"  ))
   (base7      '("#7F7465" "#767676" "brightblack"  ))
   (base8      '("#8E8271" "#87875F" "white"        ))
   (fg-alt     '("#AFA69A" "#A8A8A8" "brightwhite"  ))
   (fg         '("#9B9081" "#8A8A8A" "white"        ))

   (grey       base4)
   (red        '("#744B40" "#585858" "red"          ))
   (orange     '("#765645" "#875F5F" "brightred"    ))
   (green      '("#6D6137" "#585858" "green"        ))
   (teal       '("#6F6749" "#5F5F5F" "brightgreen"  ))
   (yellow     '("#776049" "#875F5F" "yellow"       ))
   (blue       '("#696057" "#5F5F5F" "brightblue"   ))
   (dark-blue  '("#61564B" "#585858" "blue"         ))
   (magenta    '("#6F5A59" "#626262" "magenta"      ))
   (violet     '("#6B4A49" "#585858" "brightmagenta"))
   (cyan       '("#525F66" "#5F5F5F" "brightcyan"   ))
   (dark-cyan  '("#435861" "#585858" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-lighten bg 0.05))
   (selection      dark-blue)
   (builtin        blue)
   (comments       (if doom-dawn-brighter-comments dark-cyan base5))
   (doc-comments   (doom-lighten (if doom-dawn-brighter-comments dark-cyan base5) 0.25))
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
   (-modeline-bright doom-dawn-brighter-modeline)
   (-modeline-pad
    (when doom-dawn-padded-modeline
      (if (integerp doom-dawn-padded-modeline) doom-dawn-padded-modeline 4)))

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
    :background (if doom-dawn-comment-bg (doom-lighten bg 0.05)))
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

;;; doom-dawn-theme.el ends here