function __BentoNullableRefResolve(_value)
{
    return ((_value == undefined) || (not weak_ref_alive(_value)))? undefined : _value.ref;
}