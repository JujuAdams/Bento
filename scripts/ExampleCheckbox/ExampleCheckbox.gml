// Feather disable all

global.checkbox1 = true;
global.checkbox2 = false;

function ExampleCheckbox()
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
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Checkboxes" });
                BentoCreate(oBentoExBackButton, { func: ExampleHomePage });
            }
            
            BentoCreate(oBentoExText, {
                text: "Checkboxes are implemented as buttons that when clicked toggle state. They're useful for options menus especially.",
            });
            
            with(BentoCreateBlank())
            {
                BentoLayoutList(BENTO_AXIS_Y, 0.5, 0.5);
                BentoLayoutSetGutter(15, 15);
                
                with(BentoCreate(oBentoExCheckbox, {
                    text: "Checkbox 1",
                    reference: BentoRef(global, "checkbox1"),
                }))
                {
                    BentoHover();
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_NORMAL);
                }
                
                with(BentoCreate(oBentoExCheckbox, {
                    text: "Checkbox 2",
                    reference: BentoRef(global, "checkbox2"),
                }))
                {
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_NORMAL);
                }
            }
        }
    }
}

function ExampleCheckboxJSON()
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
                        resize: [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                    },
                    children: [
                        {
                            object: oBentoExText,
                            vars: {
                                text: "Checkbox Example",
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
                        text: "Checkboxes are implemented as buttons that when clicked toggle state. They're useful for options menus especially.",
                    },
                },
                {
                    object: oBentoExParent,
                    layout: {
                        list: [BENTO_AXIS_Y, 0.5, 0.5],
                        gutter: 15,
                    },
                    children: [
                        {
                            hover: true,
                            object: oBentoExCheckbox,
                            vars: {
                                text: "Checkbox 1",
                                reference: BentoRef(global, "checkbox1"),
                            },
                            layout: {
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_NORMAL],
                            },
                        },
                        {
                            object: oBentoExCheckbox,
                            vars: {
                                text: "Checkbox 2",
                                reference: BentoRef(global, "checkbox2"),
                            },
                            layout: {
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_NORMAL],
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