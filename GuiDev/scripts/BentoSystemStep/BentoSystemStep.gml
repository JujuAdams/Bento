// Feather disable all

/// Updates environments, layers, and elements.

// TODO - Add x/y offset to handle views moving around

function BentoSystemStep(_rootWidth, _rootHeight)
{
    static _system = __BentoSystem();
    static _environmentArray = _system.__environmentArray;
    
    with(_system)
    {
        ++__frame;
        
        var _i = 0;
        repeat(array_length(_environmentArray))
        {
            _environmentArray[_i].__Update(_rootWidth, _rootHeight);
            ++_i;
        }
    }
    
}