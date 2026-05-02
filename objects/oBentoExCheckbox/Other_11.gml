// Feather disable all

/// @desc Draw

var _filled = (BentoRefGet(reference) == true);

draw_sprite_stretched_ext(sprite_index, image_index, bentoLeft+4, bentoTop+4, bentoHeight, bentoHeight, c_black, BENTO_EXAMPLE_SHADOW_ALPHA);;

if (_filled)
{
    draw_sprite_ext(sBentoExFrameFill, 0, bentoLeft+4, bentoTop+4, image_yscale, image_yscale, image_angle, c_black, BENTO_EXAMPLE_SHADOW_ALPHA);;
}

var _offset = BentoPrimaryGetHold()? 2 : 0;

draw_sprite_stretched_ext(sprite_index, image_index, bentoLeft + _offset, bentoTop + _offset, bentoHeight, bentoHeight, image_blend, image_alpha);

if (_filled)
{
    draw_sprite_ext(sBentoExFrameFill, 0, bentoLeft + _offset, bentoTop + _offset, image_yscale, image_yscale, image_angle, image_blend, image_alpha);
}

if (text != "")
{
    draw_set_font(font);
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_text(bentoLeft + bentoHeight + 7, 0.5*(bentoTop + bentoBottom), text);
    draw_set_valign(fa_top);
    draw_set_font(-1);
}