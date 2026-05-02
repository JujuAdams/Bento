// Feather disable all

function TestStepperStrings()
{
    var _json = [
        {
            object: oBentoExSprite,
            offset: [-30, -30],
            layout: {
                list: ["y", 0, 0],
                anchor: [1, 1],
                padding: 10,
                gutter: 10,
            },
            children: [
                {
                    object: oBentoExStepperStrings,
                    vars: {
                        stringArray: [
                            "Value 0",
                            "Value 1",
                            "Value 2",
                            "Value 3",
                        ],
                    },
                },
                {
                    object: oBentoExStepperStrings,
                    vars: {
                        stringArray: [
                            "Value 0",
                            "Value 1",
                            "Value 2",
                            "Value 3",
                        ],
                    },
                },
            ],
        },
    ];
    
    gridElement = BentoCreateFromJSON(_json, undefined, BentoLayerGetRoot());
}