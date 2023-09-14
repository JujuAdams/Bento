/// Returns the current target host.

function BentoHostCurrent()
{
    static _global = __BentoGlobal();
    return _global.__currentHost;
}