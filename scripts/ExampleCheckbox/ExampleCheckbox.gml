// Feather disable all

global.checkbox1 = true;
global.checkbox2 = false;

function ExampleCheckbox()
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
                    object: oBentoExSpacer,
                    layout: {
                        list: [BENTO_AXIS_Y, 0.5, 0.5],
                        gutter: 15,
                    },
                    children: [
                        {
                            select: true,
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
                            select: true,
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
        mainElement = BentoCreateFromJSON(_json, undefined, BentoGetRoot());
    }
}