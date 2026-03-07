// Feather disable all

/// Draws all environments, layers, and elements. You may optionally provide an offset which will
/// visually move where Bento draws elements.
/// 
/// @param [x=0]
/// @param [y=0]

function BentoSystemDraw(_x = 0, _y = 0)
{
    static _system = __BentoSystem();
    
    var _matrixCustom = matrix_build_identity();
    var _matrixWorld  = matrix_build_identity();
    var _matrixView   = matrix_build_identity();
    var _matrixProj   = matrix_build_identity();
    var _matrixWVP    = matrix_build_identity();
    
    with(_system)
    {
        matrix_get(matrix_view, _matrixView);
        matrix_get(matrix_projection, _matrixProj);
        _matrixProj[@ 5] *= -1;
        
        var _useMatrix = ((_x != 0) || (_y != 0) || (__globalScale != 1));
        if (_useMatrix)
        {
            _matrixCustom[@  0] = __globalScale;
            _matrixCustom[@  5] = __globalScale;
            _matrixCustom[@ 12] = _x;
            _matrixCustom[@ 13] = _y;
            
            matrix_stack_push(_matrixCustom);
            matrix_set(matrix_world, matrix_stack_top());
            
            matrix_multiply(_matrixCustom, _matrixView, _matrixWVP);
        }
        else
        {
            matrix_get(matrix_world, _matrixWorld);
            matrix_multiply(_matrixWorld, _matrixView, _matrixWVP);
        }
        
        matrix_multiply(_matrixWVP, _matrixProj, _matrixWVP);
        
        __globalScissorXOffset     = round((0.5 + 0.5*_matrixWVP[12])*window_get_width());
        __globalScissorYOffset     = round((0.5 + 0.5*_matrixWVP[13])*window_get_height());
        __globalScissorWidthCoeff  = 0.5*_matrixWVP[0]*window_get_width();
        __globalScissorHeightCoeff = 0.5*_matrixWVP[5]*window_get_height();
        
        __BentoScissorReset();
        
        var _environmentArray = __environmentArray;
        var _i = 0;
        repeat(array_length(_environmentArray))
        {
            _environmentArray[_i].__Draw();
            ++_i;
        }
        
        if (_useMatrix)
        {
            matrix_stack_pop();
            matrix_set(matrix_world, matrix_stack_top());
        }
    }
}