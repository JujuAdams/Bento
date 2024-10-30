// Feather disable all

// Juju: This is an example of a Gui page. This isn't a formally defined concept in the Gui system
//       but I've found the concept to be useful in other projects. A "page" is a common parent
//       shared by Gui instances that are thematically related. For example, a settings "page" will
//       contain a bunch of child instances that allow the player to change settings. When the page
//       is destroyed then all the child instances should be destroyed too because they're no
//       longer useful to the player. Having Gui instances shared a common parent makes it a lot
//       easier to manage what is being shown, and this is especially the case when using tabs to
//       swap between pages.

// Inherit from the example frame. Going up the inheritance chain, this object eventually
// inherits from `GuiObject` which is the common ancestor for all Gui objects.
event_inherited();

// A "singleton" is anything for which only one can exist at a time. In this case, the
// `GuiNameSingleton()` function ensure that only one instance of a Gui object called `"main menu"`
// can exist at a time. When this function is called, any existing instance called `"main menu"`
// will be destroyed. Gui names can be used in other ways; see the `GuiName*()` namespace.
GuiNameSingleton("main menu");

// Sets up a tab group. The string provided here is called the "tab ident" which is just a string
// that's used to identify a group of tabs. A tab group allows you to create tab buttons that can
// be used to automatically manage swapping between mutually exclusive pages. Tab buttons are set
// up with `GuiTabSetupButton()` or, more conveniently, `GuiLayoutMembersSetupTabButton()`. Child
// Gui instances are created with `GuiTabOpen()`.
GuiTabSetupHost("main menu tabs");

// "Layouts" are simple rulesets that help to position Gui instances. Layouts also set up
// navigation links to make directional navigation smoother to use. This particular layout is a
// vertical list. Layouts all take parameters to control how they appear but all layouts will need
// to know the parent that all instances should be created as children of, and whether instances
// in the layout should be created "inside" or "outside" the parent. Vertical lists also need a
// spacing value (which adds a margin between sequential instances but not around the group of
// instances). Vertical lists can also be given a horizontal and vertical alignment. Alignments
// will control where instances are positioned relative to the coordinate specified when calling
// `GuiLayoutFinish()` for the layout.
var _layout = GuiLayoutStartListV(id, true, 10, fa_left, fa_middle);

// `GuiCreateInLayout()` will create an instance in a layout. However, that instance will not have
// a valid position until `GuiLayoutFinish()` is called. The width and height of this instance can
// be set inside the Create event for the instance or modified elsewhere e.g. by using the 
// `GuiLayoutSetMembersWidth()` function. For accurate results when finishing a layout, you should
// set the final width/height before calling `GuiLayoutFinish()`.
GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Continue Adventure",
    func: function()
    {
        // Create a new page for the save slot menu. We choose to create this instance as a child
        // of the parent of parent of the button that created it. Less confusingly, this means
        // that the newly created instance is a sibling of `oPageMainMenu`. This means we can use
        // the "block siblings" behavior to prevent the main menu from drawing (or being interacted
        // with), effectively causing the save slot menu to "replace" the main menu. However, the
        // main menu isn't actually destroyed.
        var _instance = GuiCreateOutside(oPageContinue, un, GuiGetParent(2), room_width/2, 500);
        
        // Set the newly created save slot page as the child of the tab group. This triggers some
        // automatic behaviour such that when the save slot page is closed, the button that opened
        // the save slot page will automatically be selected. This means that the main menu
        // "remembers" what was previously selected when returning to it from the save slot menu.
        GuiTabOpen(_instance);
        
        // Use the save slot menu to block its sibling, which means it blocks the main menu page.
        GuiSetBehavior(GUI_BEHAVIOR_BLOCK_SIBLINGS, _instance);
        
        // Ensure that the save slot menu is at a higher priority than the main menu page.
        GuiSetPriorityTop(_instance);
    },
});

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Start Adventure",
    func: function()
    {
        // Destroy the main menu
        GuiNameDestroy("main menu");
        
        // Automatically create the pause menu page. In a real game this'd be triggered by e.g.
        // pressing escape or disconnecting a gamepad.
        GuiCreateOutside(oPagePauseMenu, un, GUI_ROOT);
    },
});

GuiCreateInLayout(_layout, GuiExampleButton,
{
    text: "Options",
    func: function()
    {
        var _instance = GuiCreateOutside(oPageOptions, un, GuiGetParent(2), room_width/2, 500);
        GuiTabOpen(_instance);
        GuiSetBehavior(GUI_BEHAVIOR_BLOCK_SIBLINGS, _instance);
        GuiSetPriorityTop(_instance);
    },
});

// This finishes the layout and triggers the instance positioning algorithm that is relevant for
// the layout in question. The instances will be positioned relative to the coordinates provided
// and respecting the horizontal/vertical layout declared when starting the layout.
// `GuiLayoutFinish()` can be called nultiple times to reposition instances e.g. after reordering
// them, or adding/removing instances.
GuiLayoutFinish(_layout, x - GuiLayoutGetWidth(_layout)/2, y);

// Calls `GuiTabSetupButton()` for each instance in a layout. This is a convenient way to set up
// a tab group. In this situation, we're setting up a tab group that encompasses each of the
// buttons on the main menu. See above in the callback methods for the buttons for an explanation
// about why this is helpful.
GuiLayoutMembersSetupTabButton(_layout, "main menu tabs");

// When using directional input it is very helpful to ensure a particular menu option is selected
// by default. This function will tell the cursor to select the topmost instance in the layout.
GuiLayoutNavSelectFirst(_layout);

// This function sets the size of an instance such that it encompasses all of its children (plus
// padding if necessary). This function doesn't move any of the child instances at all. If you'd
// like to move specifically the children of an instance then you should call `GuiMoveChildren()`.
// If you'd like to move an instance and its children at the same time, use `GuiMove()` or
// `GuiSetPosition()`.
GuiSetSizeAroundChildren(10);