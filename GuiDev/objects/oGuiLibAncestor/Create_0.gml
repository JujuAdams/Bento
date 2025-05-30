// Feather disable all

//Library instances are expected to persist between rooms.
persistent = true;

///////////////////////////
//                       //
//  Read-Only Variables  //
//                       //
///////////////////////////

//These variables give the position of various parts of this instance in worldspace. They're
//read-only in the sense that they are liable to get overwritten by the library at unexpected
//times.

guiLeft   = x - (sprite_exists(sprite_index)? sprite_get_xoffset(sprite_index) : 0);
guiTop    = y - (sprite_exists(sprite_index)? sprite_get_yoffset(sprite_index) : 0);
guiRight  = guiLeft + sprite_width;
guiBottom = guiTop + sprite_height;
guiX      = x;
guiY      = y;
guiWidth  = sprite_width;
guiHeight = sprite_height;

//Make a struct to contain GUI-related variables. This keeps the instance clean in the debugger.
GUI_VARS = new __GuiClassVariables(self);

//Set the parent before going to the Create event for the instance
var _system = __GuiSystem();
GuiSetParent(_system.__tempParent, self, _system.__tempIgnoreContainer);