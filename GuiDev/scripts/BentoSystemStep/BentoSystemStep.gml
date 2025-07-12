// Feather disable all

/// Updates environments, layers, and elements.
/// 
/// @param x
/// @param y
/// @param rootWidth
/// @param roomHeight

function BentoSystemStep(_x, _y, _rootWidth, _rootHeight)
{
    static _system = __BentoSystem();
    static _environmentArray = _system.__environmentArray;
    
    with(_system)
    {
        ++__frame;
        
        __globalX = _x;
        __globalY = _y;
        
        var _i = 0;
        repeat(array_length(_environmentArray))
        {
            _environmentArray[_i].__Update(_rootWidth, _rootHeight);
            ++_i;
        }
    }
    
}