// Feather disable all

/// Returns if an element is a valid target for a drag & drop item. If no element is being dragged
/// as an item then this function returns `false`.
/// 
/// @param [element=self]

function BentoDnDIsValidTarget(_element = self)
{
    with(__BentoGetVars(_element))
    {
        var _dndItemElement = __layer.__dndItemElement;
        if (BentoExists(_dndItemElement))
        {
            //We can always be dragged onto ourselves
            if (_element == _dndItemElement)
            {
                return true;
            }
            
            var _dndItemChannel = _dndItemElement.BENTO_VARS.__dndItemChannel
            
            return ((_dndItemChannel != undefined)
                 && ((_dndItemChannel == __dndTargetChannel) && ((not is_callable(__dndTargetFunc)) || __dndTargetFunc())));
        }
    }
    
    return false;
}