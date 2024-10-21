// Feather disable all

/// Creates a GUI instance "inside" a parent GUI instance. Instances inside a parent will be:
/// 
/// - clipped if scissoring is turned on for the parent
/// - scrolled if scrolling is turned on for the parent
/// - drawn after the parent
/// - drawn before "outside" instances
/// - follow the parent instance if the parent instance is moved with GuiMove()
/// 
/// "Inside" instances should be used for content that you want to contain inside the parent.
/// 
/// @param object
/// @param [struct]
/// @param [parent=id]

function GuiCreateInside(_object, _struct = undefined, _parent = id, _x = 0, _y = 0)
{
    static _system = __GuiSystem();
    static _emptyStruct = {};
    
    if (not instance_exists(_parent)) __GuiError("Parent doesn't exist");
    
    if (not object_is_ancestor(_object, GuiObject))
    {
        __GuiError($"Object {object_get_name(_object)} isn't a descendent of GuiObject");
    }
    
    _system.__tempParent = _parent;
    _system.__tempInside = true;
    
    if (GUI_CREATE_LAYER != undefined)
    {
        var _instance = instance_create_layer(_x + _parent.x, _y + _parent.y, GUI_CREATE_LAYER, _object, _struct ?? _emptyStruct);
    }
    else
    {
        var _instance = instance_create_depth(_x + _parent.x, _y + _parent.y, GUI_CREATE_DEPTH ?? 0, _object, _struct ?? _emptyStruct);
    }
    
    _system.__tempParent = GUI_ROOT;
    _system.__tempInside = false;
    
    return _instance;
}