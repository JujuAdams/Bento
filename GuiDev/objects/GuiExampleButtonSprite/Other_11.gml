/// @desc Draw

// Feather disable all

// Juju: Really simple draw code for a button. This is generally applicable for most interactible
//       UI elements.

event_inherited();

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, (GuiNavGetOver() || GuiTabButtonIsOpen())? 1 : 0.85);