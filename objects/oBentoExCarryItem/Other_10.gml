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

if (BentoCursorGetEnterByPlayer() && BentoUsingDirectional())
{
    audio_play_sound(sndBentoExBlip, 0, false);
}

with(BentoCarryItemBehavior())
{
    show_debug_message($"Target ID = {id}");
}