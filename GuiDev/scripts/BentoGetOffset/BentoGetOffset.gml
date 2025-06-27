// Feather disable all

/// @param [element=self]

function BentoGetOffset(_element = self)
{
    static _result = {
        x: 0,
        y: 0,
    };
    
    if (BentoExists(_element))
    {
        with(_element.BENTO_VARS)
        {
            _result.x = __offsetX;
            _result.y = __offsetY;
        }
    }
    else
    {
        _result.x = 0;
        _result.y = 0;
    }
    
    return _result;
}