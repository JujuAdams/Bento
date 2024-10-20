// Feather disable all

/// Creates a GUI instance "outside" a parent GUI instance. Instances outside a parent will be:
/// 
/// - drawn after the parent
/// - drawn after "inside" instances
/// - follow the parent instance if the parent instance is moved with GuiMove()
/// 
/// "Outside" instances should be used for content that you want to float outside and on top of
/// the parent instance.
/// 
/// @param object
/// @param [struct]
/// @param [parent=root]
/// @param [x=0]
/// @param [y=0]

function GuiCreateOutside(_object, _struct = undefined, _parent = GUI_ROOT, _x = 0, _y = 0)
{
    static _system = __GuiSystem();
    static _emptyStruct = {};
    
    if (not object_is_ancestor(_object, GuiObject))
    {
        __GuiError($"Object {object_get_name(_object)} isn't a descendent of GuiObject");
    }
    
    if (not instance_exists(_parent)) __GuiError("Parent doesn't exist");
    
    _system.__tempParent = _parent;
    _system.__tempInside = false;
    
    if (GUI_CREATE_LAYER != undefined)
    {
        var _instance = instance_create_layer(_x, _y, GUI_CREATE_LAYER, _object, _struct ?? _emptyStruct);
    }
    else
    {
        var _instance = instance_create_depth(_x, _y, GUI_CREATE_DEPTH ?? 0, _object, _struct ?? _emptyStruct);
    }
    
    _system.__tempParent = GUI_ROOT;
    _system.__tempInside = false;
    
    return _instance;
}