/// Simple clickable text button. Available in BentoScript using the BentoTextButton builder.
/// 
/// Don't forget to set the .targetListen and .click variables! Buttons will be highlightable but
/// won't do anything if you don't set BOTH variables. For example:
/// 
///     build BentoTextButton {
///         label = "Example Button"
///         
///         //Receive events from the left mouse button
///         targetListen = "action"
///         
///         //Then tell the UI system what to do when we're clicked
///         click = fn {
///             Log("Ping!")
///         }
///     }
/// 
/// Available variables (in addition to common UI variables) are:
/// 
/// | Name   | Datatype | Purpose                                                                   |
/// |--------|----------|---------------------------------------------------------------------------|
/// | label  | string   | Text to draw                                                              |
/// | margin | number   | Additional space to put around the text when calculating the bounding box |
/// | font   | string   | Name of the font to use                                                   |
/// | color  | RGB      | Colour to use when drawing the button                                     |
/// | alpha  | number   | Alpha blending value                                                      |

BentoAddBoxType("BentoTextButton", BentoClassTextButton, false);
function BentoClassTextButton() : BentoClassButton() constructor
{
    /// Public variables ///
    color  = c_white;
    alpha  = 1;
    ////////////////////////
    
    __label  = "???";
    __margin = 0;
    __font   = BENTO_DEFAULT_FONT;
    
    VariableBind("label", function()
    {
        return __label;
    },
    function(_value)
    {
        __label = _value;
        __UpdateSize();
    });
    
    VariableBind("margin", function()
    {
        return __margin;
    },
    function(_value)
    {
        __margin = _value;
        __UpdateSize();
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
        
        __UpdateSize();
    });
    
    static __UpdateSize = function()
    {
        var _oldFont = draw_get_font();
        draw_set_font(__font);
        
        Set("size", [string_width(__label) + 2*__margin, string_height(__label) + 2*__margin]);
        
        draw_set_font(_oldFont);
    }
    
    EventDraw(function()
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
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        
        draw_text_transformed(0.5*(__drawLeft + __drawRight), 0.5*(__drawTop + __drawBottom), __label, __drawScale, __drawScale, 0);
        
        draw_set_color(_oldColor);
        draw_set_alpha(_oldAlpha);
        draw_set_font( _oldFont);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    });
}