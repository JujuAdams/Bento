function __BentoSurfaceCheckForOrphans()
{
    static _surfaceArray = __BentoGlobal().__surfaceArray;
    
    var _i = 0;
    repeat(array_length(_surfaceArray))
    {
        var _struct = _surfaceArray[_i];
        var _weakRef = _struct.__weakRef;
        var _surface = _struct.__surface;
        
        if (weak_ref_alive(_weakRef) && surface_exists(_surface))
        {
            ++_i;
        }
        else
        {
            surface_free(_surface);
            array_delete(_surfaceArray, _i, 1);
        }
    }
}