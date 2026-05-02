// Feather disable all

/// Sets automatic calculation of an element's origin. This will override `BentoSetOrigin()`. The
/// origin of an element determines where the `bentoX` and `bentoY` coordinate is relative to the
/// top-left corner of the element.
/// 
/// N.B. Automatic origins only apply to Bento instances. This function will do nothing if applied
///      to a struct-based Bento element.
/// 
/// Automatic origin calculation uses the origin of the instance's assigned sprite (`sprite_index`).
/// This is convenient to keep behavior of Bento in line with native GameMaker behavior.
/// 
/// @param [element=self]

function BentoSetOriginAuto(_element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__elementIsInstance && (not __originAuto))
        {
            __originAuto = true;
            
            with(_element)
            {
                __BentoUpdateElementXY();
            }
        }
    }
}