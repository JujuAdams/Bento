// Feather disable all

function ExampleDragAndDrop()
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
                                text: "Drag & Drop",
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
                    object: oBentoExSpacer,
                    layout: {
                        grid: [2, 2],
                        resize: [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                        gutter: 10,
                    },
                    children: [
                        {
                            object: oBentoExDragAndDropItem,
                            vars: {
                                text: "Sock",
                            },
                        },
                        {
                            object: oBentoExDragAndDropItem,
                            vars: {
                                text: "Hat",
                            },
                        },
                        {
                            object: oBentoExDragAndDropItem,
                            vars: {
                                text: "Hat",
                            },
                        },
                        {
                            object: oBentoExDragAndDropItem,
                            vars: {
                                text: "Kneepad",
                            },
                        },
                    ],
                },
                {
                    object: oBentoExSpacer,
                    layout: {
                        grid: [2, 2],
                        resize: [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                        gutter: 10,
                    },
                    children: [
                        {
                            object: oBentoExDragAndDropTarget,
                            vars: {
                                text: "Sock",
                            },
                        },
                        {
                            object: oBentoExDragAndDropTarget,
                            vars: {
                                text: "Sock",
                            },
                        },
                        {
                            object: oBentoExDragAndDropTarget,
                            vars: {
                                text: "Hat",
                            },
                        },
                        {
                            object: oBentoExDragAndDropTarget,
                            vars: {
                                text: "Kneepad",
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