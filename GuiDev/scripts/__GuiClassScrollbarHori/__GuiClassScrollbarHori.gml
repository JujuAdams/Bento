// Feather disable all

function __GuiClassScrollbarHori(_element) : __GuiClassScrollbar(_element) constructor
{
    static __SetSize = function()
    {
        var _element = __element;
        
        if (__mirror)
        {
            //Top
            __barLeft   = _element.guiLeft + __padLeft;
            __barTop    = _element.guiTop + __padTop;
            __barRight  = _element.guiRight - __padRight;
            __barBottom = _element.guiTop + (__padTop + __thickness);
        }
        else
        {
            //Bottom
            __barLeft   = _element.guiLeft + __padLeft;
            __barTop    = _element.guiBottom - (__barBottom + __thickness);
            __barRight  = _element.guiRight - __padRight;
            __barBottom = _element.guiBottom - __padBottom;
        }
    }
    
    static __Update = function()
    {
        
    }
}