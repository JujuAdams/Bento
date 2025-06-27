// Feather disable all

/// @param [element=self]

function BentoScrollbarGetHoriData(_element = self)
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
        grabHandle:    false,
    };
    
    if (BentoExists(_element) && (_element.GUI_VARS.__scrollbarHori != undefined))
    {
        return _element.GUI_VARS.__scrollbarHori;
    }
    else
    {
        return _nullResult;
    }
}