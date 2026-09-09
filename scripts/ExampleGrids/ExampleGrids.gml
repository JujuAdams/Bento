// Feather disable all

function ExampleGrids()
{
    with(oMain)
    {
        BentoLayerClear("example layer");
        with(BentoCreateBlank(BentoGetRoot()))
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
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Grids" });
                BentoCreate(oBentoExBackButton, { func: ExampleHomePage });
            }
            
            with(BentoCreateBlank())
            {
                BentoLayoutGrid(2, 2);
                BentoLayoutSetGutter(35, 35);
                BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
                
                repeat(4)
                {
                    BentoCreate(oBentoExButton, {
                        text: "Button",
                    });
                }
            }
        }
    }
}

function ExampleGridsJSON()
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
                                text: "Grids",
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
                        grid: [2, 2],
                        resize: [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                        gutter: 10,
                    },
                    children: [
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Button",
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Button",
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Button",
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Button",
                            },
                        },
                    ],
                },
            ],
        };
        
        BentoLayerClear("example layer");
        BentoCreateFromJSON(_json, undefined, BentoLayerGetRoot());
    }
}