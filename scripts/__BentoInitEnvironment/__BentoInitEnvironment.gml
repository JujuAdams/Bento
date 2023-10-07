function __BentoInitEnvironment()
{
    with(__BentoGlobal().__bentoScriptEnv)
    {
        interface.exposeConstant("global", __BentoGlobal().__exposedGlobalStruct,
                                 "BENTO_BEHAVIOR_DRAW_ONLY",   BENTO_BEHAVIOR_DRAW_ONLY,
                                 "BENTO_BEHAVIOR_PASSTHROUGH", BENTO_BEHAVIOR_PASSTHROUGH,
                                 "BENTO_BEHAVIOR_MODAL",       BENTO_BEHAVIOR_MODAL,
                                 "BENTO_BEHAVIOR_BLOCKING",    BENTO_BEHAVIOR_BLOCKING,
                                 "BENTO_VERSION",              BENTO_VERSION,
                                 "BENTO_DATE",                 BENTO_DATE,);
    }
    
    BentoAddFunction("LayerIsTop",         BentoLayerCurrentIsTop);
    BentoAddFunction("LayerDelete",        BentoLayerDelete);
    BentoAddFunction("LayerDeleteCurrent", function() { BentoLayerDelete(); });
    BentoAddFunction("LayerSustain",       BentoLayerSustain);
    
    BentoAddFunction("DebugShowPointer",    BentoDebugShowPointer);
    BentoAddFunction("DebugShowSkeleton",   BentoDebugShowSkeleton);
    BentoAddFunction("DebugRelaxedSprites", BentoDebugRelaxedSprites);
    BentoAddFunction("DebugShowNavigation", BentoDebugShowNavigation);
    BentoAddFunction("DebugBreakpoint",     BentoDebugBreakpoint);
    BentoAddFunction("DebugLog",            __BentoTrace);
    
    BentoAddFunction("FileExecute", BentoFileExecute);
    
    BentoAddFunction("Super",         BentoCallInherited);
    BentoAddFunction("CallInherited", BentoCallInherited);
    
    BentoAddFunction("ForceClick", function(_buttonName)
    {
        __BentoInputButtonClick(__BentoContextStackTop(), _buttonName);
    });
    
    BentoAddFunction("GetPointerX",      BentoPointerGetX);
    BentoAddFunction("GetPointerY",      BentoPointerGetY);
    BentoAddFunction("GetPointerStartX", BentoPointerGetStartX);
    BentoAddFunction("GetPointerStartY", BentoPointerGetStartY);
    
    BentoAddFunction("Replace",     BentoReplace);
    BentoAddFunction("Find",        BentoFind);
    BentoAddFunction("FindRelaxed", BentoFindRelaxed);
}