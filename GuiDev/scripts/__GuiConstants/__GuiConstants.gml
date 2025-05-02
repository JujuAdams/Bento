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
#macro GUI_ROOT              (GuiGetRoot())
#macro GUI_ENVIRONMENT       (__GuiSystem().__environmentCurrent)
#macro GUI_EXISTS            instance_exists

#macro GUI_BEHAVIOR_COSMETIC        0
#macro GUI_BEHAVIOR_BUTTON          1
#macro GUI_BEHAVIOR_LISTENER        2
#macro GUI_BEHAVIOR_MODAL           3
#macro GUI_BEHAVIOR_POP_UP          4
#macro GUI_BEHAVIOR_BLOCK_SIBLINGS  5

#macro GUI_AXIS_X  0
#macro GUI_AXIS_Y  1

#macro GUI_RESIZE_STATIC  0
#macro GUI_RESIZE_FIT     1
#macro GUI_RESIZE_GROW    2

#macro GUI_OFF      0
#macro GUI_PRESS    1
#macro GUI_HOLD     2
#macro GUI_RELEASE  3

// Analogues for the above
#macro GUI_ENTER  1
#macro GUI_OVER   2
#macro GUI_LEAVE  3

#macro GUI_NAV_UNKNOWN      0
#macro GUI_NAV_MOUSE        1
#macro GUI_NAV_DIRECTIONAL  2
#macro GUI_NAV_TOUCH        3

#macro GUI_USER_EVENT_STEP        0
#macro GUI_USER_EVENT_DRAW        1
#macro GUI_USER_EVENT_DRAW_END    2
#macro GUI_USER_EVENT_REPOSITION  3

#macro GUI_FALLBACK_ORIGIN_X  (GUI_DEFAULT_LAYOUT_ALIGN_H)
#macro GUI_FALLBACK_ORIGIN_Y  (GUI_DEFAULT_LAYOUT_ALIGN_V)