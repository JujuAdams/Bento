// Feather disable all

/// @param matrix

function __GuiMatrixPush(_matrix)
{
    static _matrixStack = __GuiSystem().__matrixStack;
    
    var _newMatrix = matrix_multiply(array_last(_matrixStack), _matrix);
    array_push(_matrixStack, _newMatrix);
    matrix_set(matrix_world, _newMatrix);
}