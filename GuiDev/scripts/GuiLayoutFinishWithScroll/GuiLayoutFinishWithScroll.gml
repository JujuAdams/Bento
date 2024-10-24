// Feather disable all

/// @param layout
/// @param [padLeft=0]
/// @param [padTop=0]
/// @param [padRight=0]
/// @param [padBottom=0]

function GuiLayoutFinishWithScroll(_layout, _padLeft = 0, _padTop = 0, _padRight = 0, _padBottom = 0)
{
    _layout.__FinishWithScroll(_padLeft, _padTop, _padRight, _padBottom);
}