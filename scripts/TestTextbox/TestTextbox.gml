// Feather disable all

function TestTextbox()
{
    var _json = [
        {
            object: oBentoExTextbox,
            offset: [30, 30],
        },
        {
            object: oBentoExButton,
            offset: [30, 130],
            layout: {
                size: [100, 100],
            },
        },
    ];
    
    textboxElement = BentoCreateFromJSON(_json, undefined, BentoLayerGetRoot());
}