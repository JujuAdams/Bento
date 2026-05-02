// Feather disable all

/// This constructor is the common ancestor for all struct-based Bento elements. All structs that
/// you intend to work with Bento **must** be instantiated with a constructor that inherits from
/// `BentoConstrAncestor`. If you'd like to use Bento with objects, please see `BentoCreate()`.
/// 
/// When you inherit from `BentoConstrAncestor` you will usually want to be able to specify the
/// parent. This means your constructor should look something like this:
/// 
/// function CustomElement(_parent = other) : BentoConstrAncestor(_parent) constructor
/// {
///     ...
/// }
/// 
/// It's odd but we do need use `other` as the default value for the parent due to the way
/// GameMaker resolves scope when executing constructors. For an example of inheritance, please see
/// `BentoConstrSprite()` or `BentoConstrText()`.
/// 
/// Any custom constructor you make that inherits from `BentoConstrAncestor()` can, and probably
/// should, override the callback `event*` methods that exist by default. Additionally, there are a
/// handful of read-only variables that you can use to get where Bento has positioned the struct.
/// Please continue reading comments in this script/function for more information.
/// 
/// @param [parent=self]

function BentoConstrAncestor(_parent = other) constructor
{
    eventStep = function()
    {
        // This method is executed downstream of `BentoSystemStep()`. To improve performance, only elements
        // that need to execute this method will do so. An element will execute this method in the
        // following circumstances:
        // 
        // - The element's button type matches the input mode (see `BentoSetButton()` and `BentoSetMode()`).
        // - Forced step execution has been enabled for the element by `BentoSetPushStep()`
        // - The element has been focused by `BentoFocusOpen()`
        // - The element has a clipping region set up by `BentoClipSetEnabled()`
        // - `BENTO_ALWAYS_EXECUTE_STEP` is set to `true`
    }
    
    eventDraw = function()
    {
        // This event is executed downstream of `BentoSystemDraw()`. This event will not be executed if it
        // has been set to not visible by calling `BentoSetVisible(false)`.
    }
    
    eventDrawAfter = function()
    {
        // This event is disabled by default. Call `BentoSetDrawAfter()` to enable it.
    }
    
    eventDrawHover = function()
    {
        // This event is called downstream of `BentoSystemDraw()` when an element is hovered. This event
        // will not be executed if it has been set to not visible by calling `BentoSetVisible(false)`.
    }
    
    eventDrawDragged = function()
    {
        // This event is called downstream of `BentoSystemDraw()` when an element is being dragged as an
        // item in the drag & drop system. This event will not be executed if it has been set to not
        // visible by calling `BentoSetVisible(false)`.
    }
    
    eventReposition = function()
    {
        // This event is called whenever the library decides that the element needs to be moved. This is
        // typically when the element is created, the layout changes, or when the player has scrolled an
        // element.
    }
    
    // We include `image_alpha` on all Bento structs for parity with objects. You may change this value as
    // you sse fit. This value can be changed by Bento if you call one of the animation functions e.g.
    // `BentoAnimPlayBuildIn()`.
    image_alpha = 1;
    
    // These **read-only** variables give the position of various parts of this element in worldspace. You
    // can use these variables in the draw methods (`funcDraw` and `funcDrawAfter`).
    bentoLeft   = 0;
    bentoTop    = 0;
    bentoRight  = 0;
    bentoBottom = 0;
    bentoX      = 0;
    bentoY      = 0;
    bentoWidth  = 0;
    bentoHeight = 0;
    
    // This stuff you can ignore, it's machinery to hook the struct into Bento
    
    BENTO_VARS = new __BentoClassVariables(self);
    
    if (_parent != __BENTO_NO_PARENT)
    {
        BentoSetParent(_parent);
    }
}