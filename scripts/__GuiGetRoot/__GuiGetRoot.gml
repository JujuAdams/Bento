// Feather disable all

function __GuiGetRoot()
{
    static _system = __GuiSystem();
    
    var _instance = _system.__rootInstance;
    if (_instance == undefined)
    {
        if (GUI_CREATE_LAYER != undefined)
        {
            _instance = instance_create_layer(0, 0, GUI_CREATE_LAYER, GuiObject);
        }
        else
        {
            _instance = instance_create_depth(0, 0, GUI_CREATE_DEPTH ?? 0, GuiObject);
        }
        
        _system.__rootInstance = _instance;
    }
    else
    {
        if (not instance_exists(_instance))
        {
            __GuiError("Root instance has been destroyed or deactivated");
        }
    }
    
    return _instance;
}