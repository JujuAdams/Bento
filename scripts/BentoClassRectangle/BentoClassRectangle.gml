/// A basic rectangle. Useful for whiteboxing or creating semi-transparent masks. Available in
/// BentoScript using the BentoRectangle builder.
/// 
/// Available variables (in addition to shared UI variables) are:
/// 
/// | Name        | Datatype | Purpose                          |
/// |-------------|----------|----------------------------------|
/// | borderColor | RGB      | Colour of the border             |
/// | borderAlpha | number   | Alpha transparency of the border |
/// | fillColor   | RGB      | Colour of the rectangle fill     |
/// | fillAlpha   | number   | Alpha transparency of the fill   |

BentoAddBoxType("BentoRectangle", BentoClassRectangle, false);
function BentoClassRectangle() : BentoClassShared() constructor
{
    /// Public variables ///
    borderColor = c_white;
    borderAlpha = 1;
    fillColor   = c_white;
    fillAlpha   = 0.1;
    ////////////////////////
    
    EventSetDraw(function()
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