// Feather disable all

/// Creates an element using an object and places it inside a parent element.
/// 
/// @param object
/// @param [variableStruct]
/// @param [parent=self]

function BentoCreateObject(_object, _struct = undefined, _parent = self)
{
    static _system = __BentoSystem();
    static _emptyStruct = {};
    
    if (not BentoExists(_parent)) __BentoError("Parent doesn't exist");
    
    if ((_object != oBentoAncestor) && (not object_is_ancestor(_object, oBentoAncestor)))
    {
        __BentoError($"Object \"{object_get_name(_object)}\" does not inherit from {object_get_name(oBentoAncestor)}");
    }
    
    var _oldParent = _system.__tempParent;
    _system.__tempParent = _parent;
    
    if (BENTO_INSTANCE_LAYER != undefined)
    {
        var _element = instance_create_layer(_parent.bentoX, _parent.bentoY, BENTO_INSTANCE_LAYER, _object, _struct ?? _emptyStruct);
    }
    else
    {
        var _element = instance_create_depth(_parent.bentoX, _parent.bentoY, BENTO_INSTANCE_DEPTH ?? 0, _object, _struct ?? _emptyStruct);
    }
    
    _system.__tempParent = _oldParent;
    
    return _element;
}