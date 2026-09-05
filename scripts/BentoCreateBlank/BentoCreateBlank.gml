// Feather disable all

/// Creates an invisible element for use with Bento. This is useful when working with tables or to
/// otherwise assist with layouts. This function creates a struct and not an instance. The struct
/// is constructed by `BentoConstrAncestor()`.
/// 
/// @param [parent=self]

function BentoCreateBlank(_parent = self)
{
    var _element = new BentoConstrAncestor(_parent);
    BentoSetVisible(false, _element);
    return _element;
}