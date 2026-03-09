// Feather disable all

/// Updates environments, layers, and elements. You must specify a root width and height which
/// controls the total space available to position elements.
/// 
/// @param rootWidth
/// @param roomHeight
/// @param [timeStep=1]

function BentoSystemStep(_rootWidth, _rootHeight, _timeStep = 1)
{
    static _system = __BentoSystem();
    static _environmentArray = _system.__environmentArray;
    
    with(_system)
    {
        ++__frame;
        
        _rootWidth  /= __globalScale;
        _rootHeight /= __globalScale;
        
        var _i = 0;
        repeat(array_length(_environmentArray))
        {
            _environmentArray[_i].__Update(_rootWidth, _rootHeight, _timeStep);
            ++_i;
        }
    }
    
}