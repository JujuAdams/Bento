// Feather disable all

/// @param sprite
/// @param [element=self]

function GuiSetSprite(_sprite, _element = self)
{
    if (not GuiExists(_element)) return;
    
    if (__GuiIsInstance(_element))
    {
        if (_element.sprite_index != _sprite)
        {
            _element.sprite_index = _sprite;
            
            with(_element.GUI_VARS)
            {
                if (__layoutOriginAuto)
                {
                    __layer.__layoutDirty = true;
                }
            }
        }
    }
}