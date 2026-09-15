/// @desc Step

if (BentoUsingPointer())
{
    if (BentoPrimaryGetHold())
    {
        mapTargetX = clamp(mapTargetX - BentoCursorGetDX(), 0, sprite_get_width(mapSprite) - (bentoWidth-10));
        mapTargetY = clamp(mapTargetY - BentoCursorGetDY(), 0, sprite_get_height(mapSprite) - (bentoHeight-10));
        mapX = mapTargetX;
        mapY = mapTargetY;
    }
}
else
{
    if (BentoPrimaryGetClick())
    {
        BentoFocusToggle(BENTO_FOCUS_POINTER_CANCEL_ALWAYS);
    }
    
    if (BentoHotkeyGetPress(BENTO_HOTKEY_CANCEL))
    {
        BentoFocusClose();
    }
    
    if (BentoGetFocused())
    {
        mapTargetX = clamp(mapTargetX + 30*BentoCursorGetDX(), 0, sprite_get_width(mapSprite) - (bentoWidth-10));
        mapTargetY = clamp(mapTargetY + 30*BentoCursorGetDY(), 0, sprite_get_height(mapSprite) - (bentoHeight-10));
    }
    
    if (BentoCursorGetEnterByPlayer())
    {
        audio_play_sound(sndBentoExBlip, 0, false);
    }
}

//Smoothly tween towards the target position
mapX = lerp(mapX, mapTargetX, 0.1);
mapY = lerp(mapY, mapTargetY, 0.1);