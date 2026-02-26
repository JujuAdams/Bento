// Feather disable all

/// @desc Draw

//Always call this in events in objects that inherit from `oBentoAncestor`!
event_inherited();

//Draw ourselves. Bento positions and sizes the instance automatically
draw_self();

// If we have some text then draw it centred on the button
if (text != "")
{
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(0.5*(bbox_left + bbox_right), 0.5*(bbox_top + bbox_bottom), text);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

//Draw a highlight over the button if the instance is being hovered by the Bento system's cursor
//(which applies to both pointer-driven and directional input)
if (BentoCursorGetHover() && BentoGetClickable())
{
    gpu_set_fog(true, c_white, 0, 0);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.5*image_alpha);
    gpu_set_fog(false, c_fuchsia, 0, 0);
}