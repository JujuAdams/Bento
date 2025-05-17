// Feather disable all

/// Creates a GUI instance "inside" a parent GUI instance. Instances inside a parent will be:
/// 
/// - clipped if scissoring is turned on for the parent
/// - scrolled if scrolling is turned on for the parent
/// - drawn after the parent
/// - follow the parent instance if the parent instance is moved with GuiMove()
/// 
/// @param object
/// @param [variableStruct]
/// @param [parent=self]

function GuiCreateObject(_object, _struct = undefined, _parent = self)
{
    static _system = __GuiSystem();
    static _emptyStruct = {};
    
    if (not __GuiExists(_parent)) __GuiError("Parent doesn't exist");
    
    if ((_object != oGuiLibAncestor) && (not object_is_ancestor(_object, oGuiLibAncestor)))
    {
        __GuiError($"Object \"{object_get_name(_object)}\" does not inherit from {object_get_name(oGuiLibAncestor)}");
    }
    
    var _oldParent = _system.__tempParent;
    _system.__tempParent = _parent;
    
    if (GUI_CREATE_LAYER != undefined)
    {
        var _element = instance_create_layer(_parent.guiX, _parent.guiY, GUI_CREATE_LAYER, _object, _struct ?? _emptyStruct);
    }
    else
    {
        var _element = instance_create_depth(_parent.guiX, _parent.guiY, GUI_CREATE_DEPTH ?? 0, _object, _struct ?? _emptyStruct);
    }
    
    _system.__tempParent = _oldParent;
    return _element;
}