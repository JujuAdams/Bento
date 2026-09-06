// Feather disable all

function ExampleCarry()
{
    with(oMain)
    {
        BentoDestroy(mainElement);
        
        mainElement = BentoCreateBlank(BentoLayerGetRoot());
        with(mainElement)
        {
            BentoLayoutSetPadding(40);
            BentoLayoutSetGutter(35, 35);
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
            BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
            
            with(BentoCreateBlank())
            {
                BentoLayoutSetGutter(35, 35);
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_X, 0.5, 0);
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Carry (Drag & Drop)" });
                BentoCreate(oBentoExBackButton, { func: ExampleHomePage });
                BentoSetNavigationWrap(true, true, BENTO_PREV_ELEMENT);
            }
            
            with(BentoCreateBlank())
            {
                BentoLayoutSetPadding(10);
                BentoLayoutSetGutter(15, 15);
                BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
                
                BentoCreate(oBentoExText, {
                    text: "Items",
                });
                
                with(BentoCreate(oBentoExScrollingListWithBar))
                {
                    BentoLayoutSetPadding(10);
                    BentoLayoutSetGutter(15, 15);
                    BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
                    BentoLayoutSetMaxSize(infinity, 300);
                    
                    BentoCreate(oBentoExCarryItem, { text: "Sock" });
                    BentoCreate(oBentoExCarryItem, { text: "Hat" });
                    BentoCreate(oBentoExCarryItem, { text: "Hat" });
                    BentoCreate(oBentoExCarryItem, { text: "Kneepad" });
                    BentoCreate(oBentoExCarryItem, { text: "Sock" });
                    BentoCreate(oBentoExCarryItem, { text: "Hat" });
                    BentoCreate(oBentoExCarryItem, { text: "Hat" });
                    BentoCreate(oBentoExCarryItem, { text: "Kneepad" });
                }
            }
            
            with(BentoCreateBlank())
            {
                BentoLayoutSetPadding(10);
                BentoLayoutSetGutter(15, 15);
                BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
                
                BentoCreate(oBentoExText, {
                    text: "Targets",
                });
                
                with(BentoCreate(oBentoExFrame, { fill: false }))
                {
                    BentoLayoutSetPadding(10);
                    BentoLayoutSetGutter(15, 15);
                    BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
                    BentoLayoutGrid(2, 2);
                    
                    BentoCreate(oBentoExCarryTarget, { text: "Sock" });
                    BentoCreate(oBentoExCarryTarget, { text: "Sock" });
                    BentoCreate(oBentoExCarryTarget, { text: "Hat" });
                    BentoCreate(oBentoExCarryTarget, { text: "Kneepad" });
                }
            }
        }
    }
}

function ExampleCarryJSON()
{
    with(oMain)
    {
        var _json = {
            object: oBentoExParent,
            layout: {
                padding: 40,
                gutter: 35,
                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                list: [BENTO_AXIS_Y, 0.5, 0],
            },
            children: [
                {
                    object: oBentoExParent,
                    layout: {
                        list: [BENTO_AXIS_X, 0.5, 0.5],
                        gutter: 35,
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                    },
                    children: [
                        {
                            object: oBentoExText,
                            vars: {
                                text: "Carry (Drag & Drop)",
                                font: fntBentoExCandyBeansBig,
                            },
                        },
                        {
                            object: oBentoExBackButton,
                            vars: {
                                func: ExampleHomePage,
                            },
                        },
                    ],
                },
                {
                    object: oBentoExParent,
                    layout: {
                        list: [BENTO_AXIS_Y, 0.5, 0],
                        resize: [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                        gutter: 10,
                        padding: 15,
                    },
                    children: [
                        {
                            object: oBentoExText,
                            vars: {
                                text: "Items",
                            },
                        },
                        {
                            object: oBentoExScrollingListWithBar,
                            layout: {
                                resize: [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                                maxSize: [infinity, 300],
                                gutter: 10,
                                padding: 15,
                            },
                            children: [
                                {
                                    object: oBentoExCarryItem,
                                    vars: {
                                        text: "Sock",
                                    },
                                },
                                {
                                    object: oBentoExCarryItem,
                                    vars: {
                                        text: "Hat",
                                    },
                                },
                                {
                                    object: oBentoExCarryItem,
                                    vars: {
                                        text: "Hat",
                                    },
                                },
                                {
                                    object: oBentoExCarryItem,
                                    vars: {
                                        text: "Kneepad",
                                    },
                                },
                                {
                                    object: oBentoExCarryItem,
                                    vars: {
                                        text: "Sock",
                                    },
                                },
                                {
                                    object: oBentoExCarryItem,
                                    vars: {
                                        text: "Hat",
                                    },
                                },
                                {
                                    object: oBentoExCarryItem,
                                    vars: {
                                        text: "Hat",
                                    },
                                },
                                {
                                    object: oBentoExCarryItem,
                                    vars: {
                                        text: "Kneepad",
                                    },
                                },
                            ],
                        },
                    ],
                },
                {
                    object: oBentoExParent,
                    layout: {
                        list: [BENTO_AXIS_Y, 0.5, 0],
                        resize: [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                        gutter: 10,
                        padding: 15,
                    },
                    children: [
                        {
                            object: oBentoExText,
                            vars: {
                                text: "Targets",
                            },
                        },
                        {
                            object: oBentoExFrame,
                            vars: {
                                fill: false,
                            },
                            layout: {
                                grid: [2, 2],
                                resize: [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                                gutter: 10,
                                padding: 15,
                            },
                            children: [
                                {
                                    object: oBentoExCarryTarget,
                                    vars: {
                                        text: "Sock",
                                    },
                                },
                                {
                                    object: oBentoExCarryTarget,
                                    vars: {
                                        text: "Sock",
                                    },
                                },
                                {
                                    object: oBentoExCarryTarget,
                                    vars: {
                                        text: "Hat",
                                    },
                                },
                                {
                                    object: oBentoExCarryTarget,
                                    vars: {
                                        text: "Kneepad",
                                    },
                                },
                            ],
                        },
                    ],
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoLayerGetRoot());
    }
}