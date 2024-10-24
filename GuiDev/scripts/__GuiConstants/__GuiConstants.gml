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

#macro GUI_VERSION  "1.8.0"
#macro GUI_DATE     "2024-10-24"

#macro GUI_ROOT  (__GuiGetRoot())

#macro GUI_BEHAVIOR_COSMETIC        0
#macro GUI_BEHAVIOR_BUTTON          1
#macro GUI_BEHAVIOR_LISTENER        2
#macro GUI_BEHAVIOR_MODAL           3
#macro GUI_BEHAVIOR_POP_UP          4
#macro GUI_BEHAVIOR_BLOCK_SIBLINGS  5

#macro GUI_OFF      0
#macro GUI_PRESS    1
#macro GUI_HOLD     2
#macro GUI_RELEASE  3

// Analogues for the above
#macro GUI_ENTER  1
#macro GUI_OVER   2
#macro GUI_LEAVE  3

#macro GUI_NAV_UNKNOWN  0
#macro GUI_NAV_MOUSE    1
#macro GUI_NAV_GAMEPAD  2
#macro GUI_NAV_TOUCH    3

#macro GUI_USER_EVENT_STEP      0
#macro GUI_USER_EVENT_DRAW      1
#macro GUI_USER_EVENT_DRAW_END  2