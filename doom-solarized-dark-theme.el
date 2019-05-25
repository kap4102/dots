;;; doom-solarized-dark-theme.el
(require 'doom-themes)

;;
(defgroup doom-solarized-dark-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-solarized-dark-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-solarized-dark-theme
  :type 'boolean)

(defcustom doom-solarized-dark-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-solarized-dark-theme
  :type 'boolean)

(defcustom doom-solarized-dark-comment-bg doom-solarized-dark-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-solarized-dark-theme
  :type 'boolean)

(defcustom doom-solarized-dark-padded-modeline nil
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-solarized-dark-theme
  :type '(or integer boolean))

;;
(def-doom-theme doom-solarized-dark
  "Doom solarized-dark theme"

  ;; name        default   256       16
  ((bg         '("#002B36" nil       nil            ))
   (bg-alt     '("#005064" nil       nil            ))
   (base0      '("#0E1010" "#121212" "black"        ))
   (base1      '("#1D2121" "#1C1C1C" "brightblack"  ))
   (base2      '("#2B3131" "#303030" "brightblack"  ))
   (base3      '("#394242" "#444444" "brightblack"  ))
   (base4      '("#485252" "#4E4E4E" "brightblack"  ))
   (base5      '("#566363" "#5F5F5F" "brightblack"  ))
   (base6      '("#647373" "#6C6C6C" "brightblack"  ))
   (base7      '("#738484" "#808080" "brightblack"  ))
   (base8      '("#839393" "#8A8A8A" "white"        ))
   (fg-alt     '("#A9B4B4" "#AFAFAF" "brightwhite"  ))
   (fg         '("#93A1A1" "#9E9E9E" "white"        ))

   (grey       base4)
   (red        '("#DC322F" "#D75F00" "red"          ))
   (orange     '("#C95E18" "#D75F00" "brightred"    ))
   (green      '("#6A7A00" "#5F8700" "green"        ))
   (teal       '("#859900" "#878700" "brightgreen"  ))
   (yellow     '("#B58900" "#AF8700" "yellow"       ))
   (blue       '("#268BD2" "#0087D7" "brightblue"   ))
   (dark-blue  '("#1E6FA8" "#005FAF" "blue"         ))
   (magenta    '("#464BAE" "#5F5FAF" "magenta"      ))
   (violet     '("#6C71C4" "#5F5FD7" "brightmagenta"))
   (cyan       '("#2AA198" "#00AF87" "brightcyan"   ))
   (dark-cyan  '("#228179" "#008080" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-lighten bg 0.05))
   (selection      dark-blue)
   (builtin        blue)
   (comments       (if doom-solarized-dark-brighter-comments dark-cyan base5))
   (doc-comments   (doom-lighten (if doom-solarized-dark-brighter-comments dark-cyan base5) 0.25))
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
   (-modeline-bright doom-solarized-dark-brighter-modeline)
   (-modeline-pad
    (when doom-solarized-dark-padded-modeline
      (if (integerp doom-solarized-dark-padded-modeline) doom-solarized-dark-padded-modeline 4)))

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
    :background (if doom-solarized-dark-comment-bg (doom-lighten bg 0.05)))
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

;;; doom-solarized-dark-theme.el ends here