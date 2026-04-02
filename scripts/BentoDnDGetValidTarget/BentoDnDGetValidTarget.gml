// Feather disable all

/// @param [element=self]

function BentoDnDGetValidTarget(_element = self)
{
    with(__BentoGetVars(_element))
    {
        var _dndItemElement = __layer.__dndItemElement;
        if (BentoExists(_dndItemElement))
        {
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