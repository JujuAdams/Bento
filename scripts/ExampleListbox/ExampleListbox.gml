// Feather disable all

function ExampleListbox()
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
                
                BentoCreate(oBentoExText, { text: "Listbox", font: fntBentoExCandyBeansBig });
                BentoCreate(oBentoExBackButton, { func: ExampleHomePageJSON });
            }
            
            with(BentoCreate(oBentoExListbox))
            {
                BentoLayoutSetPadding(10);
                BentoLayoutSetGutter(10, 10);
                BentoLayoutSetMaxSize(200, 295);
                BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
                
                var _index = 0;
                repeat(15)
                {
                    with(BentoCreate(oBentoExButton, { text: string(_index) }))
                    {
                        if (_index == 0) BentoHover();
                        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, undefined);
                    }
                    
                    ++_index;
                }
            }
        }
    }
}

function ExampleListboxJSON()
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
                                text: "Listbox",
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
                    object: oBentoExListbox,
                    layout: {
                        maxSize: [200, 295],
                        resize:  [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                        padding: 10,
                        gutter:  10,
                    },
                    children: function(_metadata) {
                        //Create identical copies of references to the same struct
                        //This is purely for demonstration purposes; real code would do this differently
                        return array_create_ext(_metadata.count, function(_index)
                        {
                            return {
                                object: oBentoExButton,
                                hover: (_index == 0),
                                vars: {
                                    text: string(_index),
                                },
                                layout: {
                                    resize: [BENTO_RESIZE_INFLATE, undefined],
                                }
                            };
                        });
                    },
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, { count: 15 }, BentoLayerGetRoot());
    }
}