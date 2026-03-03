// Feather disable all

/// @param reference
/// @param [text]
/// @param [font]
/// @param [func]
/// @param [parent=self]

function BentoExConstrCheckbox(_reference, _text = "", _font = fntBentoExCandyBeans, _func = undefined, _parent = other) : BentoConstrAncestor(_parent) constructor
{
    reference   = _reference;
    text        = _text;
    font        = _font;
    func        = _func ?? function() {};
    
    //Ensure the click function is scoped to this instance
    func = method(self, func);
    
    BentoSetButton(BENTO_BUTTON_ALWAYS);
    
    if (text != "")
    {
        var _oldFont = draw_get_font();
        draw_set_font(font);
        
        var _height = max(50, string_height(text));
        BentoLayoutSetSize(string_width(text) + _height + 7, _height);
        
        draw_set_font(_oldFont);
    }
    
    
    
    
    
    eventStep = function()
    {
        if (BentoPrimaryGetClick())
        {
            var _value = BentoRefToggle(reference);
            
            if (is_callable(func))
            {
                func(_value);
            }
        }
    }
    
    eventDraw = function()
    {
        var _filled = (BentoRefGet(reference) == true);
        
        draw_sprite_stretched_ext(sBentoExFrame, 0, bentoLeft+4, bentoTop+4, bentoHeight, bentoHeight, c_black, 0.5);
        
        if (_filled)
        {
            draw_sprite_stretched_ext(sBentoExFrameFill, 0, bentoLeft+4, bentoTop+4, bentoHeight, bentoHeight, c_black, 0.5);
        }
        
        var _offset = BentoPrimaryGetHold()? 2 : 0;
        
        draw_sprite_stretched_ext(sBentoExFrame, 0, bentoLeft + _offset, bentoTop + _offset, bentoHeight, bentoHeight, BENTO_EXAMPLE_YELLOW, image_alpha);
        
        if (_filled)
        {
            draw_sprite_stretched_ext(sBentoExFrameFill, 0, bentoLeft + _offset, bentoTop + _offset, bentoHeight, bentoHeight, BENTO_EXAMPLE_YELLOW, image_alpha);
        }
        
        if (text != "")
        {
            draw_set_font(font);
            draw_set_halign(fa_left);
            draw_set_valign(fa_middle);
            draw_text(bentoLeft + bentoHeight + 7, 0.5*(bentoTop + bentoBottom), text);
            draw_set_valign(fa_top);
            draw_set_font(-1);
        }
    }
    
    eventDrawHover = function()
    {
        if (BentoGetClickable())
        {
            BentoDrawSpriteAround(10, sBentoExHighlight, undefined, c_black, 0.2, un, 3, 3);
            BentoDrawSpriteAround(10, sBentoExHighlight, undefined, BENTO_EXAMPLE_RED);
        }
    }
}