// Feather disable all

/// @param [columns]
/// @param [rows]
/// @param [element=self]

function BentoLayoutSetGridSize(_columns, _rows, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if ((_columns != undefined) && (__gridColumns != _columns))
        {
            __gridColumns = _columns;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
        }
        
        if ((_rows != undefined) && (__gridRows != _rows))
        {
            __gridRows = _rows;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
        }
    }
}