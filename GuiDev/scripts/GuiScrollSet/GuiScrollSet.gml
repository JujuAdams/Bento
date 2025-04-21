// Feather disable all

/// Sets the scroll offset.
/// 
/// @param scrollX
/// @param scrollY
/// @param [instance=id]

function GuiScrollSet(_scrollX, _scrollY, _instance = id)
{
    with(_instance)
    {
        if (not __scrollHori) _scrollX = 0;
        if (not __scrollVert) _scrollY = 0;
        
        if ((_scrollX == __scrollX) && (_scrollY == __scrollY)) return;
        
        __scrollX = clamp(_scrollX, __scrollMinX, __scrollMaxX);
        __scrollY = clamp(_scrollY, __scrollMinY, __scrollMaxY);
        
        __GuiMarkAnimAndScrollDirty(id)
    }
}