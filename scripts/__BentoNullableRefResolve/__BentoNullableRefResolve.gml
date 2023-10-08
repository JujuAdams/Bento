function __BentoNullableRefResolve(_value)
{
    return __BentoNullableRefAlive(_value)? _value.ref : undefined;
}