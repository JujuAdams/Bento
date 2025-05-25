// Feather disable all

/// @param [clickFunc]
/// @param [text]
/// @param [parent=self]

function ExampleConstrButton(_clickFunc = undefined, _text = "", _parent = other) : GuiConstrSprite(sGuiMaskRectangle, _parent) constructor
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
    
    GuiSetButton(GUI_BUTTON_ALWAYS);
    
    funcStep = function()
    {
        GuiScrollOnPointer();
        
        if (GuiPrimaryGetClick())
        {
            if (is_callable(clickFunc))
            {
                clickFunc();
            }
        }
    }
    
    funcDraw = function()
    {
        GuiDrawSprite(sGuiMaskRectangle);
        
        if (text != "")
        {
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            draw_text(0.5*(guiLeft + guiRight), 0.5*(guiTop + guiBottom), text);
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
        }
        
        // Draw a highlight over the button is the instance is being hovered by the Gui system's cursor
        // (which applies to both pointer-driven and directional input). Alternatively, if this is a tab
        // button and this button cause a page to be opened by the tab group then we also highlight the
        // button.
        if (GuiCursorGetOver())
        {
            gpu_set_fog(true, c_white, 0, 0);
            GuiDrawSprite(sGuiMaskRectangle, undefined, undefined, 0.5);
            gpu_set_fog(false, c_fuchsia, 0, 0);
        }
    }
}