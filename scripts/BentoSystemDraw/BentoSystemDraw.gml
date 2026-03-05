// Feather disable all

/// Draws all environments, layers, and elements. You may optionally provide an offset which will
/// visually move where Bento draws elements.
/// 
/// @param [x=0]
/// @param [y=0]

function BentoSystemDraw(_x = 0, _y = 0)
{
    static _system = __BentoSystem();
    static _matrix = matrix_build_identity();
    
    static _matrixView = matrix_build_identity();
    static _matrixProj = matrix_build_identity();
    
    matrix_get(matrix_view, _matrixView);
    matrix_get(matrix_projection, _matrixProj);
    
    if (BENTO_ON_DIRECTX)
    {
        _matrixProj[@ 5] *= -1;
    }
    
    with(_system)
    {
        __globalScissorXOffset     = round((0.5 + 0.5*_matrixView[12]*_matrixProj[0])*window_get_width());
        __globalScissorYOffset     = round((0.5 + 0.5*_matrixView[13]*_matrixProj[5])*window_get_height());
        __globalScissorWidthCoeff  = _matrixView[0];
        __globalScissorHeightCoeff = _matrixView[5];
        
        __BentoScissorReset();
        
        var _useMatrix = ((_x != 0) || (_y != 0));
        if (_useMatrix)
        {
            _matrix[@ 12] = _x;
            _matrix[@ 13] = _y;
            
            matrix_stack_push(_matrix);
            matrix_set(matrix_world, matrix_stack_top());
        }
        
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