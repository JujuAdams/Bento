// Feather disable all

if (not surface_exists(surface))
{
    surface = surface_create(width, height);
}

surface_set_target(surface);
draw_sprite_tiled(sTestCheckerboard, 0, 0, 0);
BentoSystemDraw();
surface_reset_target();

draw_surface_ext(surface, 20, 20, 4, 4, 0, c_white, 1);