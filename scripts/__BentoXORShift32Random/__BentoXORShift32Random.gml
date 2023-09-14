function __BentoXORShift32Random(_value)
{
    return _value * abs(__BentoXORShift32()) / (real(0x7FFFFFFFFFFFFFFF) + 1.0);
}