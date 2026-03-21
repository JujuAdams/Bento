// Feather disable all

/// @desc Draw After

draw_sprite_ext(sBentoExFrameShadow, image_index, x + BENTO_EXAMPLE_SHADOW_OFFSET, y + BENTO_EXAMPLE_SHADOW_OFFSET, image_xscale, image_yscale, image_angle, c_black, BENTO_EXAMPLE_SHADOW_ALPHA*image_alpha);

with(BentoScrollbarGetVertData())
{
    if (exists)
    {
        draw_sprite_stretched_ext(sBentoExButton, 0, handleLeft+4, handleTop+4, handleRight - handleLeft, handleBottom - handleTop, c_black, BENTO_EXAMPLE_SHADOW_ALPHA);;
        draw_sprite_stretched_ext(sBentoExFrame, 0, barLeft+4, barTop+4, barRight - barLeft, barBottom - barTop, c_black, BENTO_EXAMPLE_SHADOW_ALPHA);;
    }
}

draw_self();

with(BentoScrollbarGetVertData())
{
    if (exists)
    {
        draw_sprite_stretched_ext(sBentoExButton, 0, handleLeft, handleTop, handleRight - handleLeft, handleBottom - handleTop, BENTO_EXAMPLE_YELLOW, 1);
        draw_sprite_stretched_ext(sBentoExFrame, 0, barLeft, barTop, barRight - barLeft, barBottom - barTop, BENTO_EXAMPLE_YELLOW, 1);
    }
}