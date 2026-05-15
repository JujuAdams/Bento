// Feather disable all

////////////////////////////////////////////////////////////////////////////
//                                                                        //
// You're welcome to use any of the following macros in your game but ... //
//                                                                        //
//                       DO NOT EDIT THIS SCRIPT                          //
//                       Bad things might happen.                         //
//                                                                        //
//            Customisation options can be found in __BentoConfig()       //
//                                                                        //
////////////////////////////////////////////////////////////////////////////

#macro BENTO_VERSION  "2.3.3-alpha"
#macro BENTO_DATE     "2026-05-15"

#macro BENTO_RUNNING_FROM_IDE  (GM_build_type == "run")

#macro BENTO_NO_ELEMENT  noone

///////
// User Event Mapping
///////

#macro BENTO_USER_EVENT_STEP          0
#macro BENTO_USER_EVENT_DRAW          1
#macro BENTO_USER_EVENT_DRAW_AFTER    2
#macro BENTO_USER_EVENT_DRAW_HOVER    3
#macro BENTO_USER_EVENT_DRAW_DRAGGED  4
#macro BENTO_USER_EVENT_REPOSITION    5

///////
// Buttons
///////

//Not a button. Cannot be clicked and cannot be hovered in navigation input modes.
#macro BENTO_BUTTON_NEVER  0b00

//Always hoverable and clickable in any input mode.
#macro BENTO_BUTTON_ALWAYS  0b11

//Only a button in pointer input modes. Cannot be hovered in navigation input modes.
#macro BENTO_BUTTON_POINTER  0b01

//Only a button in navigation input modes. Cannot be clicked in pointer input modes.
#macro BENTO_BUTTON_NAVIGATION  0b10

///////
// Click Timing
///////

#macro BENTO_CLICK_ON_PRESS    true
#macro BENTO_CLICK_ON_RELEASE  false

///////
// Focus
///////

//Element is not focused.
#macro BENTO_FOCUS_NONE  0

//Pointer is constrained inside the focused part of the tree.
#macro BENTO_FOCUS_POINTER_CONSTRAIN  1

//Pointer ignores focus. Any part of the tree can be interacted with whilst the focus is in
//operation.
#macro BENTO_FOCUS_POINTER_IGNORE  2

//Clicking off of the focused part of the free will cancel the focus.
#macro BENTO_FOCUS_POINTER_CANCEL_ON_CLICK  3

//Clicking off of the focused part of the tree will destroy the focused element (this is good for
//pop-up menus).
#macro BENTO_FOCUS_POINTER_DESTROY_ON_CLICK  4

//Focus is cancelled automatically if the input mode is set to `BENTO_MODE_POINTER`.
#macro BENTO_FOCUS_POINTER_CANCEL_ALWAYS  5

///////
// Focus enclose
///////

//Child elements are never enclosed and can always be interacted with.
#macro BENTO_ENCLOSE_NEVER  0b00

//Child elements are always enclosed and cannot be interacted with unless the parent is focused.
#macro BENTO_ENCLOSE_ALWAYS  0b11

//Child elements are enclosed in navigation input modes only. Pointer input modes willbe able to
//hover elements freely. This is useful for scrollboxes.
#macro BENTO_ENCLOSE_NAVIGATION  0b10

//Child elements are enclosed in pointer input modes only. Navigation input modes will be able to
//hover elements freely. This is probably never useful and is provided only for completeness.
#macro BENTO_ENCLOSE_POINTER  0b01

///////
// Maintain Background Hover
///////

//The element will be unhovered when its layer is backgrounded.
#macro BENTO_MAINTAIN_NEVER  0

//The element will only remain hovered when its layer is using mouse or touch input.
#macro BENTO_MAINTAIN_POINTER  1

//This is the default value. The element will only remain hovered when its layer is using keyboard
//or gamepad input.
#macro BENTO_MAINTAIN_NAVIGATION  2

//The element will remain hovered when its layer is backgrounded regardless of input mode.
#macro BENTO_MAINTAIN_ALWAYS  3

///////
// Layout
///////

#macro BENTO_LAYOUT_RECT  0
#macro BENTO_LAYOUT_LIST  1
#macro BENTO_LAYOUT_GRID  2
#macro BENTO_LAYOUT_TEXT  3

#macro BENTO_AXIS_X  0
#macro BENTO_AXIS_Y  1

#macro BENTO_RESIZE_NORMAL   0
#macro BENTO_RESIZE_DEFLATE  1
#macro BENTO_RESIZE_INFLATE  2
#macro BENTO_RESIZE_ASPECT   3

///////
// Visibility
///////

//As per GameMaker's native `rectangle_in_rectangle()` function
#macro BENTO_VISIBLE_NONE     0
#macro BENTO_VISIBLE_FULL     1
#macro BENTO_VISIBLE_PARTIAL  2

///////
// Input
///////

#macro BENTO_MODE_UNKNOWN   0
#macro BENTO_MODE_MOUSE     1
#macro BENTO_MODE_KEYBOARD  2
#macro BENTO_MODE_GAMEPAD   3
#macro BENTO_MODE_TOUCH     4

// These are used to indicate text input state.

#macro BENTO_TEXT_ERROR    -666
#macro BENTO_TEXT_ABORT    -1
#macro BENTO_TEXT_INACTIVE  0
#macro BENTO_TEXT_PENDING   1
#macro BENTO_TEXT_CONFIRM   2

///////
// OS Checks
///////

// These are general purpose checks that are available if needed. Many are not used.

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
#macro BENTO_ON_DIRECTX  ((not BENTO_ON_WEB) && (BENTO_ON_WINDOWS || BENTO_ON_XBOX))
#macro BENTO_ON_OPENGL   (not BENTO_ON_DIRECTX)
#macro BENTO_ON_WEB      ((os_browser != browser_not_a_browser) || BENTO_ON_OPERAGX)

#macro BENTO_STEAMWORKS_SUPPORT   ((BENTO_ON_LINUX || BENTO_ON_WINDOWS) && (not BENTO_ON_WEB))

#macro BENTO_IN_GUI_DRAW_EVENT  ((event_type == ev_draw) && ((event_number == ev_gui) || (event_number == ev_gui) || (event_number == ev_gui)))