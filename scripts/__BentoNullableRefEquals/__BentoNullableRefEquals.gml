/// @param aRef
/// @param bRef

function __BentoNullableRefEquals(_aRef, _bRef)
{
    return (__BentoNullableRefAlive(_aRef) && __BentoNullableRefAlive(_bRef) && (__BentoNullableRefResolve(_aRef) == __BentoNullableRefResolve(_bRef)));
}