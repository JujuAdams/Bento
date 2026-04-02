// Feather disable all

/// @desc Step

//If Bento thinks this button has been clicked then trigger the callback function
if (BentoPrimaryGetClick())
{
    audio_play_sound(sndBentoExBeep, 0, false);
    
    if (is_callable(func))
    {
        func();
    }
}

if (BentoCursorGetEnterByNavigation() && BentoUsingDirectional())
{
    audio_play_sound(sndBentoExBlip, 0, false);
}

if (BentoPrimaryGetRelease())
{
    show_debug_message("Released");
    
    if (BentoDnDGetItem() == self)
    {
        show_debug_message("We were being dragged");
        
        with(BentoDnDGetTarget())
        {
            show_debug_message($"Target ID = {id}");
        }
    }
}