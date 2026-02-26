// Feather disable all

/// Creates an element using a native GameMaker object and places the created instance inside
/// a parent element. This function returns the created instance. If you'd like to use Bento with
/// structs then please see `BentoConstrAncestor()`.
/// 
/// N.B. If the parent element is destroyed then the instance created by this function is destroyed
///      too. You don't need to manually clean up every instance.
/// 
/// @param object
/// @param [variableStruct]
/// @param [parent=self]

function BentoCreate(_object, _struct = undefined, _parent = self)
{
    static _system = __BentoSystem();
    static _emptyStruct = {};
    
    if (not BentoExists(_parent)) __BentoError("Parent doesn't exist");
    
    if ((not is_handle(_object)) || (not object_exists(_object)))
    {
        __BentoError($"`BentoCreate()` may only be used to create object instances (object reference was \"{typeof(_object)}\"");
    }
    
    if ((_object != oBentoAncestor) && (not object_is_ancestor(_object, oBentoAncestor)))
    {
        __BentoError($"Object \"{object_get_name(_object)}\" does not inherit from {object_get_name(oBentoAncestor)}");
    }
    
    var _oldCreatingObject = _system.__creatingObject;
    var _oldParent         = _system.__tempParent;
    
    _system.__creatingObject = true;
    _system.__tempParent     = _parent;
    
    if (BENTO_INSTANCE_LAYER != undefined)
    {
        var _element = instance_create_layer(_parent.bentoX, _parent.bentoY, BENTO_INSTANCE_LAYER, _object, _struct ?? _emptyStruct);
    }
    else
    {
        var _element = instance_create_depth(_parent.bentoX, _parent.bentoY, BENTO_INSTANCE_DEPTH ?? 0, _object, _struct ?? _emptyStruct);
    }
    
    _system.__creatingObject = _oldCreatingObject;
    _system.__tempParent     = _oldParent;
    
    return _element;
}