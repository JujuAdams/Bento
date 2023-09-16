function __BentoGlobal()
{
    __BentoInit();
    
    static _struct = {
        __bentoScriptEnv: undefined, //Set in __BentoInit()
        __exposedGlobalStruct: {},
        
        __currentHost: undefined,
        __hostArray:   [],
        
        __fileDirectory: "",
        __fileDict:  {},
        __fileArray: [],
        
        __stringDict:  {},
        __stringArray: [],
        
        __surfaceArray: [],
        
        __layerStack:          [undefined],
        __contextStack:        [undefined],
        __createReplaceTarget: undefined,
        
        __currentCallback:       undefined,
        __currentCallbackScope:  undefined,
        __currentCallbackParam0: undefined,
        __currentCallbackParam1: undefined,
        
        __nullCallback: undefined,
        
        __debug: {
            __showPointer:    false,
            __showSkeleton:   false,
            __relaxedSprites: false,
        }
    };
    
    return _struct;
}