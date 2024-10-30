// Feather disable all

// Juju: This is an example of a main menu controller object. This object is responsible for
//       managing user input into the Gui system as a whole. In the main project, user input
//       is funnelled through the Input library first to handle rebinding and hotswapping etc.
//       but in this example user input will be read by directly reading keyboard and mouse values.

// This creates the main menu page. See that object for an explanation of what "page" means in the
// context of the Gui system.
GuiCreateOutside(oPageMainMenu, un, GUI_ROOT, room_width/2, 500);