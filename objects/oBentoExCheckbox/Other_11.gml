// Feather disable all

/// @desc Draw

draw_sprite_stretched_ext(sprite_index, image_index, bentoLeft, bentoTop, bentoHeight, bentoHeight, image_blend, image_alpha);

if (BentoRefGet(reference))
{
    draw_circle(bentoLeft + bentoHeight/2, bentoY, bentoHeight/2 - 8, false);
}

if (text != "")
{
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_text(bentoLeft + bentoHeight + 7, 0.5*(bentoTop + bentoBottom), text);
    draw_set_valign(fa_top);
}

// Draw a highlight over the button is the instance is being hovered by the Bento system's cursor
// (which applies to both pointer-driven and directional input). Alternatively, if this is a tab
// button and this button cause a page to be opened by the tab group then we also highlight the
// button.
if (BentoCursorGetHover() && BentoGetClickable())
{
    gpu_set_fog(true, c_white, 0, 0);
    draw_sprite_stretched_ext(sprite_index, image_index, bentoLeft, bentoTop, bentoHeight, bentoHeight, image_blend, 0.5*image_alpha);
    gpu_set_fog(false, c_fuchsia, 0, 0);
}