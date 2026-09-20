// Feather disable all

/// Returns a value from `0` to `1` representing how much of an element is visible through its
/// ancestors' clipping regions. If an element is fully visible, this value will be `1`. If an
/// element is completely hidden, this value will be `0`. A value between `0` and `1` indicates
/// that an element is partially visible.
/// 
/// @param [element=self]

function BentoClipGetCoverage(_element = self)
{
    if (not BentoExists(_element)) return 0;
    
    return _element.BENTO_VARS.__scissorCoverage;
}