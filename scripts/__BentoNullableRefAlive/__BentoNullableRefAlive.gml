function __BentoNullableRefAlive(_value)
{
    return ((_value != undefined) && weak_ref_alive(_value) && _value.ref.Exists());
}