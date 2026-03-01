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
    
    with(_system)
    {
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