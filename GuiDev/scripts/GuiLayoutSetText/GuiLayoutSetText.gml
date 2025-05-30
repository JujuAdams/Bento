// Feather disable all

/// @param measureWidthFunc
/// @param measureHeightFunc
/// @param [element=self]

function GuiLayoutSetText(_funcWidth, _funcHeight, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__layoutType != GUI_LAYOUT_TEXT)
        {
            __layoutType = GUI_LAYOUT_TEXT;
            __layer.__layoutDirty = true;
            
            __SolverShrinkWidth  = method(self, __GuiSolverTextShrinkWidth);
            __SolverResizeWidth  = function(){};
            __SolverShrinkHeight = method(self, __GuiSolverTextShrinkHeight);
            __SolverResizeHeight = function(){};
            __SolverPositions    = method(self, __GuiSolverRectPositions);
            __funcMeasureWidth   = method(__attachedElement, _funcWidth);
            __funcMeasureHeight  = method(__attachedElement, _funcHeight);
        }
    }
}