/// @desc Draw

// Feather disable all

// Juju: Really simple draw code for a button. This is generally applicable for most interactible
//       UI elements.

draw_self();

// Draw a highlight over the button is the instance is being hovered by the Gui system's cursor
// (which applies to both pointer-driven and directional input). Alternatively, if this is a tab
// button and this button cause a page to be opened by the tab group then we also highlight the
// button.
if (GuiNavGetOver() || GuiTabButtonIsOpen())
{
    gpu_set_fog(true, c_white, 0, 0);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.5*image_alpha);
    gpu_set_fog(false, c_fuchsia, 0, 0);
}