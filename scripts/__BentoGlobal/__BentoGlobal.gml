function __BentoGlobal()
{
    __BentoInit();
    
    static _struct = {
        __bentoScriptEnv: undefined, //Set in __BentoInit()
        __exposedGlobalStruct: {},
        __elementCount: 0,
        
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
        
        __currentEvent:       undefined,
        __currentEventScope:  undefined,
        __currentEventParam0: undefined,
        __currentEventParam1: undefined,
        
        __nullEvent: undefined,
        
        __debug: {
            __showPointer:    false,
            __showSkeleton:   false,
            __relaxedSprites: false,
        }
    };
    
    return _struct;
}