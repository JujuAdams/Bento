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
    
    __grabDelta = 0;
    
    barLeft   = 0;
    barTop    = 0;
    barRight  = 0;
    barBottom = 0;
    barWidth  = 0;
    barHeight = 0;
    
    handleLeft   = 0;
    handleTop    = 0;
    handleRight  = 0;
    handleBottom = 0;
    handleWidth  = 0;
    handleHeight = 0;
    
    overScrollbar = false;
    overHandle    = false;
    grabHandle    = false;
}