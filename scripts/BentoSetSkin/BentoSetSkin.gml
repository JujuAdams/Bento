/// @param skinName
/// @param function

function BentoSetSkin(_skinName, _function)
{
    static _skinDict = __BentoSystem().__skinDict;
    
    _skinDict[$ _skinName] = method(undefined, _function);
}