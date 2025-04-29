// Feather disable all

function __GuiMatrixPop()
{
    static _matrixStack = __GuiSystem().__matrixStack;
    
    matrix_set(matrix_world, array_pop(_matrixStack));
}