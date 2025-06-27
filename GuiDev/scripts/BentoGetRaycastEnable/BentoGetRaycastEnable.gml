// Feather disable all

/// @param [element=self]

function BentoGetRaycastEnable(_disableHori, _disableVert, _element = self)
{
    static _result = {};
    
    if (not BentoExists(_element))
    {
        _result.hori = _element.GUI_VARS.__raycastEnableHori;
        _result.vert = _element.GUI_VARS.__raycastEnableVert;
    }
    else
    {
        _result.hori = false;
        _result.vert = false;
    }
    
    return _result;
}