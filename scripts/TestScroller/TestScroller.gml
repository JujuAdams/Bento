// Feather disable all

function TestScroller()
{
    var _json = [
        {
            object: oBentoExSprite,
            offset: [30, 30],
            layout: {
                list: ["y", 0, 0],
                padding: 10,
                gutter: 10,
            },
            children: [
                {
                    object: oBentoExStepperNumbers,
                },
                {
                    object: oBentoExStepperNumbers,
                },
            ],
        },
    ];
    
    gridElement = BentoCreateFromJSON(_json, undefined, BentoGetRoot());
}