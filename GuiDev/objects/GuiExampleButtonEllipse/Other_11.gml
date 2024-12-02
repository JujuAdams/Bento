/// @desc Draw

// Feather disable all

// Juju: Really simple draw code for a button. This is generally applicable for most interactible
//       UI elements.

event_inherited();

draw_set_color(c_black);
draw_set_alpha(0.85);
draw_ellipse(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
draw_set_color(c_white);
draw_set_alpha(1);

draw_ellipse(bbox_left, bbox_top, bbox_right, bbox_bottom, true);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(GuiGetCenterX(), GuiGetCenterY(), text);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Draw a highlight over the button is the instance is being hovered by the Gui system's cursor
// (which applies to both pointer-driven and directional input). Alternatively, if this is a tab
// button and this button cause a page to be opened by the tab group then we also highlight the
// button.
if (GuiNavGetOver() || GuiTabButtonIsOpen())
{
    draw_set_alpha(0.5);
    draw_ellipse(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
    draw_set_alpha(1);
}