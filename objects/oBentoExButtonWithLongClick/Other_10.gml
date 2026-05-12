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

if (BentoPrimaryGetLongPress())
{
    show_debug_message("long press");
}

if (BentoPrimaryGetLongHold())
{
    if ((BentoSystemGetTime() mod 15) == 0)
    {
        show_debug_message("long hold");
    }
}

if (BentoPrimaryGetLongRelease())
{
    show_debug_message("long release");
}

if (BentoPrimaryGetLongClick())
{
    audio_play_sound(sndBentoExBeep, 0, false);
    
    if (is_callable(funcLong))
    {
        funcLong();
    }
}

if (BentoCursorGetEnterByPlayer() && BentoUsingDirectional())
{
    audio_play_sound(sndBentoExBlip, 0, false);
}