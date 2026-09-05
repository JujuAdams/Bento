// Feather disable all

global.textboxExample = "";

function ExampleTextbox()
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
                BentoLayoutList(BENTO_AXIS_X, 0.5, 0.5);
                
                BentoCreate(oBentoExText, { text: "Textbox", font: fntBentoExCandyBeansBig });
                BentoCreate(oBentoExBackButton, { func: ExampleHomePageJSON });
            }
            
            with(BentoCreate(oBentoExTextbox, { reference: BentoRef(global, "textboxExample"), emptyText: "Enter text here!" }))
            {
                BentoHover();
            }
            
            BentoCreate(oBentoExTextDynamic, { text: function()
            {
                return $"global.textboxExample = \"{global.textboxExample}\"";
            }});
        }
    }
}

function ExampleTextboxJSON()
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
                                text: "Textbox",
                                font: fntBentoExCandyBeansBig,
                            },
                        },
                        {
                            object: oBentoExBackButton,
                            vars: {
                                func: ExampleHomePageJSON,
                            },
                        },
                    ],
                },
                {
                    hover: true,
                    object: oBentoExTextbox,
                    vars: {
                        reference: BentoRef(global, "textboxExample"),
                        emptyText: "Enter text here!",
                    },
                },
                {
                    object: oBentoExTextDynamic,
                    vars: {
                        text: function()
                        {
                            return $"global.textboxExample = \"{global.textboxExample}\"";
                        }
                    },
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoLayerGetRoot());
    }
}