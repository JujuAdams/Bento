// Feather disable all

/// @param reference
/// @param stringArray
/// @param [title]
/// @param [font]
/// @param [func]
/// @param [parent=self]

function BentoExConstrStepperStrings(_reference, _stringArray = [], _text = "", _font = fntBentoExCandyBeans, _func = undefined, _parent = other) : BentoConstrAncestor(_parent) constructor
{
    reference   = _reference;
    stringArray = _stringArray;
    text        = _text;
    font        = _font;
    func        = _func ?? function() {};
    
    var _oldFont = draw_get_font();
    draw_set_font(font);
    
    var _width  = string_width(text);
    var _height = string_height(text);
    
    var _optionWidth  = 0;
    var _optionHeight = 0;
    
    var _i = 0;
    repeat(array_length(stringArray))
    {
        _optionWidth  = max(_optionWidth,  string_width(stringArray[_i]) + 40);
        _optionHeight = max(_optionHeight, string_height(stringArray[0]));
        ++_i;
    }
    
    BentoLayoutSetSize(max(_width, _optionWidth) + 70, _height + _optionHeight + 20);
    
    draw_set_font(_oldFont);
    
    BentoSetButton(BENTO_BUTTON_ALWAYS);
    
    // We disable horizontal navigation so that players can scroll through strings without jumping
    // to another element
    BentoSetNavigationEnable(false, true);
    
    
    
    
    
    eventStep = function()
    {
        var _funcGetOptionIndex = function()
        {
            var _option = BentoRefGet(reference, undefined);
            var _optionIndex = array_get_index(stringArray, _option);
            return max(_optionIndex, 0);
        }
        
        var _length = array_length(stringArray);
        if (_length > 0)
        {
            if (BentoUsingPointer())
            {
                // Detect clicks to scroll through the option array.
                if (BentoPrimaryGetClick())
                {
                    var _delta = sign(BentoCursorGetX() - 0.5*(bentoLeft + bentoRight));
                    if (_delta == 0) _delta = 1;
                    
                    var _optionIndex = (_funcGetOptionIndex() + _delta + _length) mod _length;
                    
                    var _option = stringArray[_optionIndex];
                    BentoRefSet(reference, _option);
                    func(_option); //Execute the callback
                }
            }
            else if (BentoUsingNavigation())
            {
                // Detect navigation input to scroll throught the option array.
                if (BentoCursorGetHover() && (BentoCursorGetDX() != 0))
                {
                    var _optionIndex = (_funcGetOptionIndex() + sign(BentoCursorGetDX()) + _length) mod _length;
                    
                    var _option = stringArray[_optionIndex];
                    BentoRefSet(reference, _option);
                    func(_option); //Execute the callback
                }
            }
        }
    }
    
    eventDraw = function()
    {
        BentoDrawSprite(sBentoExButton, undefined, c_black, BENTO_EXAMPLE_SHADOW_ALPHA, BENTO_EXAMPLE_SHADOW_OFFSET, BENTO_EXAMPLE_SHADOW_OFFSET);
        
        var _offset = (BentoPrimaryGetHold() && BentoGetClickable())? 2 : 0;
        var _left   = bentoLeft + _offset;
        var _top    = bentoTop + _offset;
        var _right  = bentoRight + _offset;
        var _bottom = bentoBottom + _offset;
        var _x      = 0.5*(_left + _right) + _offset;
        var _y      = 0.5*(_top + _bottom) + _offset;
        
        BentoDrawSprite(sBentoExButton, undefined, BENTO_EXAMPLE_DARK_BLUE, undefined, _offset, _offset);
        BentoDrawSprite(sBentoExFrame, undefined, BENTO_EXAMPLE_YELLOW, undefined, _offset, _offset);
        
        draw_set_font(font);
        draw_set_color(BENTO_EXAMPLE_YELLOW);
        
        if (text != "")
        {
            draw_set_halign(fa_center);
            draw_text(_x, _top + 10 + _offset, text);
            draw_set_halign(fa_left);
        }
        
        if (array_length(stringArray) > 0)
        {
            draw_set_halign(fa_center);
            draw_set_valign(fa_bottom);
            draw_text(_x, _bottom - 10 + _offset, BentoRefIsAlive(reference)? string(BentoRefGet(reference, "")) : stringArray[0]);
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
        }
        
        draw_triangle(_left+10, _y, _left+25, _y-10, _left+25, _y+10, false); 
        draw_triangle(_right-10, _y, _right-25, _y-10, _right-25, _y+10, false); 
        
        draw_set_font(-1);
        draw_set_color(c_white);
    }
    
    eventDrawHover = function()
    {
        if (BentoGetClickable())
        {
            BentoDrawSpriteAround(10, sBentoExHighlight, undefined, c_black, BENTO_EXAMPLE_HIGHLIGHT_SHADOW_ALPHA, undefined, BENTO_EXAMPLE_HIGHLIGHT_SHADOW_OFFSET, BENTO_EXAMPLE_HIGHLIGHT_SHADOW_OFFSET);
            BentoDrawSpriteAround(10, sBentoExHighlight, undefined, BENTO_EXAMPLE_RED);
        }
    }
}