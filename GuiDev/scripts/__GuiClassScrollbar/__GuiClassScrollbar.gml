// Feather disable all

/// @param element

function __GuiClassScrollbar(_element) constructor
{
    __element = _element;
    
    __mirror    = false;
    __thickness = 0;
    
    __padLeft   = 0;
    __padTop    = 0;
    __padRight  = 0;
    __padBottom = 0;
    
    __barLeft   = 0;
    __barTop    = 0;
    __barRight  = 0;
    __barBottom = 0;
    __barWidth  = 0;
    __barHeight = 0;
    
    __handleLeft   = 0;
    __handleTop    = 0;
    __handleRight  = 0;
    __handleBottom = 0;
    __handleWidth  = 0;
    __handleHeight = 0;
    
    __overScrollbar = false;
    __overHandle    = false;
    __grabHandle    = false;
    
    __grabDelta = 0;
}