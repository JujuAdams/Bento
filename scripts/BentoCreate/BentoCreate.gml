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
    
    if (BENTO_SAFE)
    {
        if (__BentoIsInstance(_parent))
        {
            if (not __BentoObjectInheritsFrom(_parent.object_index, oBentoAncestor))
            {
                __BentoError($"Parent object instance is not a child of `oBentoAncestor` (instance was {object_get_name(_parent.object_index)}:{real(id)})\nTo create an instance as a child of root, use `BentoLayerGetRoot()` for the parent");
            }
        }
        else
        {
            try
            {
                var _vars = _parent.BENTO_VARS;
            }
            catch(_error)
            {
                __BentoError($"Parent struct does not inherit from `BentoConstrAncestor()` (instanceof was {instanceof(_parent)} {__BentoGetStructPointer(_parent)})\nTo create an instance as a child of root, use `BentoLayerGetRoot()` for the parent");
            }
        }
    }
    
    if ((not is_handle(_object)) || (not object_exists(_object)))
    {
        __BentoError($"`BentoCreate()` may only be used to create object instances (object reference was \"{typeof(_object)}\"");
    }
    
    if ((_object != oBentoAncestor) && (not __BentoObjectInheritsFrom(_object, oBentoAncestor)))
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