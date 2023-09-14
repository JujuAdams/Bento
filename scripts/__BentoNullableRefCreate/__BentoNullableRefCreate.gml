function __BentoNullableRefCreate(_value)
{
    return ((_value == undefined)? undefined : weak_ref_create(_value));
}