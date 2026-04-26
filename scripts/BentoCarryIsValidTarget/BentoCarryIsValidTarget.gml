// Feather disable all

/// Returns if an element is a valid target for a drag & drop item. If no element is being dragged
/// as an item then this function returns `false`.
/// 
/// @param [element=self]

function BentoCarryIsValidTarget(_element = self)
{
    with(__BentoGetVars(_element))
    {
        var _carryItemElement = __layer.__carryItemElement;
        if (BentoExists(_carryItemElement))
        {
            //We can always be dragged onto ourselves
            if (_element == _carryItemElement)
            {
                return true;
            }
            
            var _carryItemChannel = _carryItemElement.BENTO_VARS.__carryItemChannel
            
            return ((_carryItemChannel != undefined)
                 && ((_carryItemChannel == __carryTargetChannel) && ((not is_callable(__carryTargetFunc)) || __carryTargetFunc())));
        }
    }
    
    return false;
}