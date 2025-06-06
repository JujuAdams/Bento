// Feather disable all

/// @param [element=self]

function GuiScrollbarGetVertData(_element = self)
{
    static _nullResult = {
        barLeft:   0,
        barTop:    0,
        barRight:  0,
        barBottom: 0,
        
        handleLeft:   0,
        handleTop:    0,
        handleRight:  0,
        handleBottom: 0,
        
        hoverScrollbar: false,
        hoverHandle:    false,
        grabHandle:     false,
    };
    
    if (GuiExists(_element) && (_element.GUI_VARS.__scrollbarVert != undefined))
    {
        return _element.GUI_VARS.__scrollbarVert;
    }
    else
    {
        return _nullResult;
    }
}