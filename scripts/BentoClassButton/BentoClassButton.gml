/// Simple unadorned rectangular button. Useful as a basis for creating custom button behaviour.
/// Available in .ui scripts using the BentoButton builder.
/// 
/// Don't forget to set the .targetListen and .click variables! Buttons will be highlightable but
/// won't do anything if you don't set BOTH variables. For example:
/// 
///     build BentoButton {
///         //Receive events from the left mouse button
///         targetListen = "action"
///         
///         //Then tell the UI system what to do when we're clicked
///         click = fn {
///             Log("Ping!")
///         }
///     }
/// 
/// Available variables (in addition to shared UI variables) are:
/// 
/// | Name  | Datatype | Purpose                    |
/// |-------|----------|----------------------------|
/// | color | RGB      | Blend color for the button |
/// | alpha | number   | Alpha transparency         |

BentoAddBoxType("BentoButton", BentoClassButton, false);
function BentoClassButton() : BentoClassShared() constructor
{
    /// Public variables ///
    color = c_white;
    alpha = 1;
    ////////////////////////
    
    if (BENTO_DEFAULT_BUTTON_NAME != undefined) Set("targetListen", BENTO_DEFAULT_BUTTON_NAME);
    
    CallbackSetHighlightStart( function()
    {
        HighlightStateSet(true);
    });
    
    CallbackSetHighlightEnd(function()
    {
        HighlightStateSet(false);
    });
    
    CallbackSetButtonStart(function(_name)
    {
        ButtonStateSet(_name, true);
    });
    
    CallbackSetButtonEnd(function(_name)
    {
        ButtonStateSet(_name, false);
    });
    
    CallbackSetDraw(function()
    {
        var _color = merge_color(color, animBlend, animBlendAmount);
        var _alpha = alpha*animAlpha;
        
        var _oldColor = draw_get_color();
        var _oldAlpha = draw_get_alpha();
        
        draw_set_color(c_black);
        draw_set_alpha(_alpha);
        draw_rectangle(__drawLeft, __drawTop, __drawRight, __drawBottom, false);
        
        draw_set_color(_color);
        
        if (GetButton())
        {
            draw_set_alpha(0.5*_alpha);
            draw_rectangle(__drawLeft, __drawTop, __drawRight, __drawBottom, false);
        }
        else if (GetHighlight())
        {
            draw_set_alpha(0.25*_alpha);
            draw_rectangle(__drawLeft, __drawTop, __drawRight, __drawBottom, false);
        }
        
        if (_alpha > 0)
        {
            draw_set_alpha(_alpha);
            draw_rectangle(__drawLeft, __drawTop, __drawRight, __drawBottom, true);
        }
        
        draw_set_color(_oldColor);
        draw_set_alpha(_oldAlpha);
    });
}