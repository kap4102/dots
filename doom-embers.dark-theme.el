;;; doom-embers.dark-theme.el
(require 'doom-themes)

;;
(defgroup doom-embers.dark-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-embers.dark-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-embers.dark-theme
  :type 'boolean)

(defcustom doom-embers.dark-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-embers.dark-theme
  :type 'boolean)

(defcustom doom-embers.dark-comment-bg doom-embers.dark-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-embers.dark-theme
  :type 'boolean)

(defcustom doom-embers.dark-padded-modeline nil
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-embers.dark-theme
  :type '(or integer boolean))

;;
(def-doom-theme doom-embers.dark
  "Doom embers.dark theme"

  ;; name        default   256       16
  ((bg         '("#16130F" nil       nil            ))
   (bg-alt     '("#322B22" nil       nil            ))
   (base0      '("#110F0E" "#121212" "black"        ))
   (base1      '("#221F1C" "#1C1C1C" "brightblack"  ))
   (base2      '("#322E2A" "#303030" "brightblack"  ))
   (base3      '("#433E38" "#3A3A3A" "brightblack"  ))
   (base4      '("#544D46" "#4E4E4E" "brightblack"  ))
   (base5      '("#655D53" "#5F5F5F" "brightblack"  ))
   (base6      '("#766C61" "#6C6C6C" "brightblack"  ))
   (base7      '("#867C6F" "#808080" "brightblack"  ))
   (base8      '("#958B7F" "#8A8A8A" "white"        ))
   (fg-alt     '("#B5AEA6" "#AFAFAF" "brightwhite"  ))
   (fg         '("#A39A90" "#9E9E9E" "white"        ))

   (grey       base4)
   (red        '("#826D57" "#875F5F" "red"          ))
   (orange     '("#787857" "#87875F" "brightred"    ))
   (green      '("#466857" "#585858" "green"        ))
   (teal       '("#57826D" "#5F875F" "brightgreen"  ))
   (yellow     '("#6D8257" "#5F875F" "yellow"       ))
   (blue       '("#6D5782" "#5F5F87" "brightblue"   ))
   (dark-blue  '("#574668" "#585858" "blue"         ))
   (magenta    '("#684657" "#585858" "magenta"      ))
   (violet     '("#82576D" "#875F5F" "brightmagenta"))
   (cyan       '("#576D82" "#5F5F87" "brightcyan"   ))
   (dark-cyan  '("#465768" "#585858" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-lighten bg 0.05))
   (selection      dark-blue)
   (builtin        blue)
   (comments       (if doom-embers.dark-brighter-comments dark-cyan base5))
   (doc-comments   (doom-lighten (if doom-embers.dark-brighter-comments dark-cyan base5) 0.25))
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
   (-modeline-bright doom-embers.dark-brighter-modeline)
   (-modeline-pad
    (when doom-embers.dark-padded-modeline
      (if (integerp doom-embers.dark-padded-modeline) doom-embers.dark-padded-modeline 4)))

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
    :background (if doom-embers.dark-comment-bg (doom-lighten bg 0.05)))
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

;;; doom-embers.dark-theme.el ends here