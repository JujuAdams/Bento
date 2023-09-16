/// Returns the Bento box that is currently in scope.

function BentoCurrent()
{
    return __BentoContextStackTop();
}