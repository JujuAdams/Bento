// Feather disable all

/// Helper function to set GPU scissor state.
/// 
/// @param left
/// @param top
/// @param width
/// @param height

function __BentoScissorSet(_left, _top, _width, _height)
{
    static _system = __BentoSystem();
    
    //TODO - Optimize
    _left   = _left   * _system.__globalScissorWidthCoeff  + _system.__globalScissorXOffset;
    _top    = _top    * _system.__globalScissorHeightCoeff + _system.__globalScissorYOffset;
    _width  = _width  * _system.__globalScissorWidthCoeff;
    _height = _height * _system.__globalScissorHeightCoeff;
    
    gpu_set_scissor(_left, _top, _width, _height);
}