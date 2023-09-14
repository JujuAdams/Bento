function BentoDebugMessage(_value)
{
    if (BENTO_REPORT_LEVEL > 0)
    {
        __BentoTrace(_value);
    }
}