/// Returns <true> if an external file has been changed since the last time it was loaded or
/// executed.
/// 
/// @param path

function BentoFileCheckForChanges(_path)
{
    return __BentoFileEnsure(_path).__CheckForChanges();
}