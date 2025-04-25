// Feather disable all

/// @param [instance=id]

function GuiScrollGetSpeed(_instance = id)
{
    with(__GuiScrollFindParent(_instance))
    {
        if ((not __scrollHori) && (not __scrollVert)) return 0;
        return __scrollSpeed;
    }
    
    return 0;
}