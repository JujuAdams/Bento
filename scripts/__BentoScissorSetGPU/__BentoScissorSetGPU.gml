// Feather disable all

/// Helper function to set GPU scissor state.
/// 
/// @param left
/// @param top
/// @param width
/// @param height

function __BentoScissorSetGPU(_left, _top, _width, _height)
{
    static _system = __BentoSystem();
    
    //TODO - Optimize
    _left   = _left   * _system.__globalScissorXScale + _system.__globalScissorXOffset;
    _top    = _top    * _system.__globalScissorYScale + _system.__globalScissorYOffset;
    _width  = _width  * _system.__globalScissorXScale;
    _height = _height * _system.__globalScissorYScale;
    
    gpu_set_scissor(_left, _top, _width, _height);
}