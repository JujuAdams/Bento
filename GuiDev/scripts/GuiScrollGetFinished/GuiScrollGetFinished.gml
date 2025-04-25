// Feather disable all

/// @param [instance=id]

function GuiScrollGetFinished(_instance = id)
{
    with(__GuiScrollFindParent(_instance))
    {
        if ((not __scrollHori) && (not __scrollVert)) return false;
        return ((__scrollX == __scrollTargetX) && (__scrollY == __scrollTargetY));
    }
    
    return false;
}