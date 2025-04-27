// Feather disable all

// Juju: Example of a pop-up menu frame. This is used for context menus or small menus that don't
//       need a "full treatment". Any instance can be set up as a pop-up menu by setting the
//       behavior for that instance to `GUI_BEHAVIOR_POP_UP` (see below).
//       
//       The `GUI_BEHAVIOR_POP_UP` behavior creates a lot of default interfaction rules. In the
//       `GUI_NAV_MOUSE` or `GUI_NAV_TOUCH` navigation modes, pop-up menus are automatically
//       dismissed when clicking off of the pop-up menu or any of its descendents. You will need
//       to manually destroy a pop-up menu if a child button is clicked. In the `GUI_NAV_GAMPEAD`
//       navigation mode, you will need to manually set up a way for your players to dismiss a
//       pop-up menu.
//       
//       This example object implements destroying a pop-up menu by pressing the `"escape"` button
//       (which is bound to `vk_escape`). Child buttons will call `GuiDestroy()` on the pop-up menu
//       parent in their button callback method.

event_inherited();

GuiSetBehavior(GUI_BEHAVIOR_POP_UP);

GuiLayoutSetClampInside(true);
GuiLayoutSetResizeType(GUI_RESIZE_FIT, GUI_RESIZE_FIT);
GuiLayoutSetPadding(10, 10, 10, 10);
GuiLayoutSetGutter(10, 10);
GuiLayoutSetListAxis(GUI_AXIS_Y);
GuiLayoutSetListAlign(fa_center, fa_top);
GuiLayoutSetAlignSelf(fa_left, fa_top);
GuiLayoutSetMinSize(32, 32);