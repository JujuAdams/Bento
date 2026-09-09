// Feather disable all

screenshotName = undefined;

BentoLayerCreate("example layer");
ExampleHomePage();

if (BENTO_ON_MOBILE)
{
    display_set_gui_size(720, display_get_height() * (720 / display_get_width()));
    surface_resize(application_surface, window_get_width(), window_get_height());
}