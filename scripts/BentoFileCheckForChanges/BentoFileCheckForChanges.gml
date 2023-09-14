/// Returns <true> if an external file has received changes, otherwise returns <false>.
/// 
/// @param path

function BentoFileCheckForChanges(_path)
{
    return __BentoFileEnsure(_path).__CheckForChanges();
}