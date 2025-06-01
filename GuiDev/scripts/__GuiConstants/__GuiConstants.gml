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

#macro GUI_BUTTON_NEVER        0b00
#macro GUI_BUTTON_POINTER      0b01
#macro GUI_BUTTON_DIRECTIONAL  0b10
#macro GUI_BUTTON_ALWAYS       0b11

#macro GUI_ENCLOSE_NEVER        0b00
#macro GUI_ENCLOSE_POINTER      0b01
#macro GUI_ENCLOSE_DIRECTIONAL  0b10
#macro GUI_ENCLOSE_ALWAYS       0b11

#macro GUI_LAYOUT_RECT  0
#macro GUI_LAYOUT_LIST  1
#macro GUI_LAYOUT_GRID  2
#macro GUI_LAYOUT_TEXT  3


#macro GUI_AXIS_X  0
#macro GUI_AXIS_Y  1

#macro GUI_RESIZE_STATIC  0
#macro GUI_RESIZE_SHRINK  1
#macro GUI_RESIZE_GROW    2

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

#macro GUI_FOCUS_POINTER_CONSTRAIN        0
#macro GUI_FOCUS_POINTER_IGNORE           1
#macro GUI_FOCUS_POINTER_CANCEL_ON_CLICK  2
#macro GUI_FOCUS_POINTER_CANCEL_ALWAYS    3