/// Executes an external file as BentoScript.
/// 
/// @param path

function BentoFileExecute(_path)
{
    return __BentoFileEnsure(_path).__Execute();
}