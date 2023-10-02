/// Video playback using GameMaker's native player. The video is drawn stretched across the
/// bounding box. Available in BentoScript using the BentoVideo builder.
/// 
/// Available variables (in addition to shared UI variables) are:
/// 
/// | Name   | Datatype | Purpose                              |
/// |--------|----------|--------------------------------------|
/// | color  | RGB      | Blend color for the video surface    |
/// | alpha  | number   | Alpha transparency                   |
/// | source | string   | Path to the video file to play       |
/// | loop   | boolean  | Whether or not the video should loop |

BentoAddBoxType("BentoVideo", BentoClassVideo, false);
function BentoClassVideo() : BentoClassShared() constructor
{
    /// Public variables ///
    source = undefined;
    loop   = true;
    color  = c_white;
    alpha  = 1;
    ////////////////////////
    
    EventOnClose(function()
    {
        video_open(source);
        video_enable_loop(loop);
    });
    
    EventDraw(function()
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