// Feather disable all

/// @param testData
/// @param [element=self]

function BentoDnDSetItemData(_testData, _element = self)
{
    with(__BentoGetVars(_element))
    {
        __dndItemData = _testData;
    }
}