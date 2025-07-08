// Feather disable all

/// Example of a struct-based button.
/// 
/// @param [clickFunc]
/// @param [text]
/// @param [parent=self]

function ExampleConstrButton(_clickFunc = undefined, _text = "", _parent = other) : BentoConstrSprite(sBentoMaskRectangle, _parent) constructor
{
    if (_clickFunc == undefined)
    {
        _clickFunc = function()
        {
            show_debug_message($"Button {string_delete(string(ptr(self)), 1, 8)} clicked");
        }
    }
    
    text      = _text;
    clickFunc = method(self, _clickFunc);
    
    BentoSetButton(BENTO_BUTTON_ALWAYS);
    
    funcStep = function()
    {
        BentoScrollOnPointer();
        
        if (BentoPrimaryGetClick())
        {
            if (is_callable(clickFunc))
            {
                clickFunc();
            }
        }
    }
    
    funcDraw = function()
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