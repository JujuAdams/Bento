// Feather disable all

/// If the element doesn't exist, both `.x` and `.y` will be set to `undefined`.
/// 
/// @param [element=self]

function BentoGetPosition(_element = self)
{
    static _result = {
        x: undefined,
        y: undefined,
        innerCoordSpace: true,
    };
    
    if (BentoExists(_element))
    {
        with(_element.BENTO_VARS)
        {
            _result.innerCoordSpace = __positionInnerCoordSpace;
            
            if (__positionOverride)
            {
                _result.x = __positionX;
                _result.y = __positionY;
            }
            else
            {
                _result.x = undefined;
                _result.y = undefined;
            }
        }
    }
    else
    {
        _result.x = undefined;
        _result.y = undefined;
        _result.innerCoordSpace = true;
    }
    
    return _result;
}