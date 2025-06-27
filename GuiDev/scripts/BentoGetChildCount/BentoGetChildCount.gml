// Feather disable all

/// @param [parent=self]

function BentoGetChildCount(_parent = self)
{
    return BentoExists(_parent)? array_length(_parent.GUI_VARS.__childArray) : 0;
}