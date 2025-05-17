// Feather disable all

////////////////////////////////////////////////////////////////////////////
//                                                                        //
// You're welcome to use any of the following macros in your game but ... //
//                                                                        //
//                       DO NOT EDIT THIS SCRIPT                          //
//                       Bad things might happen.                         //
//                                                                        //
//            Customisation options can be found in __GuiConfig()         //
//                                                                        //
////////////////////////////////////////////////////////////////////////////

#macro GUI_VERSION  "2.0.0"
#macro GUI_DATE     "2025-03-17"

#macro GUI_RUNNING_FROM_IDE  (GM_build_type == "run")
#macro GUI_ENVIRONMENT       (__GuiSystem().__environment)
#macro GUI_LAYER             (__GuiSystem().__environment.__layerCurrent)
#macro GUI_ROOT              (GuiGetRoot())

#macro GUI_BUTTON_NEVER    0
#macro GUI_BUTTON_POINTER  1
#macro GUI_BUTTON_ALWAYS   2

#macro GUI_AXIS_X  0
#macro GUI_AXIS_Y  1

#macro GUI_RESIZE_STATIC  0
#macro GUI_RESIZE_FIT     1
#macro GUI_RESIZE_GROW    2

#macro GUI_OFF      0b00
#macro GUI_PRESS    0b10
#macro GUI_HOLD     0b11
#macro GUI_RELEASE  0b01

// Analogues for the above
#macro GUI_ENTER  GUI_PRESS
#macro GUI_OVER   GUI_HOLD
#macro GUI_LEAVE  GUI_RELEASE

#macro GUI_NAV_UNKNOWN   0
#macro GUI_NAV_MOUSE     1
#macro GUI_NAV_KEYBOARD  2
#macro GUI_NAV_GAMEPAD   3
#macro GUI_NAV_TOUCH     4

#macro GUI_USER_EVENT_STEP        0
#macro GUI_USER_EVENT_DRAW        1
#macro GUI_USER_EVENT_DRAW_END    2
#macro GUI_USER_EVENT_REPOSITION  3

#macro GUI_FALLBACK_ORIGIN_X  (GUI_DEFAULT_LAYOUT_ALIGN_H)
#macro GUI_FALLBACK_ORIGIN_Y  (GUI_DEFAULT_LAYOUT_ALIGN_V)

#macro GUI_FOCUS_POINTER_CONSTRAIN        0
#macro GUI_FOCUS_POINTER_IGNORE           1
#macro GUI_FOCUS_POINTER_CANCEL_ON_CLICK  2
#macro GUI_FOCUS_POINTER_CANCEL_ALWAYS    3