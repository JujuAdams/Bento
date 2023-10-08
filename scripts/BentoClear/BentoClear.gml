/// Destroys all Bento UI elements.

function BentoClear()
{
    static _global = __BentoGlobal();
    return _global.__currentHost.__Clear();
}