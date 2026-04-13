// Feather disable all

/// Returns whether the Step user event / callback is enabled for the given element regardless of
/// whether it is a button or not (though Step events may not be executed for other reasons).
/// 
/// @param [element=self]

function BentoGetPushStep(_element = self)
{
    return BentoExists(_element)? _element.BENTO_VARS.__forceStep : false;
}