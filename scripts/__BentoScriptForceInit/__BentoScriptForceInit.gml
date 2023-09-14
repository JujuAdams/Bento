//      _             _                                                       
//     |  `.       .'  |                   _                             _    
//     |    \_..._/    |                  | |                           | |   
//    /    _       _    \     |\_/|  __ _ | |_  ___  _ __    ___   __ _ | | __
// `-|    / \     / \    |-'  / __| / _` || __|/ __|| '_ \  / _ \ / _` || |/ /
// --|    | |     | |    |-- | (__ | (_| || |_ \__ \| |_) ||  __/| (_| ||   < 
//  .'\   \_/ _._ \_/   /`.   \___| \__,_| \__||___/| .__/  \___| \__,_||_|\_\
//     `~..______    .~'                       _____| |   by: katsaii         
//               `.  |                        / ._____/ logo: mashmerlow      
//                 `.|                        \_)                             
// 
// BentoScript is a modified version of BentoScript 3.0.0 by Katsaii

//# feather use syntax-errors

#macro __BENTOSCRIPT_VERSION "3.0.1"
#macro __BENTOSCRIPT_DATE    "2023-09-13"

#macro __BentoScript  (__BentoScriptGMLGlobal().__environment)

/// Makes sure that all BentoScript global variables are initialised.
/// Returns `true` if this is the first time this function was called, and
/// `false` otherwise.
///
/// NOTE: This only needs to be called if you are trying to use BentoScript from
///       within a script, or through `gml_pragma`. Otherwise you can just
///       forget this function exists.
///
/// @return {Bool}
function __BentoScriptForceInit() {
    static initialised = false;
    static _global = __BentoScriptGMLGlobal();
    
    if (initialised) return false;
    initialised = true;
    
    if (GM_build_type == "run") global.__bentoScript = _global;
    
    /// @ignore
    _global.__bentoScriptConfig = { };
    // call initialisers
    __BentoScriptInitOperators();
    __BentoScriptInitPresets();
    __BentoScriptInitLexer();
    __BentoScriptInitCodegen();
    __BentoScriptInitEngine();
    
    show_debug_message("Welcome to BentoScript! This is version " + __BENTOSCRIPT_VERSION + ", " + __BENTOSCRIPT_DATE);
    show_debug_message("BentoScript is a modified version of BentoScript 3.0.0 by Katsaii");
    return true;
}

__BentoScriptForceInit();