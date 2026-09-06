/// @param templateName
/// @param [element=self]

function BentoTemplateApply(_templateName, _element = self)
{
    static _templateDict = __BentoSystem().__templateDict;
    
    with(_element)
    {
        var _method = _templateDict[$ _templateName];
        if (is_callable(_method))
        {
            _method(_templateName);
        }
    }
}