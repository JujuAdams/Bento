/// Simple rectangle with separate fill color and border color
/// Useful for acting as a placeholder whilst white boxing
/// 
/// In addition to BentoClassShared() variables, public variables are:
///   borderColor
///   borderAlpha
///   fillColor
///   fillAlpha
/// 
/// This box has no callbacks or methods beyond BentoClassShared()

BentoAddBoxType("BentoRectangle", BentoClassRectangle, false);
function BentoClassRectangle() : BentoClassShared() constructor
{
    /// Public variables ///
    borderColor = c_white;
    borderAlpha = 1;
    fillColor   = c_white;
    fillAlpha   = 0.1;
    ////////////////////////
    
    
    
    
    
    CallbackSetDraw(function()
    {
        var _oldColor = draw_get_color();
        var _oldAlpha = draw_get_alpha();
        
        if (fillAlpha > 0)
        {
            draw_set_color(merge_color(fillColor, animBlend, animBlendAmount));
            draw_set_alpha(fillAlpha*animAlpha);
            draw_rectangle(__drawLeft, __drawTop, __drawRight, __drawBottom, false);
        }
        
        if (borderAlpha > 0)
        {
            draw_set_color(merge_color(borderColor, animBlend, animBlendAmount));
            draw_set_alpha(borderAlpha*animAlpha);
            draw_rectangle(__drawLeft, __drawTop, __drawRight, __drawBottom, true);
        }
        
        draw_set_color(_oldColor);
        draw_set_alpha(_oldAlpha);
    });
}