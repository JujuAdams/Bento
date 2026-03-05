/// @param skinName

function BentoGetSkin(_skinName)
{
    static _skinDict = __BentoSystem().__skinDict;
    
    return _skinDict[$ _skinName];
}