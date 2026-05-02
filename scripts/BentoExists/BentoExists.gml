// Feather disable all

/// Returns if a Bento element is alive and well. You may provide either an instance or struct.
/// Bento elements can be destroyed with `BentoDestroy()` or they can be destroyed if their Bento
/// parent (or other ancestor) is destroyed.
/// 
/// @param target

function BentoExists(_target)
{
    if (_target == BENTO_NO_ELEMENT) return false;
    if (instance_exists(_target)) return true;
    if (is_handle(_target) || is_method(_target)) return false;
    return is_struct(_target);
}