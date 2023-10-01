/// Adds an asset to BentScript, allowing it to be used in external UI files.
/// 
/// @param assetName

function BentoAddAsset(_name)
{
    __BentoGlobal().__bentoScriptEnv.interface.exposeAsset(_name);
}