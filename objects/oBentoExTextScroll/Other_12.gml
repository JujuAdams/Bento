// Feather disable all

/// @desc Draw After

if (frame)
{
    draw_sprite_ext(sBentoExFrameShadow, image_index, x+4, y+4, image_xscale, image_yscale, image_angle, c_black, 0.4*image_alpha);
}

with(BentoScrollbarGetVertData())
{
    if (exists && handleVisible)
    {
        draw_sprite_stretched_ext(sBentoExButton, 0, handleLeft+4, handleTop+4, handleRight - handleLeft, handleBottom - handleTop, c_black, 0.5);
        draw_sprite_stretched_ext(sBentoExFrame, 0, barLeft+4, barTop+4, barRight - barLeft, barBottom - barTop, c_black, 0.5);
    }
}

if (frame)
{
    draw_self();
}

with(BentoScrollbarGetVertData())
{
    if (exists && handleVisible)
    {
        draw_sprite_stretched_ext(sBentoExButton, 0, handleLeft, handleTop, handleRight - handleLeft, handleBottom - handleTop, BENTO_EXAMPLE_YELLOW, 1);
        draw_sprite_stretched_ext(sBentoExFrame, 0, barLeft, barTop, barRight - barLeft, barBottom - barTop, BENTO_EXAMPLE_YELLOW, 1);
    }
}