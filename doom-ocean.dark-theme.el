;;; doom-ocean.dark-theme.el
(require 'doom-themes)

;;
(defgroup doom-ocean.dark-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-ocean.dark-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-ocean.dark-theme
  :type 'boolean)

(defcustom doom-ocean.dark-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-ocean.dark-theme
  :type 'boolean)

(defcustom doom-ocean.dark-comment-bg doom-ocean.dark-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-ocean.dark-theme
  :type 'boolean)

(defcustom doom-ocean.dark-padded-modeline nil
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-ocean.dark-theme
  :type '(or integer boolean))

;;
(def-doom-theme doom-ocean.dark
  "Doom ocean.dark theme"

  ;; name        default   256       16
  ((bg         '("#2B303B" nil       nil            ))
   (bg-alt     '("#3C4353" nil       nil            ))
   (base0      '("#111316" "#121212" "black"        ))
   (base1      '("#23262D" "#262626" "brightblack"  ))
   (base2      '("#343943" "#3A3A3A" "brightblack"  ))
   (base3      '("#464D5A" "#4E4E4E" "brightblack"  ))
   (base4      '("#576070" "#626262" "brightblack"  ))
   (base5      '("#687386" "#767676" "brightblack"  ))
   (base6      '("#7D879A" "#8A8A8A" "brightblack"  ))
   (base7      '("#939CAB" "#9E9E9E" "brightblack"  ))
   (base8      '("#AAB0BD" "#B2B2B2" "white"        ))
   (fg-alt     '("#CDD1D8" "#D0D0D0" "brightwhite"  ))
   (fg         '("#C0C5CE" "#C6C6C6" "white"        ))

   (grey       base4)
   (red        '("#BF616A" "#AF5F5F" "red"          ))
   (orange     '("#D5967A" "#D78787" "brightred"    ))
   (green      '("#82A662" "#87AF5F" "green"        ))
   (teal       '("#A3BE8C" "#AFAF87" "brightgreen"  ))
   (yellow     '("#EBCB8B" "#D7D787" "yellow"       ))
   (blue       '("#8FA1B3" "#87AFAF" "brightblue"   ))
   (dark-blue  '("#698199" "#5F8787" "blue"         ))
   (magenta    '("#9A6791" "#875F87" "magenta"      ))
   (violet     '("#B48EAD" "#AF87AF" "brightmagenta"))
   (cyan       '("#96B5B4" "#87AFAF" "brightcyan"   ))
   (dark-cyan  '("#6F9A98" "#5F8787" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-lighten bg 0.05))
   (selection      dark-blue)
   (builtin        blue)
   (comments       (if doom-ocean.dark-brighter-comments dark-cyan base5))
   (doc-comments   (doom-lighten (if doom-ocean.dark-brighter-comments dark-cyan base5) 0.25))
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
   (-modeline-bright doom-ocean.dark-brighter-modeline)
   (-modeline-pad
    (when doom-ocean.dark-padded-modeline
      (if (integerp doom-ocean.dark-padded-modeline) doom-ocean.dark-padded-modeline 4)))

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
    :background (if doom-ocean.dark-comment-bg (doom-lighten bg 0.05)))
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

;;; doom-ocean.dark-theme.el ends here