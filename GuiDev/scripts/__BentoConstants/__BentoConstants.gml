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

#macro GUI_VERSION  "2.0.0"
#macro GUI_DATE     "2025-03-17"

#macro GUI_RUNNING_FROM_IDE  (GM_build_type == "run")

#macro GUI_NO_ELEMENT  noone



//Not a button. Cannot be clicked and cannot be hovered in directional input modes.
#macro GUI_BUTTON_NEVER  0b00

//Always hoverable and clickable in any input mode.
#macro GUI_BUTTON_ALWAYS  0b11

//Only a button in pointer input modes. Cannot be hovered in directional input modes.
#macro GUI_BUTTON_POINTER  0b01

//Only a button in directional input modes. Cannot be clicked in pointer input modes.
#macro GUI_BUTTON_DIRECTIONAL  0b10



//Pointer is constrained inside the focused part of the tree.
#macro GUI_FOCUS_POINTER_CONSTRAIN  0

//Pointer ignores focus. Any part of the tree can be interacted with whilst the focus is in
//operation.
#macro GUI_FOCUS_POINTER_IGNORE  1

//Clicking off of the focused part of the free will cancel the focus.
#macro GUI_FOCUS_POINTER_CANCEL_ON_CLICK  2

//Clicking off of the focused part of the tree will destroy the focused element (this is good for
//pop-up menus).
#macro GUI_FOCUS_POINTER_DESTROY_ON_CLICK  3

//Focus is cancelled automatically if the input mode is set to `GUI_MODE_POINTER`.
#macro GUI_FOCUS_POINTER_CANCEL_ALWAYS  4



//Child elements are never enclosed and can always be interacted with.
#macro GUI_ENCLOSE_NEVER  0b00

//Child elements are always enclosed and cannot be interacted with unless the parent is focused.
#macro GUI_ENCLOSE_ALWAYS  0b11

//Child elements are enclosed in directional navigation modes only. Pointer navigation modes will
//be able to select elements freely. This is useful for scrollboxes.
#macro GUI_ENCLOSE_DIRECTIONAL  0b10

//Child elements are enclosed in pointer navigation modes only. Directional navigation modes will
//be able to select elements freely. This is probably never useful and is provided only for
//completeness.
#macro GUI_ENCLOSE_POINTER  0b01



#macro GUI_LAYOUT_RECT  0
#macro GUI_LAYOUT_LIST  1
#macro GUI_LAYOUT_GRID  2
#macro GUI_LAYOUT_TEXT  3

//As per GameMaker's native `rectangle_in_rectangle()` function
#macro GUI_VISIBLE_NONE     0
#macro GUI_VISIBLE_FULL     1
#macro GUI_VISIBLE_PARTIAL  2

#macro GUI_AXIS_X  0
#macro GUI_AXIS_Y  1

#macro GUI_RESIZE_STATIC  0
#macro GUI_RESIZE_SHRINK  1
#macro GUI_RESIZE_EXPAND  2

#macro GUI_MODE_UNKNOWN   0
#macro GUI_MODE_MOUSE     1
#macro GUI_MODE_KEYBOARD  2
#macro GUI_MODE_GAMEPAD   3
#macro GUI_MODE_TOUCH     4

#macro GUI_USER_EVENT_STEP        0
#macro GUI_USER_EVENT_DRAW        1
#macro GUI_USER_EVENT_DRAW_AFTER  2
#macro GUI_USER_EVENT_REPOSITION  3

#macro GUI_FALLBACK_ORIGIN_PERCENTAGE_X  (GUI_DEFAULT_LAYOUT_ALIGN_H)
#macro GUI_FALLBACK_ORIGIN_PERCENTAGE_Y  (GUI_DEFAULT_LAYOUT_ALIGN_V)

#macro GUI_TEXT_ABORT    -1
#macro GUI_TEXT_INACTIVE  0
#macro GUI_TEXT_PENDING   1
#macro GUI_TEXT_CONFIRM   2

#macro GUI_ON_WINDOWS  (os_type == os_windows)
#macro GUI_ON_MACOS    (os_type == os_macosx)
#macro GUI_ON_LINUX    (os_type == os_linux)
#macro GUI_ON_DESKTOP  (GUI_ON_WINDOWS || GUI_ON_MACOS || GUI_ON_LINUX)
#macro GUI_ON_IOS      (os_type == os_ios || os_type == os_tvos)
#macro GUI_ON_ANDROID  (os_type == os_android)
#macro GUI_ON_MOBILE   (GUI_ON_IOS || GUI_ON_ANDROID)
#macro GUI_ON_XBOX     ((os_type == os_xboxone) || (os_type == os_xboxseriesxs))
#macro GUI_ON_PS4      (os_type == os_ps4)
#macro GUI_ON_PS5      (os_type == os_ps5)
#macro GUI_ON_SWITCH   (os_type == os_switch)
#macro GUI_ON_CONSOLE  (GUI_ON_XBOX || GUI_ON_PS4 || GUI_ON_PS5 || GUI_ON_SWITCH)
#macro GUI_ON_APPLE    (GUI_ON_MACOS || GUI_ON_IOS)
#macro GUI_ON_OPERAGX  (os_type == os_operagx)
#macro GUI_ON_WEB      ((os_browser != browser_not_a_browser) || GUI_ON_OPERAGX)

#macro GUI_STEAMWORKS_SUPPORT   ((GUI_ON_LINUX || GUI_ON_WINDOWS) && (not GUI_ON_WEB))