// Feather disable all

/// Sets an element as using a special layout type for resizable wrapping text.
/// 
/// N.B. This particular layout type presumes that you want the element to change its height
///      depending on how text wraps in the width available. You don't need to use this layout type
///      if you don't need to adjust the height of an element and you'll probably want to use
///      `BentoLayoutRect()` instead (which is the default layout type).
/// 
/// Text has some perculiar properties: as the available width for text decreases, text wrapping
/// will mean that the height of the text after wrapping will increase. Because the width of an
/// element may be dependent on its parent container, we can't know the width of an element when
/// it is created. This means we need to calculate the height of the element in the middle of the
/// text layout algorithm and such calculations are done by what is called a "measure function".
/// 
/// The `measureHeightFunc` parameter must be a function (typically a method scoped to the target
/// element) that returns the height of the text after wrapping. The function is executed with one
/// parameter which is the calculated width of the element. The height should be calculated using
/// the settings that you intend to use for final rendering of the text.
/// 
/// An example follows. This measure function assumes that the target element has two instance
/// variables, `text` and `font`, which determine what text is going to be drawn and what font that
/// text will be drawn in.
/// 
/// ```
/// BentoLayoutText(function(_maxWidth, _maxHeight)
/// {
///     var _oldFont = draw_get_font();
///     draw_set_font(font);
///     var _height = string_height_ext(text, -1, _width);
///     draw_set_font(_oldFont);
///     
///     return _height;
/// });
/// ```
/// 
/// @param measureHeightFunc
/// @param [element=self]

function BentoLayoutText(_funcHeight, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__layoutType != BENTO_LAYOUT_TEXT)
        {
            //Swapping into text layout, reset everything
            
            __layoutType = BENTO_LAYOUT_TEXT;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            
            __SolverGetDeflateWidth  = method(self, __BentoSolverTextGetDeflateWidth);
            __SolverResizeWidth      = function() {};
            __SolverGetDeflateHeight = method(self, __BentoSolverTextGetDeflateHeight);
            __SolverResizeHeight     = method(self, __BentoSolverMaintainAspectRatio);
            __SolverFinalPositions   = method(self, __BentoSolverRectPositions);
            __funcMeasureHeight      = method(__attachedElement, _funcHeight);
        }
        else
        {
            //We're already text, check to see if any parameters have changed
            
            if (method_get_index(_funcHeight) != method_get_index(__funcMeasureHeight))
            {
                __funcMeasureHeight = method(__attachedElement, _funcHeight);
                
                //Parameters changed, update the layout!
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
    }
}