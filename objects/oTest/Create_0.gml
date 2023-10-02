BentoDebugShowPointer(true);
BentoScriptGlobal().testString = "By Juju Adams\nWith the assistance of Katsaii";

useMouse = true;

BentoAddConstant("c_aqua",    c_aqua);
BentoAddConstant("c_black",   c_black);
BentoAddConstant("c_blue",    c_blue);
BentoAddConstant("c_dkgray",  c_dkgray);
BentoAddConstant("c_fuchsia", c_fuchsia);
BentoAddConstant("c_grey",    c_grey);
BentoAddConstant("c_green",   c_green);
BentoAddConstant("c_lime",    c_lime);
BentoAddConstant("c_ltgrey",  c_ltgrey);
BentoAddConstant("c_maroon",  c_maroon);
BentoAddConstant("c_navy",    c_navy);
BentoAddConstant("c_olive",   c_olive);
BentoAddConstant("c_orange",  c_orange);
BentoAddConstant("c_purple",  c_purple);
BentoAddConstant("c_red",     c_red);
BentoAddConstant("c_silver",  c_silver);
BentoAddConstant("c_teal",    c_teal);
BentoAddConstant("c_white",   c_white);
BentoAddConstant("c_yellow",  c_yellow);

BentoAddAsset("spr_logo");

BentoAddFunction("savedata_exists",    function() { return false });
BentoAddFunction("game_resume",        function() { return false });
BentoAddFunction("game_end",           game_end);
BentoAddFunction("show_page",          function() { return false });
BentoAddFunction("string",             string);
BentoAddFunction("show_debug_message", function(_string) { show_debug_message(string(current_time) + ": " + string(_string)) });
BentoAddFunction("show_message",       function(_string) { show_message(string(_string)) });
BentoAddFunction("draw_circle",        draw_circle);

BentoFileExecuteLayerTop("ExampleMenu.bento", "example menu");

//BentoOpen(new __BentoClassLayer());
//BentoFileExecute("MainMenu.bento");
//BentoClose();

//BentoStringExecute(@'
//build BentoLayer {
//    name = "main menu"
//    FileExecute("main_menu.bento")
//}
//');