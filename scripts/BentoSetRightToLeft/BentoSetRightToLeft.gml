// Feather disable all

/// @param state
/// @param [environmentOrName=current]

function BentoSetRightToLeft(_state, _environmentOrName = undefined)
{
    static _system = __BentoSystem();
    
    with(_system)
    {
        if (__rightToLeft == _state) return;
        
        _system.__rightToLeft = _state;
        
        var _environmentArray = __environmentArray;
        var _i = 0;
        repeat(array_length(_environmentArray))
        {
            var _layerArray = _environmentArray[_i].__layerArray;
            
            var _j = 0;
            repeat(array_length(_layerArray))
            {
                _layerArray[_j].__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
                ++_j;
            }
            
            ++_i;
        }
    }
}