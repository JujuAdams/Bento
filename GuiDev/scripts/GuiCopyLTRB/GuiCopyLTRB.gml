// Feather disable all

/// Copies the position and size of one instance to another instance. If the `source` instance
/// doesn't exist then the `fallbackWidth` and `fallbackHeight` are used instead.
/// 
/// @param source
/// @param destination

function GuiCopyLTRB(_source, _destination)
{
    if (not instance_exists(_source)) return;
    if (not instance_exists(_destination)) return;
    
    GuiSetLTRB(_source.bbox_left, _source.bbox_top, _source.bbox_right, _source.bbox_bottom, _destination);
}