// Feather disable all

function TestTextbox()
{
    var _json = [
        {
            object: oExampleTextbox,
            offset: [30, 30],
        },
        {
            object: oExampleButton,
            offset: [30, 130],
            layout: {
                size: [100, 100],
            },
        },
    ];
    
    textboxElement = BentoCreateFromJSON(_json, undefined, BentoGetRoot());
}