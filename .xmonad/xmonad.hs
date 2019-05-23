import XMonad
import XMonad.Util.EZConfig
import XMonad.Config.Kde
import XMonad.Layout.SubLayouts
import XMonad.Layout.PerWorkspace
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Magnifier
import XMonad.Layout.Master
import XMonad.Layout.Mosaic
import XMonad.Layout.MosaicAlt
import XMonad.Layout.Spacing
import XMonad.Layout.WindowArranger
import XMonad.Layout.WindowNavigation as N
import XMonad.Layout.Hidden
import XMonad.Layout.Groups.Wmii
import XMonad.Actions.Submap
import XMonad.Hooks.ManageDocks
import qualified Data.Map as M
import qualified XMonad.Layout.Groups as G
import XMonad.Layout.Master
import XMonad.Layout.BinarySpacePartition
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Hidden
import XMonad.Layout.Stoppable
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.Spacing
import qualified XMonad.StackSet as W
import XMonad.Actions.CopyWindow
import Data.Monoid
import System.Exit
import Data.List
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.LayoutScreens
import XMonad.Layout.TwoPane
import XMonad.Layout.ZoomRow
import XMonad.Layout.Combo
import XMonad.Layout.Groups.Examples
import XMonad.Layout.BinaryColumn
import qualified XMonad.Layout.GridVariants as GV
import XMonad.Layout.AutoMaster
import XMonad.Layout.Master
import qualified XMonad.Layout.MultiToggle as MT
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise
import XMonad.Prompt.Shell
import XMonad.Layout.Groups.Helpers
import XMonad.Actions.FocusNth
import XMonad.Layout.ResizableTile
import XMonad.Layout.DwmStyle
import XMonad.Layout.Spacing
import XMonad.Layout.Maximize
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.Navigation2D
import XMonad.Actions.CycleWS

-- subLayout [0,1] (windowNavigation $ emptyBSP ||| Tall 5 (3/100) (1/2)) $ Mirror rowOfColumns
-- subLayout [] (windowNavigation $ emptyBSP) $ windowNavigation $ rowOfColumns
myLayouts = -- subLayout [] emptyBSP $ (Mirror (BinaryColumn 0.7 16)) |||
  subLayout [] (ResizableTall 0 (3/100) (1/2) []) $ (Mirror $ ResizableTall 0 (3/100) (1/2) []) |||
  -- subLayout [] (ResizableTall 0 (3/100) (1/2) []) $ emptyBSP |||
  -- subLayout [] emptyBSP $ (Mirror (BinaryColumn 0.7 16)) |||
  -- ResizableTall 1 (3/100) (1/2) [] |||
  rowOfColumns |||
  mastered (1/100) (1/2) rowOfColumns |||
  emptyBSP |||
  mastered (1/100) (1/2) emptyBSP
  -- (stoppable rowOfColumns)
  -- |||  Tall 1 (3/100) (1/2) ||| mosaic 2 [3,2]

myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

myManageHook = composeAll . concat $
  [ [ className   =? c --> doFloat   | c <- myFloats] ]

    where myFloats = ["plasmashell","krunner"]

main =  xmonad $ ewmh $ kdeConfig
  { manageHook  = manageHook kdeConfig <+> myManageHook
  , borderWidth = 2
  , workspaces  = myWorkspaces
  , modMask     = mod4Mask
  , layoutHook  = avoidStruts $ (windowNavigation $ (hiddenWindows $ (maximize $ (spacing 6 $ myLayouts))))
  , logHook     = dynamicLog
  , keys        = myKeys
  , terminal    = "st"
  , normalBorderColor  = "#1d252c"
  , focusedBorderColor = "#cd8b00"
  }

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [
      -- launch a terminal
    -- -- [ ((mod4Mask, xK_o), submap . M.fromList $
    --  ((mod4Mask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    -- --close focused window
    -- , ((mod4Mask .|. shiftMask, xK_c     ), kill1)
    --  -- Rotate through the available layout algorithms
    -- , ((mod4Mask,               xK_space ), sendMessage NextLayout)
    -- --  Reset the layouts on the current workspace to default
    -- , ((mod4Mask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    -- -- Resize viewed windows to the correct size
    -- , ((mod4Mask,               xK_n     ), refresh)
    -- -- Move focus to the next window
    -- , ((mod4Mask,               xK_Tab   ), windows W.focusDown)
    -- -- Move focus to the next window
    -- , ((mod4Mask,               xK_j     ), windows W.focusDown)
    -- -- Move focus to the previous window
    -- , ((mod4Mask,               xK_k     ), windows W.focusUp)
    -- -- Move focus to the master window
    -- , ((mod4Mask,               xK_m     ), windows W.focusMaster)
    -- -- Swap the focused window and the master window
    -- , ((mod4Mask,               xK_Return), windows W.swapMaster)
    -- -- Swap the focused window with the next window
    -- , ((mod4Mask .|. shiftMask, xK_j     ), windows W.swapDown)
    -- -- Swap the focused window with the previous window
    -- , ((mod4Mask .|. shiftMask, xK_k     ), windows W.swapUp)
    -- -- Shrink the master area
    -- , ((mod4Mask,               xK_h     ), sendMessage Shrink)
    -- -- Expand the master area
    -- , ((mod4Mask,               xK_l     ), sendMessage Expand)
    -- -- Push window back into tiling
      ((mod4Mask,               xK_t     ), withFocused $ windows . W.sink)
    -- -- Increment the number of windows in the master area
    , ((mod4Mask              , xK_comma ), sendMessage (IncMasterN 1))
    -- Deincrement the number of windows in the master area
    , ((mod4Mask              , xK_period), sendMessage (IncMasterN (-1)))
    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    , ((modm              , xK_b     ), sendMessage ToggleStruts)
    -- Quit xmonad
    --, ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    ---- Restart xmonad
    , ((modm .|. controlMask .|. shiftMask, xK_r     ), spawn "xmonad --recompile; xmonad --restart > ~/.xmonad/xmonad.status")
    , ((modm .|. controlMask, xK_x), runOrRaisePrompt def)
    , ((mod4Mask .|. controlMask , xK_s), sendMessage  Arrange)
    , ((mod4Mask .|. controlMask .|. shiftMask, xK_s), sendMessage  DeArrange)
    , ((mod4Mask .|. controlMask , xK_h), sendMessage (MoveLeft 1))
    , ((mod4Mask .|. controlMask , xK_l), sendMessage (MoveRight 1))
    , ((mod4Mask .|. controlMask , xK_j), sendMessage (MoveDown 1))
    , ((mod4Mask .|. controlMask , xK_k), sendMessage (MoveUp  1))
    , ((mod4Mask .|. shiftMask, xK_h ), sendMessage (IncreaseLeft 1))
    , ((mod4Mask .|. shiftMask, xK_l), sendMessage (IncreaseRight 1))
    , ((mod4Mask .|. shiftMask, xK_j ), sendMessage (IncreaseDown 1))
    , ((mod4Mask .|. shiftMask, xK_k   ), sendMessage (IncreaseUp 1))
    , ((mod4Mask .|. controlMask .|. shiftMask, xK_h ), sendMessage (DecreaseLeft 1))
    , ((mod4Mask .|. controlMask .|. shiftMask, xK_l), sendMessage (DecreaseRight 1))
    , ((mod4Mask .|. controlMask .|. shiftMask, xK_j ), sendMessage (DecreaseDown 1))
    , ((mod4Mask .|. controlMask .|. shiftMask, xK_k   ), sendMessage (DecreaseUp 1))
    , ((mod4Mask, xK_l), sendMessage $ N.Go R)
    , ((mod4Mask, xK_h ), sendMessage $ N.Go L)
    , ((mod4Mask, xK_k   ), sendMessage $ N.Go U)
    , ((mod4Mask, xK_j ), sendMessage $ N.Go D)
    , ((mod4Mask .|. controlMask, xK_l), sendMessage $ N.Swap R)
    , ((mod4Mask .|. controlMask, xK_h), sendMessage $ N.Swap L)
    , ((mod4Mask .|. controlMask, xK_k), sendMessage $ N.Swap U)
    , ((mod4Mask .|. controlMask, xK_j), sendMessage $ N.Swap D)
    , ((mod4Mask, xK_m), withFocused hideWindow)
    , ((mod4Mask .|. shiftMask, xK_m), popOldestHiddenWindow)
    , ((mod4Mask, xK_f), toggleGroupFull)
    , ((mod4Mask, xK_i), zoomGroupIn)
    , ((mod4Mask, xK_o), zoomGroupOut)
    , ((mod4Mask .|. shiftMask, xK_f), toggleGroupFull)
    , ((mod4Mask .|. shiftMask, xK_i), zoomGroupIn)
    , ((mod4Mask .|. shiftMask, xK_o), zoomGroupOut)
    , ((mod4Mask, xK_n), groupToNextLayout)
    , ((mod4Mask .|. mod1Mask, xK_l ), sendMessage $ ExpandTowards R)
    , ((mod4Mask .|. mod1Mask, xK_h ), sendMessage $ ExpandTowards L)
    , ((mod4Mask .|. mod1Mask, xK_j ), sendMessage $ ExpandTowards D)
    , ((mod4Mask .|. mod1Mask, xK_k ), sendMessage $ ExpandTowards U)
    , ((mod4Mask .|. mod1Mask .|. controlMask , xK_l), sendMessage $ ShrinkFrom R)
    , ((mod4Mask .|. mod1Mask .|. controlMask , xK_h), sendMessage $ ShrinkFrom L)
    , ((mod4Mask .|. mod1Mask .|. controlMask , xK_j), sendMessage $ ShrinkFrom D)
    , ((mod4Mask .|. mod1Mask .|. controlMask , xK_k), sendMessage $ ShrinkFrom U)
    , ((mod4Mask .|. mod1Mask, xK_r), sendMessage Rotate)
    , ((mod4Mask, xK_n), sendMessage FocusParent)
    , ((mod4Mask .|. controlMask, xK_n), sendMessage SelectNode)
    , ((mod4Mask .|. shiftMask, xK_n), sendMessage MoveNode)
    ,  ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    --close focused window
    , ((modm .|. shiftMask, xK_c), kill)
      -- Rotate through the available layout algorithms
    -- , ((modm, xK_space), sendMessage NextLayout)
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    -- Resize viewed windows to the correct size
    , ((modm, xK_n ), refresh)
    -- Move focus to the next window
    , ((modm, xK_Tab), windows W.focusDown)
    -- Move focus to the next window
    -- , ((modm,               xK_space ), sendMessage NextLayout)
    , ((modm, xK_q), kill1)
    , ((modm .|. shiftMask, xK_a), withFocused (sendMessage . expandWindowAlt))
    , ((modm .|. shiftMask, xK_z), withFocused (sendMessage . shrinkWindowAlt))
    , ((modm .|. shiftMask, xK_s), withFocused (sendMessage . tallWindowAlt))
    , ((modm .|. shiftMask, xK_d), withFocused (sendMessage . wideWindowAlt))
    , ((modm .|. controlMask, xK_space), sendMessage resetAlt)
    , ((modm , xK_F1), spawn "rofi_run -w")
    , ((modm , xK_F2), spawn "rofi_run -r")
    , ((mod4Mask, xK_b), submap . M.fromList $
        [ ((controlMask .|. shiftMask, xK_l), sendMessage $ Move R)
        , ((controlMask .|. shiftMask, xK_h ), sendMessage $ Move L)
        , ((controlMask .|. shiftMask, xK_k   ), sendMessage $ Move U)
        , ((controlMask .|. shiftMask, xK_j ), sendMessage $ Move D)
        , ((mod1Mask, xK_l), sendMessage $ ExpandTowards R)
        , ((mod1Mask, xK_h), sendMessage $ ExpandTowards L)
        , ((mod1Mask, xK_j), sendMessage $ ExpandTowards D)
        , ((mod1Mask, xK_k), sendMessage $ ExpandTowards U)
        , ((mod1Mask .|. controlMask , xK_l), sendMessage $ ShrinkFrom R)
        , ((mod1Mask .|. controlMask , xK_h), sendMessage $ ShrinkFrom L)
        , ((mod1Mask .|. controlMask , xK_j), sendMessage $ ShrinkFrom D)
        , ((mod1Mask .|. controlMask , xK_k), sendMessage $ ShrinkFrom U)
        , ((0, xK_r), sendMessage $ Rotate)
        -- , ((0,                      xK_s ), sendMessage $ Swap)
        , ((0, xK_n), sendMessage $ FocusParent)
        , ((controlMask, xK_n), sendMessage $ SelectNode)
        , ((shiftMask, xK_n), sendMessage $ MoveNode)
        , ((mod4Mask, xK_a),sendMessage $ Balance)
        , ((mod4Mask .|. shiftMask, xK_a),sendMessage $ Equalize)
        ])
    , ((mod4Mask, xK_s), submap . M.fromList $
      [   ((0, xK_k), focusUp)
        , ((0, xK_j), focusDown)
        , ((0, xK_u), focusUp)
        , ((0, xK_d), focusDown)
        , ((0, xK_s), splitGroup)
        --, ((0, xK_n), focusGroupUp)
        --, ((0, xK_m), focusGroupDown)
        , ((shiftMask, xK_n), swapGroupUp)
        , ((shiftMask, xK_m), swapGroupDown)
        , ((mod1Mask .|. shiftMask, xK_u), (moveToGroupUp True))
        , ((mod1Mask .|. shiftMask, xK_d), (moveToGroupDown True))
        , ((mod1Mask .|. controlMask .|. shiftMask, xK_n), moveToNewGroupUp)
        , ((mod1Mask .|. controlMask .|. shiftMask, xK_m), moveToNewGroupDown)
        , ((shiftMask, xK_k), swapGroupUp)
        , ((shiftMask, xK_j), swapGroupDown)
        , ((mod1Mask , xK_k), (moveToGroupUp True))
        , ((mod1Mask , xK_j), (moveToGroupDown True))
        , ((controlMask, xK_k), moveToNewGroupUp)
        , ((controlMask, xK_j), moveToNewGroupDown)
        --, ((0 xK_Return), focusGroupMaster)
        --, ((shiftMask, xK_Return), swapGroupMaster)
        , ((0, xK_f), toggleWindowFull)
        , ((shiftMask, xK_f), toggleGroupFull)
        , ((0, xK_plus), zoomGroupIn)
        , ((0, xK_minus), zoomGroupOut)
        , ((0, xK_n), groupToNextLayout)
      ])
    , ((mod4Mask, xK_a), submap . M.fromList $
        [ ((shiftMask, xK_u), swapUp )
        , ((shiftMask, xK_d), swapDown)
        , ((modm, xK_m), withFocused (sendMessage . maximizeRestore))
        , ((modm .|. shiftMask,                 xK_e), layoutScreens 2 (TwoPane 0.5 0.5))
        , ((modm .|. controlMask .|. shiftMask, xK_e), rescreen)
        , ((0, xK_u), focusUp)
        , ((0, xK_d), focusDown)
        , ((0, xK_s), splitGroup)
        --, ((0, xK_n), focusGroupUp)
        --, ((0, xK_m), focusGroupDown)
        , ((shiftMask, xK_n), swapGroupUp)
        , ((shiftMask, xK_m), swapGroupDown)
        , ((mod1Mask .|. shiftMask, xK_u), (moveToGroupUp True))
        , ((mod1Mask .|. shiftMask, xK_d), (moveToGroupDown True))
        , ((mod1Mask .|. controlMask .|. shiftMask, xK_n), moveToNewGroupUp)
        , ((mod1Mask .|. controlMask .|. shiftMask, xK_m), moveToNewGroupDown)
        --, ((0 xK_Return), focusGroupMaster)
        --, ((shiftMask, xK_Return), swapGroupMaster)
        , ((0, xK_f), toggleWindowFull)
        , ((mod4Mask, xK_f), toggleGroupFull)
        , ((0, xK_i), zoomGroupIn)
        , ((0, xK_o), zoomGroupOut)
        , ((0, xK_n), groupToNextLayout)
        , ((0, xK_t), sendMessage Taller)
        , ((0, xK_w), sendMessage Wider)
        , ((0, xK_r), sendMessage Reset)
        , ((0, xK_c), killAllOtherCopies)
        , ((0, xK_a), windows copyToAll)
        , ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
        --close focused window
        , ((modm .|. shiftMask, xK_c), kill1)
         -- Rotate through the available layout algorithms
        --  Reset the layouts on the current workspace to default
        , ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)
        -- Resize viewed windows to the correct size
        , ((modm, xK_n), refresh)
        -- Move focus to the next window
        , ((modm, xK_Tab), windows W.focusDown)
        -- Move focus to the next window
        , ((modm, xK_j), windows W.focusDown)
        -- Move focus to the previous window
        , ((modm, xK_k), windows W.focusUp)
        -- Move focus to the master window
        , ((modm, xK_m), windows W.focusMaster)
        -- Swap the focused window and the master window
        , ((modm, xK_Return), windows W.swapMaster)
        -- Swap the focused window with the next window
        , ((modm .|. shiftMask, xK_j), windows W.swapDown)
        -- Swap the focused window with the previous window
        , ((modm .|. shiftMask, xK_k ), windows W.swapUp)
        -- Shrink the master area
        , ((modm, xK_h), sendMessage Shrink)
        -- Expand the master area
        , ((modm, xK_l), sendMessage Expand)
        -- Push window back into tiling
        , ((modm, xK_t), withFocused $ windows . W.sink)
        -- Increment the number of windows in the master area
        , ((modm , xK_comma), sendMessage (IncMasterN 1))
        -- Deincrement the number of windows in the master area
        , ((modm , xK_period), sendMessage (IncMasterN (-1)))
        ,  ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
        , ((modm .|. shiftMask, xK_a), withFocused (sendMessage . expandWindowAlt))
        , ((modm .|. shiftMask, xK_z), withFocused (sendMessage . shrinkWindowAlt))
        , ((modm .|. shiftMask, xK_s), withFocused (sendMessage . tallWindowAlt))
        , ((modm .|. shiftMask, xK_d), withFocused (sendMessage . wideWindowAlt))
        , ((modm .|. controlMask, xK_space), sendMessage resetAlt)
        , ((0, xK_m), withFocused hideWindow)
        , ((mod4Mask, xK_m), popOldestHiddenWindow)
        , ((mod1Mask, xK_m), popNewestHiddenWindow)
        , ((0, xK_minus), zoomWindowOut)
        , ((0, xK_plus), zoomWindowIn)
        , ((0,  xK_r), zoomWindowReset)
        , ((0,  xK_f), toggleWindowFull)
        , ((mod4Mask, xK_minus), zoomColumnOut)
        , ((mod4Mask, xK_plus), zoomColumnIn)
        , ((mod4Mask, xK_r), zoomColumnReset)
        , ((mod4Mask, xK_f), toggleColumnFull)
        , ((0, xK_u), focusUp)
        , ((0, xK_d), focusDown)
        , ((0, xK_s), splitGroup)
        , ((0, xK_n), focusGroupUp)
        , ((0, xK_m), focusGroupDown)
        , ((shiftMask, xK_n), swapGroupUp)
        , ((shiftMask, xK_m), swapGroupDown)
        , ((mod4Mask .|. shiftMask, xK_u), (moveToGroupUp False))
        , ((mod4Mask .|. shiftMask, xK_d), (moveToGroupDown False))
        , ((mod4Mask .|. controlMask .|. shiftMask, xK_u), moveToNewGroupUp)
        , ((mod4Mask .|. controlMask .|. shiftMask, xK_d), moveToNewGroupDown)
        ])
    , ((mod4Mask, xK_d), submap . M.fromList $
        [ ((mod4Mask .|. controlMask, xK_s), toSubl Arrange)
        , ((controlMask .|. shiftMask, xK_s), toSubl DeArrange)
        , ((controlMask, xK_h), toSubl (MoveLeft  1))
        , ((controlMask, xK_l), toSubl (MoveRight 1))
        , ((controlMask, xK_j), toSubl (MoveDown  1))
        , ((controlMask, xK_k), toSubl (MoveUp 1))
        , ((shiftMask, xK_h ), toSubl (IncreaseLeft 1))
        , ((shiftMask, xK_l), toSubl (IncreaseRight 1))
        , ((shiftMask, xK_j ), toSubl (IncreaseDown 1))
        , ((shiftMask, xK_k   ), toSubl (IncreaseUp  1))
        , ((controlMask .|. shiftMask, xK_h), toSubl (DecreaseLeft 1))
        , ((controlMask .|. shiftMask, xK_l), toSubl (DecreaseRight 1))
        , ((controlMask .|. shiftMask, xK_j), toSubl (DecreaseDown 1))
        , ((controlMask .|. shiftMask, xK_k), toSubl (DecreaseUp 1))
        , ((0, xK_l), toSubl $ N.Go R)
        , ((0, xK_h ), toSubl $ N.Go L)
        , ((0, xK_k   ), toSubl $ N.Go U)
        , ((0, xK_j ), toSubl $ N.Go D)
        , ((controlMask, xK_l), toSubl $ N.Swap R)
        , ((controlMask, xK_h ), toSubl $ N.Swap L)
        , ((controlMask, xK_k   ), toSubl $ N.Swap U)
        , ((controlMask, xK_j ), toSubl $ N.Swap D)
        , ((0, xK_e), withFocused (toSubl . expandWindowAlt))
        , ((0, xK_s), withFocused (toSubl . shrinkWindowAlt))
        , ((0, xK_t), withFocused (toSubl . tallWindowAlt))
        , ((0, xK_w), withFocused (toSubl . wideWindowAlt))
        , ((0, xK_space), toSubl resetAlt)
        , ((0, xK_n), toSubl NextLayout)
        , ((mod4Mask, xK_j), windows W.focusDown)
        -- Move focus to the previous window
        , ((mod4Mask, xK_k), windows W.focusUp)
        -- Move focus to the master window
        , ((mod4Mask, xK_m), windows W.focusMaster)
        -- Swap the focused window and the master window
        , ((mod4Mask, xK_Return), windows W.swapMaster)
        -- Swap the focused window with the next window
        , ((mod4Mask .|. shiftMask, xK_j), windows W.swapDown)
        -- Swap the focused window with the previous window
        , ((mod4Mask .|. shiftMask, xK_k), windows W.swapUp)
        -- Shrink the master area
        , ((mod4Mask, xK_h     ), toSubl Shrink)
        -- Expand the master area
        , ((mod4Mask, xK_l     ), toSubl Expand)
        -- Push window back into tiling
        , ((mod4Mask, xK_t     ), withFocused $ windows . W.sink)
        -- Increment the number of windows in the master area
        , ((mod4Mask , xK_comma ), toSubl (IncMasterN 1))
        -- Deincrement the number of windows in the master area
        , ((mod4Mask, xK_period), toSubl (IncMasterN (-1)))
        , ((modm,               xK_a), toSubl MirrorShrink)
        , ((modm,               xK_z), toSubl MirrorExpand)
        , ((mod4Mask .|. controlMask, xK_h), sendMessage $ pullGroup L)
        , ((mod4Mask .|. controlMask, xK_l), sendMessage $ pullGroup R)
        , ((mod4Mask .|. controlMask, xK_k), sendMessage $ pullGroup U)
        , ((mod4Mask .|. controlMask, xK_j), sendMessage $ pullGroup D)
        , ((mod4Mask .|. mod1Mask, xK_h), sendMessage $ pushGroup L)
        , ((mod4Mask .|. mod1Mask, xK_l), sendMessage $ pushGroup R)
        , ((mod4Mask .|. mod1Mask, xK_k), sendMessage $ pushGroup U)
        , ((mod4Mask .|. mod1Mask, xK_j), sendMessage $ pushGroup D)
        , ((controlMask .|. mod1Mask, xK_h), sendMessage $ pullWindow L)
        , ((controlMask .|. mod1Mask, xK_l), sendMessage $ pullWindow R)
        , ((controlMask .|. mod1Mask, xK_k), sendMessage $ pullWindow U)
        , ((controlMask .|. mod1Mask, xK_j), sendMessage $ pullWindow D)
        , ((mod1Mask, xK_h), sendMessage $ pushWindow L)
        , ((mod1Mask, xK_l), sendMessage $ pushWindow R)
        , ((mod1Mask, xK_k), sendMessage $ pushWindow U)
        , ((mod1Mask, xK_j), sendMessage $ pushWindow D)
        , ((controlMask, xK_m), withFocused (sendMessage . MergeAll))
        , ((controlMask, xK_u), withFocused (sendMessage . UnMerge))
        , ((controlMask, xK_period), onGroup W.focusUp')
        , ((controlMask, xK_comma), onGroup W.focusDown')
        , ((mod1Mask .|. shiftMask, xK_u), (moveToGroupUp False))
        , ((mod1Mask .|. shiftMask, xK_d), (moveToGroupDown False))
        , ((modm, xK_a), toSubl MirrorShrink)
        , ((modm, xK_z), toSubl MirrorExpand)
        ])
    , ((mod4Mask, xK_z), submap . M.fromList $
      [
        ((0, xK_f), runOrCopy "firefox" (className =? "Firefox"))
      , ((0, xK_e), runOrCopy "emacs" (className =? "emacs"))
      , ((0, xK_t), runOrCopy "main" (className =? "st"))
      ])
    , ((mod4Mask, xK_plus), sendMessage MirrorExpand)
    , ((mod4Mask, xK_minus), sendMessage MirrorShrink)
    , ((mod4Mask .|. shiftMask, xK_plus), toSubl MirrorExpand)
    , ((mod4Mask .|. shiftMask, xK_minus), toSubl MirrorShrink)
    , ((mod4Mask .|. controlMask, xK_c), shellPrompt def)
    , ((mod4Mask, xK_w), submap . M.fromList $
      [ ((0, xK_x), removeWorkspace)
      , ((0, xK_a), selectWorkspace def)
      , ((0, xK_w), selectWorkspace def)
      , ((0, xK_m), withWorkspace def (windows . W.shift))
      , ((0, xK_m), withWorkspace def (windows . copy))
      , ((0, xK_c), withWorkspace def (windows . W.shift))
      , ((0, xK_c), withWorkspace def (windows . copy))
      , ((0, xK_s), addWorkspacePrompt def)
      , ((0, xK_r), renameWorkspace def)
      , ((0,xK_j),  nextWS)
      , ((0,xK_k),    prevWS)
      , ((shiftMask, xK_j),  shiftToNext)
      , ((shiftMask, xK_k),    shiftToPrev)
      , ((0,xK_l), nextScreen)
      , ((0,xK_h),  prevScreen)
      , ((shiftMask, xK_l), shiftNextScreen)
      , ((shiftMask, xK_h),  shiftPrevScreen)
      , ((0,K_z),     toggleWS)
      ])
      , ((mod4Mask, xK_space), submap . M.fromList $
       [((0, xK_b), submap . M.fromList $
        [
         ((mod1Mask, xK_l), sendMessage $ ExpandTowards R)
       , ((mod1Mask, xK_h), sendMessage $ ExpandTowards L)
       , ((mod1Mask, xK_j), sendMessage $ ExpandTowards D)
       , ((mod1Mask, xK_k), sendMessage $ ExpandTowards U)
       , ((controlMask, xK_l), sendMessage $ ShrinkFrom R)
       , ((controlMask, xK_h), sendMessage $ ShrinkFrom L)
       , ((controlMask, xK_j), sendMessage $ ShrinkFrom D)
       , ((controlMask, xK_k), sendMessage $ ShrinkFrom U)
       , ((0, xK_r), sendMessage Rotate)
       -- , ((modm,                           xK_s     ), sendMessage Swap)
       , ((0, xK_n), sendMessage FocusParent)
       , ((controlMask,xK_n     ), sendMessage SelectNode)
       , ((shiftMask, xK_n), sendMessage MoveNode)
       , ((0, xK_a),     sendMessage Balance)
       , ((shiftMask, dMessage Equalize)

        ])
        , ((0, xK_space), sendMessage NextLayout)
        , ((0, xK_w), submap . M.fromList $
            [ ((0, xK_x), removeWorkspace)
            , ((0, xK_a      ), selectWorkspace def)
            , ((0, xK_w      ), selectWorkspace def)
            , ((0, xK_m                    ), withWorkspace def (windows . W.shift))
            , ((0, xK_m      ), withWorkspace def (windows . copy))
            , ((0, xK_c                    ), withWorkspace def (windows . W.shift))
            , ((0, xK_c      ), withWorkspace def (windows . copy))
            , ((0, xK_s      ), addWorkspacePrompt def)
            , ((0, xK_r      ), renameWorkspace def)
            , ((0,               xK_j),  nextWS)
            , ((0,               xK_k),    prevWS)
            , ((shiftMask, xK_j),  shiftToNext)
            , ((shiftMask, xK_k),    shiftToPrev)
            , ((0,               xK_l), nextScreen)
            , ((0,               xK_h),  prevScreen)
            , ((shiftMask, xK_l), shiftNextScreen)
            , ((shiftMask, xK_h),  shiftPrevScreen)
            , ((0,               xK_z),     toggleWS)
      ])
       ])
  ]
 ++
    --
    -- MOD-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    -- mod-control-[1..9], Copy client to workspace N
    --
  [((m .|. mod4Mask, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask), (copy, controlMask)]
  ]

 -- ++
 -- [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
 --     | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
 -- mod-[1..9]         %! Switch to workspace of index N
-- mod-control-[1..9] %! Set index N to the current workspace
   ++
   zip (zip (repeat (modm)) [xK_1..xK_9]) (map (withWorkspaceIndex W.greedyView) [1..])
   ++
   zip (zip (repeat (modm .|. controlMask)) [xK_1..xK_9]) (map (setWorkspaceIndex) [1..])--     , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

