// Feather disable all

/// This constructor defines a simple textbox element that can be used within a Bento UI layout.
/// 
/// Example:
/// ```
/// new BentoConstrText("Prefilled text", "Enter text here!");
/// ```
/// 
/// @param text
/// @param [emptytText=""]
/// @param [font]
/// @param [hAlign=left]
/// @param [vAlign=top]
/// @param [parent=self]

function BentoConstrText(_text, _emptyText = "", _font = -1, _hAlign = fa_left, _vAlign = fa_top, _parent = other) : BentoConstrAncestor(_parent) constructor
{
    text      = _text;
    emptyText = _emptyText;
    font      = _font;
    hAlign    = _hAlign;
    vAlign    = _vAlign;
    
    var _oldFont = draw_get_font();
    draw_set_font(font);
    BentoLayoutSetSize(string_width(text), undefined);
    BentoLayoutSetMinSize(20, undefined);
    draw_set_font(_oldFont);
    
    //Set up the height rule to use when Bento calculates layouts
    BentoLayoutSetText(function(_maxWidth)
    {
        var _oldFont = draw_get_font();
        draw_set_font(font);
        var _result = string_height_ext(text, -1, _maxWidth);
        draw_set_font(_oldFont);
        
        return _result;
    });
    
    funcDraw = function()
    {
        if (hAlign == fa_left)
        {
            var _x = bentoLeft;
        }
        else if (hAlign = fa_right)
        {
            var _x = bentoRight;
        }
        else
        {
            //Default horizontal alignment to center
            var _x = 0.5*(bentoLeft + bentoRight);
        }
        
        if (vAlign == fa_top)
        {
            var _y = bentoTop;
        }
        else if (vAlign = fa_bottom)
        {
            var _y = bentoBottom;
        }
        else
        {
            //Default horizontal alignment to middle
            var _y = 0.5*(bentoTop + bentoBottom);
        }
        
        draw_set_font(font);
        draw_set_halign(hAlign);
        draw_set_valign(vAlign);
        var _text = (text != "")? text : emptyText;
        draw_text_ext(_x, _y, _text, -1, bentoWidth);
        draw_set_font(-1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
}