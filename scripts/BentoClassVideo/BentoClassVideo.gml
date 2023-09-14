/// Video playback using GameMaker's native player. The video is drawn stretched across the box.
/// 
/// In addition to BentoClassShared() variables, public variables are:
///   source
///   loop
///   color
///   alpha
/// 
/// This box has no callbacks or methods beyond BentoClassShared().

BentoAddBoxType("BentoVideo", BentoClassVideo, false);
function BentoClassVideo() : BentoClassShared() constructor
{
    /// Public variables ///
    source = undefined;
    loop   = true;
    color  = c_white;
    alpha  = 1;
    ////////////////////////
    
    CallbackSetOnClose(function()
    {
        video_open(source);
        video_enable_loop(loop);
    });
    
    CallbackSetDraw(function()
    {
        var _video = video_draw();
        if (_video[0] == 0)
        {
            var _color = merge_color(color, animBlend, animBlendAmount);
            var _alpha = alpha*animAlpha;
            
            draw_surface_stretched_ext(_video[1], __drawLeft, __drawTop, __drawRight - __drawLeft, __drawBottom - __drawTop, _color, _alpha);
        }
        else
        {
            video_close();
            video_open(source);
        }
    });
}