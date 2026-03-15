// Feather disable all

/// Creates an element using a native GameMaker object and places the created instance inside a
/// parent element. This function returns the created instance. The created element is given an
/// offset relative to its parent.
/// 
/// If you'd like to use Bento with structs then please see `BentoConstrAncestor()`.
/// 
/// N.B. If the parent element is destroyed then the instance created by this function is destroyed
///      too. You don't need to manually clean up every instance.
/// 
/// @param xOffset
/// @param yOffset
/// @param object
/// @param [variableStruct]
/// @param [parent=self]

function BentoCreateWithOffset(_xOffset, _yOffset, _object, _struct = undefined, _parent = self)
{
    with(BentoCreate(_object, _struct, _parent))
    {
        BentoSetOffset(_xOffset, _yOffset);
        return self;
    }
    
    return BENTO_NO_ELEMENT;
}