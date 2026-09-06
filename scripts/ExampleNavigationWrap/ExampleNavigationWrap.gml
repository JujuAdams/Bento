// Feather disable all

function ExampleNavigationWrap()
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
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Navigation Wrapping" });
                BentoCreate(oBentoExBackButton, { func: ExampleHomePageJSON });
                BentoSetNavigationWrap(true, true, BENTO_PREV_ELEMENT);
            }
            
            with(BentoCreateBlank())
            {
                BentoLayoutList(BENTO_AXIS_X, 0.5, 0.5);
                BentoLayoutSetGutter(35, 35);
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                
                with(BentoCreateBlank())
                {
                    BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
                    BentoLayoutSetGutter(15, 15);
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                    
                    BentoCreate(oBentoExButton, {
                        text: "Button 1",
                        font: fntBentoExCandyBeansBig,
                    });
                    BentoSetNavigationWrap(true, true, BENTO_PREV_ELEMENT);
                    
                    BentoCreate(oBentoExButton, {
                        text: "Button 2",
                        font: fntBentoExCandyBeansBig,
                    });
                    BentoSetNavigationWrap(true, true, BENTO_PREV_ELEMENT);
                    
                    BentoCreate(oBentoExButton, {
                        text: "Button 3",
                        font: fntBentoExCandyBeansBig,
                    });
                    BentoSetNavigationWrap(true, true, BENTO_PREV_ELEMENT);
                    
                    BentoCreate(oBentoExButton, {
                        text: "Button 4",
                        font: fntBentoExCandyBeansBig,
                    });
                    BentoSetNavigationWrap(true, true, BENTO_PREV_ELEMENT);
                }
                
                with(BentoCreate(oBentoExListbox))
                {
                    BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
                    BentoLayoutSetPadding(15);
                    BentoLayoutSetGutter(15, 15);
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                    BentoLayoutSetMaxSize(infinity, 200);
                    BentoSetNavigationWrap(true, true);
                    
                    BentoCreate(oBentoExButton, {
                        text: "Button 1",
                        font: fntBentoExCandyBeansBig,
                    });
                    BentoSetNavigationWrap(true, true, BENTO_PREV_ELEMENT);
                    
                    BentoCreate(oBentoExButton, {
                        text: "Button 2",
                        font: fntBentoExCandyBeansBig,
                    });
                    BentoSetNavigationWrap(true, true, BENTO_PREV_ELEMENT);
                    
                    BentoCreate(oBentoExButton, {
                        text: "Button 3",
                        font: fntBentoExCandyBeansBig,
                    });
                    BentoSetNavigationWrap(true, true, BENTO_PREV_ELEMENT);
                    
                    BentoCreate(oBentoExButton, {
                        text: "Button 4",
                        font: fntBentoExCandyBeansBig,
                    });
                    BentoSetNavigationWrap(true, true, BENTO_PREV_ELEMENT);
                }
            }
        }
    }
}

function ExampleNavigationWrapJSON()
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
                        gutter: 15,
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                    },
                    children: [
                        {
                            object: oBentoExText,
                            vars: {
                                text: "Navigation Wrapping",
                                font: fntBentoExCandyBeansBig,
                            },
                        },
                        {
                            object: oBentoExBackButton,
                            vars: {
                                func: ExampleHomePageJSON,
                            },
                            onCreate: function()
                            {
                                BentoSetNavigationWrap(true, true);
                            },
                        },
                    ],
                },
                {
                    object: oBentoExParent,
                    layout: {
                        list: [BENTO_AXIS_X, 0.5, 0.5],
                        gutter: 35,
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                    },
                    children: [
                        {
                            object: oBentoExParent,
                            layout: {
                                list: [BENTO_AXIS_Y, 0.5, 0],
                                gutter: 15,
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                            },
                            children: [
                                {
                                    object: oBentoExButton,
                                    vars: {
                                        text: "Button 1",
                                        font: fntBentoExCandyBeansBig,
                                    },
                                    onCreate: function()
                                    {
                                        BentoSetNavigationWrap(true, true);
                                    },
                                },
                                {
                                    object: oBentoExButton,
                                    vars: {
                                        text: "Button 2",
                                        font: fntBentoExCandyBeansBig,
                                    },
                                    onCreate: function()
                                    {
                                        BentoSetNavigationWrap(true, true);
                                    },
                                },
                                {
                                    object: oBentoExButton,
                                    vars: {
                                        text: "Button 3",
                                        font: fntBentoExCandyBeansBig,
                                    },
                                    onCreate: function()
                                    {
                                        BentoSetNavigationWrap(true, true);
                                    },
                                },
                                {
                                    object: oBentoExButton,
                                    vars: {
                                        text: "Button 4",
                                        font: fntBentoExCandyBeansBig,
                                    },
                                    onCreate: function()
                                    {
                                        BentoSetNavigationWrap(true, true);
                                    },
                                },
                            ],
                        },
                        {
                            object: oBentoExListbox,
                            layout: {
                                list: [BENTO_AXIS_Y, 0.5, 0],
                                padding: 15,
                                gutter: 15,
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                                maxSize: [infinity, 200],
                            },
                            onCreate: function()
                            {
                                BentoSetNavigationWrap(true, true);
                            },
                            children: [
                                {
                                    object: oBentoExButton,
                                    vars: {
                                        text: "Button 1",
                                        font: fntBentoExCandyBeansBig,
                                    },
                                    onCreate: function()
                                    {
                                        BentoSetNavigationWrap(true, true);
                                    },
                                },
                                {
                                    object: oBentoExButton,
                                    vars: {
                                        text: "Button 2",
                                        font: fntBentoExCandyBeansBig,
                                    },
                                    onCreate: function()
                                    {
                                        BentoSetNavigationWrap(true, true);
                                    },
                                },
                                {
                                    object: oBentoExButton,
                                    vars: {
                                        text: "Button 3",
                                        font: fntBentoExCandyBeansBig,
                                    },
                                    onCreate: function()
                                    {
                                        BentoSetNavigationWrap(true, true);
                                    },
                                },
                                {
                                    object: oBentoExButton,
                                    vars: {
                                        text: "Button 4",
                                        font: fntBentoExCandyBeansBig,
                                    },
                                    onCreate: function()
                                    {
                                        BentoSetNavigationWrap(true, true);
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