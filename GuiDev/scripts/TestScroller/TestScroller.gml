// Feather disable all

function TestScroller()
{
    var _json = [
        {
            object: oBentoList,
            layout: {
                offset: [30, 30],
                padding: 10,
                gutter: 10,
            },
            children: [
                {
                    object: oExampleScroller,
                },
                {
                    object: oExampleScroller,
                },
            ],
        },
    ];
    
    gridElement = BentoCreateFromJSON(_json, BentoGetRoot());
}