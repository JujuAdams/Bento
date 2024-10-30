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

// Set up the pop-up menu behavior for this instance. See above for details.
GuiSetBehavior(GUI_BEHAVIOR_POP_UP);

// Fill out the menu with button based on data based in via `buttonsArray`.
var _layout = GuiLayoutStartListV(id, true, 0, fa_center, fa_top);

var _i = 0;
repeat(array_length(buttonsArray))
{
    var _buttonData = buttonsArray[_i];
    GuiCreateInLayout(_layout, GuiExampleButton,
    {
        text: _buttonData.text,
        func: _buttonData.func,
    });
    
    ++_i;
}

// Set up the layout, stretch out the buttons to make them prettier, and resize the pop-up menu so
// that it visually encompasses the child buttons.
GuiLayoutFinish(_layout, x, y);
GuiLayoutSetMembersWidth(_layout, GuiLayoutGetMembersMaxWidth(_layout));
GuiSetSizeAroundChildren(10);