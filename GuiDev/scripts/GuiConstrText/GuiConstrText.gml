// Feather disable all

/// @param text
/// @param [font]
/// @param [hAlign=left]
/// @param [vAlign=top]
/// @param [parent=self]

function GuiConstrText(_text, _font = -1, _hAlign = fa_left, _vAlign = fa_top, _parent = other) : GuiConstrAncestor(_parent) constructor
{
    text   = _text;
    font   = _font;
    hAlign = _hAlign;
    vAlign = _vAlign;
    
    funcDraw = function()
    {
        if (hAlign == fa_left)
        {
            var _x = guiX;
        }
        else if (hAlign = fa_right)
        {
            var _x = guiX + guiWidth;
        }
        else
        {
            //Default horizontal alignment to center
            var _x = guiX + 0.5*guiWidth;
        }
        
        if (vAlign == fa_top)
        {
            var _y = guiY;
        }
        else if (vAlign = fa_bottom)
        {
            var _y = guiY + guiHeight;
        }
        else
        {
            //Default horizontal alignment to middle
            var _y = guiY + 0.5*guiHeight;
        }
        
        draw_set_font(font);
        draw_set_halign(hAlign);
        draw_set_valign(vAlign);
        draw_text_ext(_x, _y, text, -1, guiWidth);
        draw_set_font(-1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
    
    with(GUI_VARS)
    {
        __SolverShrinkWidth  = method(self, __GuiSolverTextShrinkWidth);
        __SolverShrinkHeight = method(self, __GuiSolverTextShrinkHeight);
    }
}