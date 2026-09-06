// Feather disable all

/// Returns the scale of the pointer hotspot for an element. If the element doesn't exist, this
/// function will return `1` (the default size).
/// 
/// @param [element=self]

function BentoGetHotspotScale(_element = self)
{
    return BentoExists(_element)? _element.BENTO_VARS.__hotspotScale : 1;
}