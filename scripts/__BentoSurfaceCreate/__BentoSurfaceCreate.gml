/// @param struct
/// @param width
/// @param height

function __BentoSurfaceCreate(_struct, _width, _height)
{
    static _surfaceArray = __BentoGlobal().__surfaceArray;
    
    var _surface = surface_create(_width, _height);
    
    array_push(_surfaceArray, {
        __weakRef: weak_ref_create(_struct),
        __surface: _surface,
    });
    
    return _surface;
}