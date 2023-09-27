/// Simple rectangular button with color and alpha.
/// 
/// Make sure to set <targetListen> and <callbackClick> to activate the button!
/// 
/// In addition to BentoClassShared() variables, public variables are:
///   color
///   alpha
/// 
/// This box has no callbacks or methods beyond BentoClassShared().

BentoAddBoxType("BentoButton", BentoClassButton, false);
function BentoClassButton() : BentoClassShared() constructor
{
    /// Public variables ///
    color = c_white;
    alpha = 1;
    ////////////////////////
    
    
    
    
    
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