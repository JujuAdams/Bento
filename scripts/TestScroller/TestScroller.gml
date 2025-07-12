// Feather disable all

function TestScroller()
{
    var _json = [
        {
            object: oBentoSprite,
            offset: [30, 30],
            layout: {
                list: ["y", fa_left, fa_top],
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
    
    gridElement = BentoCreateFromJSON(_json, undefined, BentoGetRoot());
}