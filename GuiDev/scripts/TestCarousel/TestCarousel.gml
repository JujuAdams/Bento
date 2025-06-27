// Feather disable all

function TestCarousel()
{
    var _json = [
        {
            object: oBentoList,
            layout: {
                offset: [-30, -30],
                alignSelf: [1, 1],
                padding: 10,
                gutter: 10,
            },
            children: [
                {
                    object: oExampleCarousel,
                    vars: {
                        optionArray: [
                            "Value 0",
                            "Value 1",
                            "Value 2",
                            "Value 3",
                        ],
                    },
                },
                {
                    object: oExampleCarousel,
                    vars: {
                        optionArray: [
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
    
    gridElement = BentoCreateFromJSON(_json, BentoGetRoot());
}