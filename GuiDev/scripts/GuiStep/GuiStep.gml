// Feather disable all

/// Updates the GUI system based on the navigation mode (`GuiNavSetMode()`) and user input:
/// 
/// - `GuiInputPointer()`
/// - `GuiInputDirectional()`
/// - `GuiInputHotkey()`

function GuiStep(_rootWidth, _rootHeight)
{
    static _system = __GuiSystem();
    static _environmentArray = _system.__environmentArray;
    
    with(_system)
    {
        ++__frame;
        
        var _i = 0;
        repeat(array_length(_environmentArray))
        {
            _environmentArray[_i].__Update(_rootWidth, _rootHeight);
            ++_i;
        }
    }
    
}