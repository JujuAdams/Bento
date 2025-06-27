// Feather disable all

/// @param [element=self]

function BentoScrollGetEnabled(_element = self)
{
    static _result = {
        horizontal: false,
        vertical:   false,
    };
    
    if (BentoExists(_element))
    {
        _result.horizontal = _element.BENTO_VARS.__scrollHori;
        _result.vertical   = _element.BENTO_VARS.__scrollVert;
    }
    else
    {
        _result.horizontal = false;
        _result.vertical   = false;
    }
    
    return _result;
}