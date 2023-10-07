/// An invisible rectangle used for organising layouts. Available in BentoScript using the BentoBox
/// builder.
/// 
/// Available variables (in addition to shared UI variables) are:
/// 
/// | Name | Datatype | Purpose |
/// |------|----------|---------|
/// | None |          |         |

BentoAddBoxType("BentoBox", BentoClassBox, false);
function BentoClassBox() : BentoClassShared() constructor
{
    Set("visible", false);
    
    EventDraw(function()
    {
        var _oldColor = draw_get_color();
        var _oldAlpha = draw_get_alpha();
        
        draw_set_color(merge_color(c_white, animBlend, animBlendAmount));
        draw_set_alpha(animAlpha);
        draw_rectangle(__drawLeft, __drawTop, __drawRight, __drawBottom, true);
        
        draw_set_color(_oldColor);
        draw_set_alpha(_oldAlpha);
    });
}