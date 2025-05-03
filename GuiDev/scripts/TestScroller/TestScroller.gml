// Feather disable all

function TestScroller()
{
    var _json = [
        {
            object: oGuiLibList,
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
    
    gridElement = GuiCreateFromJSON(_json, GUI_ROOT);
}