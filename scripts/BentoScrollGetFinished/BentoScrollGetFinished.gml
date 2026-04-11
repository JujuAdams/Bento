// Feather disable all

/// Returns whether the scroll animation has reached its final target position.
/// 
/// @param [element=self]

function BentoScrollGetFinished(_element = self)
{
    var _scroller = __BentoFindScrollElement(_element);
    if (not BentoExists(_scroller)) return false;
    
    with(_scroller.BENTO_VARS)
    {
        if ((not __scrollHori) && (not __scrollVert)) return false;
        return ((__scrollX == __scrollTargetX) && (__scrollY == __scrollTargetY));
    }
    
    return 0;
}