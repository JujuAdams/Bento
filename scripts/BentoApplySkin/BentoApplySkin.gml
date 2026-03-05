/// @param skinName
/// @param [element=self]

function BentoApplySkin(_skinName, _element = self)
{
    with(_element)
    {
        var _method = BentoGetSkin(_skinName);
        if (is_callable(_method))
        {
            _method(_skinName);
        }
    }
}