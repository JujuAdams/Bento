// Feather disable all

/// @param sprite
/// @param [element=self]

function GuiSetSprite(_sprite, _element = self)
{
    if (not GuiExists(_element)) return;
    
    if (_element.GUI_VARS.__elementIsInstance)
    {
        if (_element.sprite_index != _sprite)
        {
            _element.sprite_index = _sprite;
            
            with(_element.GUI_VARS)
            {
                if (__layoutOriginAuto)
                {
                    __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT;
                }
            }
        }
    }
}