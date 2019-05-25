;;; doom-gruvbox-dark-theme.el
(require 'doom-themes)

;;
(defgroup doom-gruvbox-dark-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-gruvbox-dark-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-gruvbox-dark-theme
  :type 'boolean)

(defcustom doom-gruvbox-dark-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-gruvbox-dark-theme
  :type 'boolean)

(defcustom doom-gruvbox-dark-comment-bg doom-gruvbox-dark-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-gruvbox-dark-theme
  :type 'boolean)

(defcustom doom-gruvbox-dark-padded-modeline nil
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-gruvbox-dark-theme
  :type '(or integer boolean))

;;
(def-doom-theme doom-gruvbox-dark
  "Doom gruvbox-dark theme"

  ;; name        default   256       16
  ((bg         '("#282828" nil       nil            ))
   (bg-alt     '("#3E3E3E" nil       nil            ))
   (base0      '("#211A09" "#121212" "black"        ))
   (base1      '("#423411" "#303030" "brightblack"  ))
   (base2      '("#624E1A" "#5F5F00" "brightblack"  ))
   (base3      '("#836822" "#875F00" "brightblack"  ))
   (base4      '("#A4822B" "#AF8700" "brightblack"  ))
   (base5      '("#C59B33" "#D7AF5F" "brightblack"  ))
   (base6      '("#D1AD50" "#D7AF5F" "brightblack"  ))
   (base7      '("#DABC70" "#D7AF5F" "brightblack"  ))
   (base8      '("#E2CB91" "#D7D787" "white"        ))
   (fg-alt     '("#EFE2C1" "#FFD7AF" "brightwhite"  ))
   (fg         '("#EBDBB2" "#D7D7AF" "white"        ))

   (grey       base4)
   (red        '("#CC241D" "#D70000" "red"          ))
   (orange     '("#E37126" "#D75F00" "brightred"    ))
   (green      '("#98971A" "#878700" "green"        ))
   (teal       '("#B8BB26" "#AFAF00" "brightgreen"  ))
   (yellow     '("#FABD2F" "#FFAF00" "yellow"       ))
   (blue       '("#83A598" "#87AF87" "brightblue"   ))
   (dark-blue  '("#458588" "#5F8787" "blue"         ))
   (magenta    '("#D3869B" "#D78787" "magenta"      ))
   (violet     '("#B16286" "#AF5F87" "brightmagenta"))
   (cyan       '("#8EC07C" "#87AF87" "brightcyan"   ))
   (dark-cyan  '("#689D6A" "#5FAF5F" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-lighten bg 0.05))
   (selection      dark-blue)
   (builtin        blue)
   (comments       (if doom-gruvbox-dark-brighter-comments dark-cyan base5))
   (doc-comments   (doom-lighten (if doom-gruvbox-dark-brighter-comments dark-cyan base5) 0.25))
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
   (-modeline-bright doom-gruvbox-dark-brighter-modeline)
   (-modeline-pad
    (when doom-gruvbox-dark-padded-modeline
      (if (integerp doom-gruvbox-dark-padded-modeline) doom-gruvbox-dark-padded-modeline 4)))

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
    :background (if doom-gruvbox-dark-comment-bg (doom-lighten bg 0.05)))
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

;;; doom-gruvbox-dark-theme.el ends here