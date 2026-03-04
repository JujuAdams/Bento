// Feather disable all

/// Returns a struct that contains data describing the position and state of the horizontal
/// scrollbar.
/// 
/// `.exists`
///     Whether the horizontal scrollbar has been set up for the element.
/// 
/// `.barLeft` `.barTop` `.barRight` `.barBottom`
///     The position of the main body of the scrollbar. These are absolute coordinates.
/// 
/// `.handleLeft` `.handleTop` `.handleRight` `.handleBottom`
///     The position of the handle for the scroller. These are absolute coordinates.
/// 
/// `.hoverScrollbar`
///     Whether the scrollbar is being hovered. This variable will also be set to `true` if the
///     handle is being hovered as well.
/// 
/// `.hoverHandle`
///     Whether the handle on the scrollbar specifically is being hovered.
/// 
/// `.holdHandle`
///     Whether the handle is being held by the user.
/// 
/// @param [element=self]

function BentoScrollbarGetHoriData(_element = self)
{
    static _nullResult = {
        exists: false,
        
        barLeft:   0,
        barTop:    0,
        barRight:  0,
        barBottom: 0,
        
        handleVisible: false,
        handleLeft:    0,
        handleTop:     0,
        handleRight:   0,
        handleBottom:  0,
        
        hoverScrollbar: false,
        hoverHandle:    false,
        holdHandle:     false,
    };
    
    if (BentoExists(_element) && (_element.BENTO_VARS.__scrollbarHori != undefined))
    {
        return _element.BENTO_VARS.__scrollbarHori;
    }
    else
    {
        return _nullResult;
    }
}