// Feather disable all

function TestTextbox()
{
    var _json = [
        {
            object: oExampleTextbox,
            layout: {
                offset: [30, 30],
            },
        },
        {
            object: oExampleButton,
            layout: {
                offset: [30, 130],
            },
        },
    ];
    
    textboxElement = GuiCreateFromJSON(_json, GuiGetRoot());
}