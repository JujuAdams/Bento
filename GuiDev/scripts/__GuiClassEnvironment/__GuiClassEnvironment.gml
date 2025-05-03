// Feather disable all

/// @param name

function __GuiClassEnvironment(_name) constructor
{
    static _system = __GuiSystem();
    
    __name = _name;
    
    __layerCurrent = new __GuiClassLayer(self, "default");
    __layerArray = [__layerCurrent];
    
    __envMouseX    = 0;
    __envMouseY    = 0;
    __envMouseHold = false;
    
    __envDirectionalDX   = 0;
    __envDirectionalDY   = 0;
    __envDirectionalHold = false;
    
    __envHotkeyInputMap = ds_map_create();
    __envHotkeyArray    = [];
    
    
    
    
    
    static __Destroy = function()
    {
        var _index = array_get_index(_system.__environmentArray, self);
        if (_index >= 0) array_delete(_system.__environmentArray, _index, 1);
        
        if (_system.__environmentCurrent == self)
        {
            __GuiEnvironmentTargetPop();
        }
        
        var _layerArray = __layerArray;
        
        var _i = array_length(_layerArray)-1;
        repeat(array_length(_layerArray))
        {
            _layerArray[_i].__Destroy();
            --_i;
        }
    }
    
    static __RemoveLayer = function(_layer)
    {
        var _index = array_get_index(__layerArray, _layer);
        if (_index >= 0) array_delete(__layerArray, _index, 1);
    }
    
    static __Update = function(_rootWidth, _rootHeight)
    {
        var _layerArray = __layerArray;
        
        var _layerCount = array_length(_layerArray);
        if (_layerCount <= 0) return;
        
        __GuiEnvironmentTargetPush(self);
        
        var _i = 0;
        repeat(_layerCount-1)
        {
            _layerArray[_i].__Update(_rootWidth, _rootHeight, true);
            ++_i;
        }
        
        _layerArray[_i].__Update(_rootWidth, _rootHeight, false);
        __GuiEnvironmentTargetPop();
    }
    
    static __Draw = function()
    {
        __GuiEnvironmentTargetPush(self);
        
        var _layerArray = __layerArray;
        var _i = 0;
        repeat(array_length(_layerArray))
        {
            _layerArray[_i].__Draw();
            ++_i;
        }
        
        __GuiEnvironmentTargetPop();
    }
}