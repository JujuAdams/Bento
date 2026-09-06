/// @param templateName
/// @param function

function BentoTemplateCreate(_templateName, _function)
{
    static _templateDict = __BentoSystem().__templateDict;
    
    _templateDict[$ _templateName] = method(undefined, _function);
}