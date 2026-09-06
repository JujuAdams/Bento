/// @param skinName
/// @param [element=self]

function BentoApplySkin(_skinName, _element = self)
{
    static _skinDict = __BentoSystem().__skinDict;
    
    with(_element)
    {
        var _method = _skinDict[$ _skinName];
        if (is_callable(_method))
        {
            _method(_skinName);
        }
    }
}