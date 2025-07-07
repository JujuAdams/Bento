// Feather disable all

/// Sets an element as using a special layout type for resizable wrapping text.
/// 
/// N.B. This particular layout type presumes that you want the element containing to resize its
///      height depending on how text wraps in the width available. You don't need to use this
///      layout type if you don't need this feature and you'll probably want to use the
///      `BentoLayoutSetRect()` instead (which is the default layout type).
/// 
/// Text has some perculiar properties: as the available width for text decreases, text wrapping
/// will mean that the height of the text
/// after wrapping will increase. To handle these sorts of situations, elements that are set up
/// with this function specify two "measure" functions: one for the starting width of text, the
/// other for the resulting height of the text after wrapping.
/// 
/// The `measureWidthFunc` parameter should be a function (typically a method scoped to the target
/// element) that returns the width of the text. The width should be calculated using the settings
/// that you intend to use for final rendering of the text. The `measureWidthFunc` function is
/// executed with one parameter.
/// 
/// The `measureHeightFunc` parameter should be a function that returns the height of the text
/// after wrapping. The `measureWidthFunc` function is executed with one parameter which is the
/// width of the available space for the element. This value may be set to `999999` in
/// 
/// @param measureWidthFunc
/// @param measureHeightFunc
/// @param [element=self]

function BentoLayoutSetText(_funcWidth, _funcHeight, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (__layoutType != BENTO_LAYOUT_TEXT)
        {
            //Swapping into text layout, reset everything
            
            __layoutType = BENTO_LAYOUT_TEXT;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            
            __SolverGetShrinkWidth  = method(self, __BentoSolverTextGetShrinkWidth);
            __SolverResizeWidth     = function(){};
            __SolverGetShrinkHeight = method(self, __BentoSolverTextGetShrinkHeight);
            __SolverResizeHeight    = function(){};
            __SolverPositions       = method(self, __BentoSolverRectPositions);
            __funcMeasureWidth      = method(__attachedElement, _funcWidth);
            __funcMeasureHeight     = method(__attachedElement, _funcHeight);
        }
        else
        {
            //We're already text, check to see if any parameters have changed
            
            if ((method_get_index(_funcWidth ) != method_get_index(__funcMeasureWidth ))
            ||  (method_get_index(_funcHeight) != method_get_index(__funcMeasureHeight)))
            {
                __funcMeasureWidth  = method(__attachedElement, _funcWidth);
                __funcMeasureHeight = method(__attachedElement, _funcHeight);
                
                //Parameters changed, update the layout!
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
    }
}