// Feather disable all

/// Returns a struct that contains three variables (`.x`, `.y`, `.auto`) that hold the origin data
/// for the element. If the element doesn't exist, both `.x` and `.y` will be set to 0 amd `.auto`
/// will be set to `false`.
/// 
/// @param [element=self]

function BentoGetOrigin(_element = self)
{
    static _result = {
        x:    0,
        y:    0,
        auto: false,
    };
    
    if (BentoExists(_element))
    {
        with(_element)
        {
            _result.x    = (bentoX - bentoLeft) / bentoWidth;
            _result.y    = (bentoY - bentoTop)  / bentoHeight;
            _result.auto = BENTO_VARS.__originAuto;
        }
    }
    else
    {
        _result.x    = BENTO_DEFAULT_ORIGIN_X;
        _result.y    = BENTO_DEFAULT_ORIGIN_Y;
        _result.auto = false;
    }
    
    return _result;
}