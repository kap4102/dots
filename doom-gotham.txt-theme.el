;;; doom-gotham.txt-theme.el
(require 'doom-themes)

;;
(defgroup doom-gotham.txt-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-gotham.txt-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-gotham.txt-theme
  :type 'boolean)

(defcustom doom-gotham.txt-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-gotham.txt-theme
  :type 'boolean)

(defcustom doom-gotham.txt-comment-bg doom-gotham.txt-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-gotham.txt-theme
  :type 'boolean)

(defcustom doom-gotham.txt-padded-modeline nil
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-gotham.txt-theme
  :type '(or integer boolean))

;;
(def-doom-theme doom-gotham.txt
  "Doom gotham.txt theme"

  ;; name        default   256       16
  ((bg         '("#0A0F14" nil       nil            ))
   (bg-alt     '("#1A2734" nil       nil            ))
   (base0      '("#0B1918" "#121212" "black"        ))
   (base1      '("#163231" "#262626" "brightblack"  ))
   (base2      '("#214B49" "#3A3A3A" "brightblack"  ))
   (base3      '("#2D6461" "#4E4E4E" "brightblack"  ))
   (base4      '("#387D79" "#5F8787" "brightblack"  ))
   (base5      '("#439692" "#5F8787" "brightblack"  ))
   (base6      '("#4EAFAA" "#5FAFAF" "brightblack"  ))
   (base7      '("#66BBB6" "#5FAFAF" "brightblack"  ))
   (base8      '("#7FC6C2" "#87D7AF" "white"        ))
   (fg-alt     '("#ADDAD8" "#AFD7D7" "brightwhite"  ))
   (fg         '("#98D1CE" "#87D7D7" "white"        ))

   (grey       base4)
   (red        '("#C33027" "#AF5F00" "red"          ))
   (orange     '("#734244" "#4E4E4E" "brightred"    ))
   (green      '("#26A98B" "#00AF87" "green"        ))
   (teal       '("#081F2D" "#1C1C1C" "brightgreen"  ))
   (yellow     '("#245361" "#005F5F" "yellow"       ))
   (blue       '("#093748" "#303030" "brightblue"   ))
   (dark-blue  '("#195465" "#005F5F" "blue"         ))
   (magenta    '("#888BA5" "#8787AF" "magenta"      ))
   (violet     '("#4E5165" "#585858" "brightmagenta"))
   (cyan       '("#599CAA" "#5FAFAF" "brightcyan"   ))
   (dark-cyan  '("#33859D" "#5F87AF" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-lighten bg 0.05))
   (selection      dark-blue)
   (builtin        blue)
   (comments       (if doom-gotham.txt-brighter-comments dark-cyan base5))
   (doc-comments   (doom-lighten (if doom-gotham.txt-brighter-comments dark-cyan base5) 0.25))
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
   (-modeline-bright doom-gotham.txt-brighter-modeline)
   (-modeline-pad
    (when doom-gotham.txt-padded-modeline
      (if (integerp doom-gotham.txt-padded-modeline) doom-gotham.txt-padded-modeline 4)))

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
    :background (if doom-gotham.txt-comment-bg (doom-lighten bg 0.05)))
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

;;; doom-gotham.txt-theme.el ends here