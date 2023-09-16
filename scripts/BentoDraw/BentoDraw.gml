/// Draws Bento boxes and handles animation (if any has been set up)

function BentoDraw()
{
    static _global = __BentoGlobal();
    return _global.__currentHost.__Draw();
}