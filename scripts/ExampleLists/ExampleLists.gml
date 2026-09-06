// Feather disable all

function ExampleLists()
{
    with(oMain)
    {
        BentoDestroy(mainElement);
        
        mainElement = BentoCreateBlank(BentoLayerGetRoot());
        with(mainElement)
        {
            BentoLayoutSetPaddingExt(40, 40, 40, 40);
            BentoLayoutSetGutter(35, 35);
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
            BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
            
            with(BentoCreateBlank())
            {
                BentoLayoutSetGutter(35, 35);
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_X, 0.5, 0);
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Lists" });
                BentoCreate(oBentoExBackButton, { func: ExampleHomePage });
            }
            
            BentoCreate(oBentoExText, { font: fntBentoExCandyBeans, text: "Lists are a type of \"layout rule\". Layout rules will automatically size and position child elements to fit a particular pattern. Layout rules are mutually exclusive - an element cannot use both list and grid layout rules, for example. For lists, child elements will be arranged in a straight line along either the x- or y-axis." });
            
            BentoCreate(oBentoExText, { font: fntBentoExCandyBeans, text: "The main direction for arranging children in a list is called the \"major axis\". The other axis is the \"minor axis\". Children will be arranged along the major axis. If children are set to INFLATE on the major axis then they will share any extra space. However, if children are set to INFLATE on the minor axis then they will expand to fill their parent on that axis." });
            
            with(BentoCreateBlank())
            {
                BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
                BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutSetGutter(20, 20);
                
                var _data = [["Here is some text that is sufficiently long that it should wrap around.", "Text"], ["More Text", "More Text"], ["Longest Text", "Longest Text"]];
                var _i = 0;
                repeat(array_length(_data))
                {
                    with(BentoCreateBlank())
                    {
                        BentoLayoutList(BENTO_AXIS_X, 0.5, 0.5);
                        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                        
                        with(BentoCreate(oBentoExText, {
                            text: _data[_i][0],
                            font: fntBentoExCandyBeans,
                        }))
                        {
                            BentoLayoutSetMaxSize(200, infinity);
                        }
                        
                        with(BentoCreateBlank())
                        {
                            BentoLayoutSetMinSize(100, 20);
                            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                        }
                        
                        BentoCreate(oBentoExText, {
                            text: _data[_i][1],
                            font: fntBentoExCandyBeans,
                        });
                        
                        with(BentoCreate(oBentoExSprite, {
                            sprite_index: sBentoExLogoSmall,
                        }))
                        {
                            BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
                        }
                    }
                    
                    ++_i;
                }
            }
        }
    }
}

function ExampleListsJSON()
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
                                text: "Lists",
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
                    object: oBentoExText,
                    vars: {
                        text: "Lists are a type of \"layout rule\". Layout rules will automatically size and position child elements to fit a particular pattern. Layout rules are mutually exclusive - an element cannot use both list and grid layout rules, for example. For lists, child elements will be arranged in a straight line along either the x- or y-axis.",
                        font: fntBentoExCandyBeans,
                    },
                },
                {
                    object: oBentoExText,
                    vars: {
                        text: "The main direction for arranging children in a list is called the \"major axis\". The other axis is the \"minor axis\". Children will be arranged along the major axis. If children are set to INFLATE on the major axis then they will share any extra space. However, if children are set to INFLATE on the minor axis then they will expand to fill their parent on that axis.",
                        font: fntBentoExCandyBeans,
                    },
                },
                {
                    object: oBentoExParent,
                    layout: {
                        list: [BENTO_AXIS_Y, 0.5, 0],
                        resize: [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                        gutter: 20,
                    },
                    children: function()
                    {
                        var _data = [["Here is some text that is sufficiently long that it should wrap around.", "Text"], ["More Text", "More Text"], ["Longest Text", "Longest Text"]];
                        
                        var _array = [];
                        
                        var _i = 0;
                        repeat(array_length(_data))
                        {
                            array_push(_array, {
                                object: oBentoExParent,
                                layout: {
                                    list: [BENTO_AXIS_X, 0.5, 0.5],
                                    resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                                },
                                children: [
                                    {
                                        object: oBentoExText,
                                        vars: {
                                            text: _data[_i][0],
                                            font: fntBentoExCandyBeans,
                                        },
                                        layout: {
                                            maxSize: [200, infinity],
                                        },
                                    },
                                    {
                                        object: oBentoExParent,
                                        layout: {
                                            minSize: [100, 20],
                                            resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                                        },
                                    },
                                    {
                                        object: oBentoExText,
                                        vars: {
                                            text: _data[_i][1],
                                            font: fntBentoExCandyBeans,
                                        },
                                    },
                                    {
                                        object: oBentoExSprite,
                                        vars: {
                                            sprite_index: sBentoExLogoSmall,
                                        },
                                        layout: {
                                            resize: [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                                        },
                                    },
                                ],
                            });
                            
                            ++_i;
                        }
                        
                        return _array;
                    },
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoLayerGetRoot());
    }
}