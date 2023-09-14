/// @param surface

function __BentoSurfaceFree(_surface)
{
    static _surfaceArray = __BentoGlobal().__surfaceArray;
    
    surface_free(_surface);
    
    var _i = 0;
    repeat(array_length(_surfaceArray))
    {
        var _struct = _surfaceArray[_i];
        if (_struct.__surface == _surface)
        {
            array_delete(_surfaceArray, _i, 1);
        }
        else
        {
            ++_i;
        }
    }
}