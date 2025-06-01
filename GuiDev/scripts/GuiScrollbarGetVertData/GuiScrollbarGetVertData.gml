// Feather disable all

/// @param [element=self]

function GuiScrollbarGetVertData(_element = self)
{
    static _result = {};
    
    if ((not GuiExists(_element)) || (_element.GUI_VARS.__scrollbarVert == undefined))
    {
        with(_result)
        {
            barLeft   = 0;
            barTop    = 0;
            barRight  = 0;
            barBottom = 0;
            
            handleLeft   = 0;
            handleTop    = 0;
            handleRight  = 0;
            handleBottom = 0;
            
            overScrollbar = false;
            overHandle    = false;
            grabHandle    = false;
        }
    }
    else
    {
        with(_element.GUI_VARS.__scrollbarVert)
        {
            //TODO - Do we need this buffering?
            _result.barLeft   = __barLeft;
            _result.barTop    = __barTop;
            _result.barRight  = __barRight;
            _result.barBottom = __barBottom;
            
            _result.handleLeft   = __handleLeft;
            _result.handleTop    = __handleTop;
            _result.handleRight  = __handleRight;
            _result.handleBottom = __handleBottom;
            
            _result.overScrollbar = __overScrollbar;
            _result.overHandle    = __overHandle;
            _result.grabHandle    = __grabHandle;
        }
    }
    
    return _result;
}