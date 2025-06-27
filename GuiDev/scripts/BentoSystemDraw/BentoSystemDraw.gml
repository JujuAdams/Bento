// Feather disable all

/// Draws all environments, layers, and elements.

function BentoSystemDraw()
{
    static _environmentArray = __BentoSystem().__environmentArray;
    
    __BentoScissorReset();
    
    var _i = 0;
    repeat(array_length(_environmentArray))
    {
        _environmentArray[_i].__Draw();
        ++_i;
    }
}