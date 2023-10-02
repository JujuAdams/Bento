function __BentoInitEnvironment()
{
    with(__BentoGlobal().__bentoScriptEnv)
    {
        renameKeyword(
            "//", "div",
            "--", "//",
            "let", "var",
            "fun", "fn",
            "use", "build",
        );
        
        addKeyword(
            "&&",  __BENTOSCRIPT_TOKEN.AND,
            "||",  __BENTOSCRIPT_TOKEN.OR,
            "mod", __BENTOSCRIPT_TOKEN.REMAINDER,
            "not", __BENTOSCRIPT_TOKEN.NOT,
        );
        
        interface.exposeConstant("global",               __BentoGlobal().__exposedGlobalStruct,
                                 "BEHAVIOR_DRAW_ONLY",   BENTO_BEHAVIOR_DRAW_ONLY,
                                 "BEHAVIOR_PASSTHROUGH", BENTO_BEHAVIOR_PASSTHROUGH,
                                 "BEHAVIOR_MODAL",       BENTO_BEHAVIOR_MODAL,
                                 "BEHAVIOR_BLOCKING",    BENTO_BEHAVIOR_BLOCKING,
                                 "BENTO_VERSION",        BENTO_VERSION,
                                 "BENTO_DATE",           BENTO_DATE,);
    }
    
    BentoAddFunction("LayerIsTop", BentoLayerCurrentIsTop);
    
    BentoAddFunction("LayerDelete", BentoLayerDelete);
    
    BentoAddFunction("LayerDeleteCurrent", function()
    {
        BentoLayerDelete();
    });
    
    BentoAddFunction("LayerSustain", function(_name)
    {
        return BentoHostCurrent().__LayerSustain(_name);
    });
    
    BentoAddFunction("BentoLayer", function()
    {
        BentoOpen(new __BentoClassLayer());
        return method(undefined, BentoClose);
    });
    
    BentoAddFunction("BentoTooltipLayer", function()
    {
        var _layer = new __BentoClassLayer();
        
        BentoOpen(_layer)
        with(_layer)
        {
            Set("behavior", BENTO_BEHAVIOR_PASSTHROUGH);
            Set("volatile", true);
        }
        
        return method(undefined, BentoClose);
    });
    
    BentoAddFunction("DebugShowPointer", BentoDebugShowPointer);
    BentoAddFunction("DebugShowSkeleton", BentoDebugShowSkeleton);
    BentoAddFunction("DebugRelaxedSprites", BentoDebugRelaxedSprites);
    BentoAddFunction("DebugBreakpoint", BentoDebugBreakpoint);
    BentoAddFunction("DebugLog", __BentoTrace);
    
    BentoAddFunction("FileExecute", BentoFileExecute);
    
    BentoAddFunction("Super", BentoCallInherited);
    BentoAddFunction("CallInherited", BentoCallInherited);
    
    BentoAddFunction("ForceClick", function(_buttonName)
    {
        __BentoInputButtonClick(__BentoContextStackTop(), _buttonName);
    });
    
    BentoAddFunction("GetPointerX",      BentoPointerGetX);
    BentoAddFunction("GetPointerY",      BentoPointerGetY);
    BentoAddFunction("GetPointerStartX", BentoPointerGetStartX);
    BentoAddFunction("GetPointerStartY", BentoPointerGetStartY);
    
    BentoAddFunction("BoxReplace", BentoReplace);
    
    BentoAddFunction("BoxFind", function(_identifier)
    {
        return BentoBoxFind(_identifier);
    });
    
    BentoAddFunction("BoxFindRelaxed", function(_identifier)
    {
        return BentoBoxFindRelaxed(_identifier);
    });
}