// Feather disable all

/// @param [parent=self]

function GuiGetChildCount(_parent = self)
{
    return GuiExists(_parent)? array_length(_parent.GUI_VARS.__childArray) : 0;
}