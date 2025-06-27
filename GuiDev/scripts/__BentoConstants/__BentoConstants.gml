// Feather disable all

////////////////////////////////////////////////////////////////////////////
//                                                                        //
// You're welcome to use any of the following macros in your game but ... //
//                                                                        //
//                       DO NOT EDIT THIS SCRIPT                          //
//                       Bad things might happen.                         //
//                                                                        //
//            Customisation options can be found in __BentoConfig()         //
//                                                                        //
////////////////////////////////////////////////////////////////////////////

#macro BENTO_VERSION  "2.0.0"
#macro BENTO_DATE     "2025-03-17"

#macro BENTO_RUNNING_FROM_IDE  (GM_build_type == "run")

#macro BENTO_NO_ELEMENT  noone



//Not a button. Cannot be clicked and cannot be hovered in directional input modes.
#macro BENTO_BUTTON_NEVER  0b00

//Always hoverable and clickable in any input mode.
#macro BENTO_BUTTON_ALWAYS  0b11

//Only a button in pointer input modes. Cannot be hovered in directional input modes.
#macro BENTO_BUTTON_POINTER  0b01

//Only a button in directional input modes. Cannot be clicked in pointer input modes.
#macro BENTO_BUTTON_DIRECTIONAL  0b10



//Pointer is constrained inside the focused part of the tree.
#macro BENTO_FOCUS_POINTER_CONSTRAIN  0

//Pointer ignores focus. Any part of the tree can be interacted with whilst the focus is in
//operation.
#macro BENTO_FOCUS_POINTER_IGNORE  1

//Clicking off of the focused part of the free will cancel the focus.
#macro BENTO_FOCUS_POINTER_CANCEL_ON_CLICK  2

//Clicking off of the focused part of the tree will destroy the focused element (this is good for
//pop-up menus).
#macro BENTO_FOCUS_POINTER_DESTROY_ON_CLICK  3

//Focus is cancelled automatically if the input mode is set to `BENTO_MODE_POINTER`.
#macro BENTO_FOCUS_POINTER_CANCEL_ALWAYS  4



//Child elements are never enclosed and can always be interacted with.
#macro BENTO_ENCLOSE_NEVER  0b00

//Child elements are always enclosed and cannot be interacted with unless the parent is focused.
#macro BENTO_ENCLOSE_ALWAYS  0b11

//Child elements are enclosed in directional navigation modes only. Pointer navigation modes will
//be able to select elements freely. This is useful for scrollboxes.
#macro BENTO_ENCLOSE_DIRECTIONAL  0b10

//Child elements are enclosed in pointer navigation modes only. Directional navigation modes will
//be able to select elements freely. This is probably never useful and is provided only for
//completeness.
#macro BENTO_ENCLOSE_POINTER  0b01



#macro BENTO_LAYOUT_RECT  0
#macro BENTO_LAYOUT_LIST  1
#macro BENTO_LAYOUT_GRID  2
#macro BENTO_LAYOUT_TEXT  3

//As per GameMaker's native `rectangle_in_rectangle()` function
#macro BENTO_VISIBLE_NONE     0
#macro BENTO_VISIBLE_FULL     1
#macro BENTO_VISIBLE_PARTIAL  2

#macro BENTO_AXIS_X  0
#macro BENTO_AXIS_Y  1

#macro BENTO_RESIZE_STATIC  0
#macro BENTO_RESIZE_SHRINK  1
#macro BENTO_RESIZE_EXPAND  2

#macro BENTO_MODE_UNKNOWN   0
#macro BENTO_MODE_MOUSE     1
#macro BENTO_MODE_KEYBOARD  2
#macro BENTO_MODE_GAMEPAD   3
#macro BENTO_MODE_TOUCH     4

#macro BENTO_USER_EVENT_STEP        0
#macro BENTO_USER_EVENT_DRAW        1
#macro BENTO_USER_EVENT_DRAW_AFTER  2
#macro BENTO_USER_EVENT_REPOSITION  3

#macro BENTO_TEXT_ABORT    -1
#macro BENTO_TEXT_INACTIVE  0
#macro BENTO_TEXT_PENDING   1
#macro BENTO_TEXT_CONFIRM   2

#macro BENTO_ON_WINDOWS  (os_type == os_windows)
#macro BENTO_ON_MACOS    (os_type == os_macosx)
#macro BENTO_ON_LINUX    (os_type == os_linux)
#macro BENTO_ON_DESKTOP  (BENTO_ON_WINDOWS || BENTO_ON_MACOS || BENTO_ON_LINUX)
#macro BENTO_ON_IOS      (os_type == os_ios || os_type == os_tvos)
#macro BENTO_ON_ANDROID  (os_type == os_android)
#macro BENTO_ON_MOBILE   (BENTO_ON_IOS || BENTO_ON_ANDROID)
#macro BENTO_ON_XBOX     ((os_type == os_xboxone) || (os_type == os_xboxseriesxs))
#macro BENTO_ON_PS4      (os_type == os_ps4)
#macro BENTO_ON_PS5      (os_type == os_ps5)
#macro BENTO_ON_SWITCH   (os_type == os_switch)
#macro BENTO_ON_CONSOLE  (BENTO_ON_XBOX || BENTO_ON_PS4 || BENTO_ON_PS5 || BENTO_ON_SWITCH)
#macro BENTO_ON_APPLE    (BENTO_ON_MACOS || BENTO_ON_IOS)
#macro BENTO_ON_OPERAGX  (os_type == os_operagx)
#macro BENTO_ON_WEB      ((os_browser != browser_not_a_browser) || BENTO_ON_OPERAGX)

#macro BENTO_STEAMWORKS_SUPPORT   ((BENTO_ON_LINUX || BENTO_ON_WINDOWS) && (not BENTO_ON_WEB))