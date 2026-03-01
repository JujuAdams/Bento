// Feather disable all

/// @param reference
/// @param [text]
/// @param [func]
/// @param [parent=self]

function BentoExConstrCheckbox(_reference, _text = "", _func = undefined, _parent = other) : BentoConstrAncestor(_parent) constructor
{
    reference   = _reference;
    text        = _text;
    func        = _func ?? function() {};
    
    //Ensure the click function is scoped to this instance
    func = method(self, func);
    
    BentoSetButton(BENTO_BUTTON_ALWAYS);
    
    if (text != "")
    {
        var _oldFont = draw_get_font();
        draw_set_font(-1);
        
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
        draw_sprite_stretched_ext(sBentoMaskRectangle, 0, bentoLeft, bentoTop, bentoHeight, bentoHeight, c_white, image_alpha);
        
        if (BentoRefGet(reference))
        {
            draw_circle(bentoLeft + bentoHeight/2, 0.5*(bentoTop + bentoBottom), bentoHeight/2 - 8, false);
        }
        
        if (text != "")
        {
            draw_set_halign(fa_left);
            draw_set_valign(fa_middle);
            draw_text(bentoLeft + bentoHeight + 7, 0.5*(bentoTop + bentoBottom), text);
            draw_set_valign(fa_top);
        }
        
        // Draw a highlight over the button is the instance is being hovered by the Bento system's cursor
        // (which applies to both pointer-driven and directional input). Alternatively, if this is a tab
        // button and this button cause a page to be opened by the tab group then we also highlight the
        // button.
        if (BentoCursorGetHover() && BentoGetClickable())
        {
            gpu_set_fog(true, c_white, 0, 0);
            draw_sprite_stretched_ext(sBentoMaskRectangle, 0, bentoLeft, bentoTop, bentoHeight, bentoHeight, c_white, 0.5*image_alpha);
            gpu_set_fog(false, c_fuchsia, 0, 0);
        }
    }
}