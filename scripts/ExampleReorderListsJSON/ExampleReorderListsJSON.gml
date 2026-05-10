// Feather disable all

function ExampleReorderListsJSON()
{
    with(oMain)
    {
        var _json = {
            object: oBentoExSpacer,
            layout: {
                padding: 40,
                gutter: 35,
                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                list: [BENTO_AXIS_Y, 0.5, 0],
            },
            children: [
                {
                    object: oBentoExSpacer,
                    layout: {
                        list: [BENTO_AXIS_X, 0.5, 0.5],
                        gutter: 35,
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                    },
                    children: [
                        {
                            object: oBentoExText,
                            vars: {
                                text: "Reorder Lists",
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
                    object: oBentoExText,
                    vars: {
                        text: "This example shows how to reorder lists dynamically at runtime using Bento's child functions.",
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: "Order Alphabetically",
                        func: function()
                        {
                            var _listElement = BentoNameFind("list");
                            
                            var _array = BentoGetChildArray(_listElement);
                            array_sort(_array, function(_a, _b)
                            {
                                return (_a.text < _b.text)? -1 : 1;
                            });
                            
                            BentoSetChildArray(_array, _listElement);
                        }
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: "Randomize Order",
                        func: function()
                        {
                            var _listElement = BentoNameFind("list");
                            var _array = BentoGetChildArray(_listElement);
                            array_shuffle_ext(_array);
                            BentoSetChildArray(_array, _listElement);
                        }
                    },
                },
                {
                    object: oBentoExText,
                    vars: {
                        text: "Click any of the following buttons to send the button to the top of the list.",
                    },
                },
                {
                    object: oBentoExSpacer,
                    name: "list",
                    layout: {
                        list: [BENTO_AXIS_Y, 0.5, 0],
                        resize: [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                        gutter: 20,
                    },
                    children: [
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Apple",
                                func: function()
                                {
                                    BentoSetChildIndex(0);
                                }
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Banana",
                                func: function()
                                {
                                    BentoSetChildIndex(0);
                                }
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Cantaloupe",
                                func: function()
                                {
                                    BentoSetChildIndex(0);
                                }
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Date",
                                func: function()
                                {
                                    BentoSetChildIndex(0);
                                }
                            },
                        },
                        {
                            object: oBentoExButton,
                            vars: {
                                text: "Elderberry",
                                func: function()
                                {
                                    BentoSetChildIndex(0);
                                }
                            },
                        },
                    ],
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoLayerGetRoot());
    }
}