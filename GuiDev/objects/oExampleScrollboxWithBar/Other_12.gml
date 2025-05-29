/// @desc Draw After

// Feather disable all

if (GuiPrimaryGetHold() && (not (focusable && GuiUsingDirectional())))
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

width   = 10;
padding =  5;

var _bodyL = guiRight - width - padding;
var _bodyT = guiTop + padding;
var _bodyR = guiRight - padding;
var _bodyB = guiBottom - padding;

var _handleH = (_bodyB - _bodyT) * clamp(guiHeight / GuiScrollGetHeight(), 0.1, 1);
var _handleT = lerp(_bodyT, _bodyB - _handleH, GuiScrollGetParamY());
var _handleB = _handleT + _handleH;

draw_rectangle_color(_bodyL, _bodyT, _bodyR, _bodyB, _bgColor, _bgColor, _bgColor, _bgColor, false);
draw_rectangle_color(_bodyL, _handleT, _bodyR, _handleB, _fgColor, _fgColor, _fgColor, _fgColor, false);