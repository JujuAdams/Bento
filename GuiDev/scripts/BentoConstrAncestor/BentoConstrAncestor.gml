// Feather disable all

/// @param parent

function BentoConstrAncestor(_parent) constructor
{
    funcStep = function()
    {
        // This method is executed downstream of `BentoSystemStep()`. To improve performance, only elements
        // that need to execute this method will do so. An element will execute this method in the
        // following circumstances:
        // 
        // - The element's button type (see `BentoSetButton()`) matches the input mode (see
        //   `BentoSetMode()`).
        // - Forced step executed has been enabled for the element by `BentoSetForceStep()`
        // - The element has been focused by `BentoFocusOpen()`
        // - The element has a clipping region set up by `BentoClipSetEnabled()`
        // - `BENTO_ALWAYS_EXECUTE_STEP` is set to `true`
    }
    
    funcDraw = function()
    {
        // This event is executed downstream of `BentoSystemDraw()`.
    }
    
    funcDrawAfter = function()
    {
        // This user event is disabled by default. Call `BentoSetDrawAfter()` to enable it.
    }
    
    funcReposition = function()
    {
        // This event is called whenever the library decides that the element needs to be moved. This is
        // typically when the element is created, the layout changes, or when the player has scrolled a
        // element.
    }
    
    ///////////////////////////
    //                       //
    //  Read-Only Variables  //
    //                       //
    ///////////////////////////
    
    //These variables give the position of various parts of this element in worldspace. They're
    //read-only in the sense that they are liable to get overwritten by the library at unexpected
    //times.
    
    bentoLeft   = 0;
    bentoTop    = 0;
    bentoRight  = 0;
    bentoBottom = 0;
    bentoX      = 0;
    bentoY      = 0;
    bentoWidth  = 0;
    bentoHeight = 0;
    
    BENTO_VARS = new __BentoClassVariables(self);
    BentoSetParent(_parent);
}