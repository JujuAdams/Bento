/// Executes an external UI file.
/// 
/// @param path

function BentoFileExecute(_path)
{
    return __BentoFileEnsure(_path).__Execute();
}