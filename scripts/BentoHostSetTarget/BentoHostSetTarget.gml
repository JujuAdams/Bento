/// Sets the currently targeted host. All further layer- and UI-related calls will be use this
/// host as the scope.
/// 
/// This function is provided for complex situations where maintaining multiple independent UI
/// stacks is necessary. You probably don't need this function.

function BentoHostSetTarget(_host)
{
    static _global = __BentoGlobal();
    _global.__currentHost = _host;
}