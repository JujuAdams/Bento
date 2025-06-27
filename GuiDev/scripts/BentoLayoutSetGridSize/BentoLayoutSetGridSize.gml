// Feather disable all

/// @param [columns]
/// @param [rows]
/// @param [element=self]

function BentoLayoutSetGridSize(_columns, _rows, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (__layoutType != BENTO_LAYOUT_GRID)
        {
            __BentoError("Can only apply grid size to elements using a list layout");
        }
        
        if (__gridColumns != _columns)
        {
            __gridColumns = _columns;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
        }
        
        if (__gridRows != _rows)
        {
            __gridRows = _rows;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
        }
    }
}