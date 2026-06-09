// Feather disable all

function ExampleContextMenuJSON()
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
                                text: "Context Menu",
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
                    object: oBentoExButton,
                    vars: {
                        text: "Click Me!",
                        func: function()
                        {
                            //Creating a context menu will instantly set the cursor position so we should cache that first
                            var _x = BentoCursorGetX();
                            var _y = BentoCursorGetY();
                            
                            with(BentoCreate(oBentoExContextMenu, undefined, BentoLayerGetRoot()))
                            {
                                BentoSetOffset(_x, _y);
                                
                                BentoCreate(oBentoExButton, { text: "Button 1" });
                                BentoCreate(oBentoExButton, { text: "Button 2" });
                                BentoCreate(oBentoExButton, { text: "Close", func: function() { BentoDestroy(BentoFocusGetTop()) } });
                            }
                        },
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: "Other Button",
                    },
                },
                {
                    object: oBentoExButton,
                    vars: {
                        text: "Other Button",
                    },
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoLayerGetRoot());
    }
}