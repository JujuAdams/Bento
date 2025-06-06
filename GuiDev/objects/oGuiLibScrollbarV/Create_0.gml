// Feather disable all

event_inherited();

if (not variable_instance_exists(id, "target"))
{
    __GuiError("`.target` variable must be set");
}

if (not GuiExists(target))
{
    __GuiError("Target element does not exist");
}

GuiSetButton(GUI_BUTTON_POINTER);
GuiLayoutSetResizeType(GUI_RESIZE_STATIC, GUI_RESIZE_GROW);

handleTop              = 0;
handleBottom           = 0;
handleHover            = false;
handleGrabbed          = false;
handleGrabbedRelativeY = 0;