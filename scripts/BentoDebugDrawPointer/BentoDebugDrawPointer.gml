// Feather disable all

/// @param [xOffset=0]
/// @param [yOffset=0]

function BentoDebugDrawPointer(_xOffset = 0, _yOffset = 0)
{
    static _system = __BentoSystem();
    static _matrix = matrix_build_identity();
    
    with(_system)
    {
        var _useMatrix = ((_xOffset != 0) || (_yOffset != 0) || (__globalScale != 1));
        if (_useMatrix)
        {
            _matrix[@  0] = __globalScale;
            _matrix[@  5] = __globalScale;
            _matrix[@ 12] = _xOffset;
            _matrix[@ 13] = _yOffset;
            
            matrix_stack_push(_matrix);
            matrix_set(matrix_world, matrix_stack_top());
        }
        
        var _environmentArray = __environmentArray;
        var _i = 0;
        repeat(array_length(_environmentArray))
        {
            with(_environmentArray[_i])
            {
                BentoDrawCross(__envMouseX, __envMouseY);
            }
            
            ++_i;
        }
        
        if (_useMatrix)
        {
            matrix_stack_pop();
            matrix_set(matrix_world, matrix_stack_top());
        }
    }
}