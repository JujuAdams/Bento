BentoAddBoxType("BentoText", BentoClassText, false);
function BentoClassText() : BentoClassShared() constructor
{
    /// Public variables ///
    color  = c_white;
    alpha  = 1;
    hAlign = "center";
    vAlign = "middle";
    ////////////////////////
    
    __label  = "???";
    __margin = 0;
    __font   = BENTO_DEFAULT_FONT;
    __wrap   = false;
    
    
    
    
    
    VariableBind("label", function()
    {
        return __label;
    },
    function(_value)
    {
        __label = _value;
        if (!__wrap) Trim();
    });
    
    VariableBind("margin", function()
    {
        return __margin;
    },
    function(_value)
    {
        __margin = _value;
        if (!__wrap) Trim();
    });
    
    VariableBind("font", function()
    {
        return font_get_name(__font);
    },
    function(_value)
    {
        if (_value == "default")
        {
            __font = BENTO_DEFAULT_FONT;
        }
        else
        {
            var _result = asset_get_index(_value);
            __font = font_exists(_result)? _result : BENTO_DEFAULT_FONT;
        }
        
        if (!__wrap) Trim();
    });
    
    static Trim = function()
    {
        var _oldFont = draw_get_font();
        draw_set_font(__font);
        
        if (__wrap)
        {
            Set("size", [string_width_ext(__label, -1, __localWidth) + 2*__margin, string_height_ext(__label, -1, __localWidth) + 2*__margin]);
        }
        else
        {
            Set("size", [string_width(__label) + 2*__margin, string_height(__label) + 2*__margin]);
        }
        
        draw_set_font(_oldFont);
    }
    
    
    
    
    
    CallbackSetDraw(function()
    {
        BentoCallInherited();
        
        var _color = merge_color(color, animBlend, animBlendAmount);
        var _alpha = alpha*animAlpha;
        
        var _oldColor = draw_get_color();
        var _oldAlpha = draw_get_alpha();
        var _oldFont  = draw_get_font();
        
        draw_set_color(_color);
        draw_set_alpha(_alpha);
        draw_set_font(__font);
        
        switch(hAlign)
        {
            case "left":
                var _x = __drawLeft;
                draw_set_halign(fa_left);
            break;
            
            case "center":
            case "centre":
                var _x = 0.5*(__drawLeft + __drawRight);
                draw_set_halign(fa_center);
            break;
            
            case "right":
                var _x = __drawRight;
                draw_set_halign(fa_right);
            break;
            
            default:
                __BentoError("Unhandled value for .hAlign \"", hAlign, "\"");
            break;
        }
        
        switch(vAlign)
        {
            case "top":
                var _y = __drawTop;
                draw_set_valign(fa_top);
            break;
            
            case "middle":
                var _y = 0.5*(__drawTop + __drawBottom);
                draw_set_valign(fa_middle);
            break;
            
            case "bottom":
                var _y = __drawBottom;
                draw_set_valign(fa_bottom);
            break;
            
            default:
                __BentoError("Unhandled value for .vAlign \"", vAlign, "\"");
            break;
        }
        
        if (__wrap)
        {
            draw_text_ext_transformed(_x, _y, __label, -1, __localWidth - 2*__margin, __drawScale, __drawScale, 0);
        }
        else
        {
            draw_text_transformed(_x, _y, __label, __drawScale, __drawScale, 0);
        }
        
        draw_set_color(_oldColor);
        draw_set_alpha(_oldAlpha);
        draw_set_font( _oldFont);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    });
}