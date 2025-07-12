// Feather disable all

/// Draws all environments, layers, and elements.

function BentoSystemDraw()
{
    static _system = __BentoSystem();
    static _matrix = matrix_build_identity();
    
    with(_system)
    {
        __BentoScissorReset();
        
        var _useMatrix = ((__globalX != 0) || (__globalY != 0));
        if (_useMatrix)
        {
            _matrix[@ 12] = __globalX;
            _matrix[@ 13] = __globalY;
            
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