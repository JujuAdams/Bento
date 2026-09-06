// Feather disable all

/// Sets the size of the pointer hotspot for an element. This scaling factor only applies when
/// using a pointer input mode. Making a hotspot larger helps a player click on buttons that are
/// visually small (such as a (X) button to close a pop-up). A scale of `1` represents an unchanged
/// hotspot size, a scale of `2` will double the size of the hotspot etc.
/// 
/// @param scale
/// @param [element=self]

function BentoSetHotspotScale(_scale, _element = self)
{
    if (not BentoExists(_element)) return;
    _element.BENTO_VARS.__hotspotScale = _scale;
}