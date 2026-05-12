// Feather disable all

/// @desc Step

if (BentoPrimaryGetClick())
{
    var _value = BentoRefToggle(reference);
    
    if (is_callable(func))
    {
        func(_value);
    }
}

if (BentoCursorGetEnterByPlayer() && BentoUsingNavigation())
{
    audio_play_sound(sndBentoExBlip, 0, false);
}