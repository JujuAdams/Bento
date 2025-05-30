/// @desc Draw

// Feather disable all

event_inherited();

if (GuiPrimaryGetHold() && (not GuiUsingDirectional()))
{
    var _fgColor = c_gray;
    var _bgColor = c_white;
}
else if (GuiCursorGetOver())
{
    var _fgColor = c_white;
    var _bgColor = c_dkgray;
}
else
{
    var _fgColor = c_white;
    var _bgColor = c_gray;
}

if (GuiUsingDirectional())
{
    draw_set_color(_fgColor);
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
    draw_set_color(c_white);
}
else
{
    draw_set_color(_fgColor);
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
    draw_set_color(c_white);
}

//if (showScrollbar)
//{
//    var _bodyX = _right - padding;
//    var _bodyT = y + 1 + padding;
//    var _bodyB = _bottom - 1 - padding;
//    
//    LatDrawSprite(sFontFull, 24, _bodyX, _bodyT-1, _fgColor, _bgColor);
//    LatDrawSprite(sFontFull, 25, _bodyX, _bodyB+1, _fgColor, _bgColor);
//    
//    var _handlePos = round(lerp(_bodyT, _bodyB, GuiScrollGetParamY()));
//    
//    LatDrawRectExt(_bodyX, _bodyT, _bodyX, _handlePos-1, sFontFull, 177, _fgColor, _bgColor);
//    LatDrawRect(_bodyX, _handlePos, _bodyX, _handlePos, C_MALIBU);
//    LatDrawRectExt(_bodyX, _handlePos+1, _bodyX, _bodyB, sFontFull, 177, _fgColor, _bgColor);
//}