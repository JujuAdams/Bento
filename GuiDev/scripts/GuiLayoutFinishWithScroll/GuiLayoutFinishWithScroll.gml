// Feather disable all

/// @param layout
/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param [padLeft=0]
/// @param [padTop=0]
/// @param [padRight=0]
/// @param [padBottom=0]

function GuiLayoutFinishWithScroll(_layout, _left, _top, _right, _bottom, _padLeft = 0, _padTop = 0, _padRight = 0, _padBottom = 0)
{
    _layout.__FinishWithScroll(_left, _top, _right, _bottom, _padLeft, _padTop, _padRight, _padBottom);
}