// Feather disable all

/// @param [element=self]

function BentoAnimEnd(_element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.GUI_VARS.__layer)
    {
        ds_map_delete(__animatingMap, _element);
        
        var _animatingArray = __animatingArray;
        var _i = 0;
        repeat(array_length(_animatingArray))
        {
            if (_animatingArray[_i].__element == _element)
            {
                array_delete(_animatingArray, _i, 1);
                break;
            }
            
            ++_i;
        }
    }
}