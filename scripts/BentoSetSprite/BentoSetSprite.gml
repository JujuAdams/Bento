// Feather disable all

/// Safely sets the sprite for an instance-based Bento element. This function ensures that any
/// automatic layouts are properly updated.
/// 
/// @param sprite
/// @param [instance=self]
/// @param [force=false]

function BentoSetSprite(_sprite, _instance = self, _force = false)
{
    if (not BentoExists(_instance)) return;
    
    if (_instance.BENTO_VARS.__elementIsInstance)
    {
        if ((_instance.sprite_index != _sprite) || _force)
        {
            _instance.sprite_index = _sprite;
            
            with(_instance.BENTO_VARS)
            {
                if (__originAuto)
                {
                    __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
                }
            }
        }
    }
}