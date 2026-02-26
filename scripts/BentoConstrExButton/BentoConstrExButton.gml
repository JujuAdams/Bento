// Feather disable all

/// Example of a struct-based button.
/// 
/// @param [clickFunc]
/// @param [text]
/// @param [parent=self]

function BentoConstrExButton(_clickFunc = undefined, _text = "", _parent = other) : BentoConstrExSprite(sBentoMaskRectangle, _parent) constructor
{
    text = _text;
    
    if (_clickFunc == undefined)
    {
        _clickFunc = function()
        {
            show_debug_message($"Button {string_delete(string(ptr(self)), 1, 8)} clicked");
        }
    }
    
    func = method(self, _clickFunc); //Ensure the click function is scoped to this instance
    
    //Allow Bento to focus this element
    BentoSetButton(BENTO_BUTTON_ALWAYS);

    //If we have some valid text then force the size of the element
    if (text != "")
    {
        BentoLayoutSetSize(string_width(text) + 20, string_height(text) + 20);
    }
    
    
    
    
    
    eventStep = function()
    {
        if (BentoPrimaryGetClick())
        {
            if (is_callable(func))
            {
                func();
            }
        }
    }
    
    eventDraw = function()
    {
        BentoDrawSprite(sBentoMaskRectangle);
        
        if (text != "")
        {
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            draw_set_alpha(image_alpha);
            draw_text(0.5*(bentoLeft + bentoRight), 0.5*(bentoTop + bentoBottom), text);
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
            draw_set_alpha(1);
        }
        
        // Draw a highlight over the button is the element is being hovered by the Bento system's cursor
        // (which applies to both pointer-driven and directional input). Alternatively, if this is a tab
        // button and this button cause a page to be opened by the tab group then we also highlight the
        // button.
        if (BentoCursorGetHover())
        {
            gpu_set_fog(true, c_white, 0, 0);
            BentoDrawSprite(sBentoMaskRectangle, undefined, undefined, 0.5*image_alpha);
            gpu_set_fog(false, c_fuchsia, 0, 0);
        }
    }
}