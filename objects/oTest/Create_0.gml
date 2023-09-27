BentoDebugShowPointer(true);
BentoScriptGlobal().testString = "By Juju Adams\nWith the assistance of Katsaii";

useMouse = true;

BentoScriptGetEnvironment().interface.exposeConstant(
    "c_aqua",    c_aqua,
    "c_black",   c_black,
    "c_blue",    c_blue,
    "c_dkgray",  c_dkgray,
    "c_fuchsia", c_fuchsia,
    "c_grey",    c_grey,
    "c_green",   c_green,
    "c_lime",    c_lime,
    "c_ltgrey",  c_ltgrey,
    "c_maroon",  c_maroon,
    "c_navy",    c_navy,
    "c_olive",   c_olive,
    "c_orange",  c_orange,
    "c_purple",  c_purple,
    "c_red",     c_red,
    "c_silver",  c_silver,
    "c_teal",    c_teal,
    "c_white",   c_white,
    "c_yellow",  c_yellow
);

BentoScriptGetEnvironment().interface.exposeConstant(
    "spr_logo", spr_logo,
);

BentoScriptGetEnvironment().interface.exposeFunction(
    "savedata_exists",    function() { return false },
    "game_resume",        function() { return false },
    "game_end",           game_end,
    "show_page",          function() { return false },
    "string",             string,
    "show_debug_message", function(_string) {
        show_debug_message(string(current_time) + ": " + string(_string))
    },
    "show_message",       function(_string) { show_message(string(_string)) },
    "draw_circle",        draw_circle
);

BentoFileExecuteLayerTop("MainMenu.bento", "main menu");

//BentoOpen(new __BentoClassLayer());
//BentoFileExecute("MainMenu.bento");
//BentoClose();

//BentoStringExecute(@'
//build BentoLayer {
//    name = "main menu"
//    FileExecute("main_menu.bento")
//}
//');