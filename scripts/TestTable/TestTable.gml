function TestTable()
{
    var _padding = 20;
    
    with(oMain)
    {
        BentoDestroy(mainElement);
        
        mainElement = BentoCreate(oBentoExSpacer, undefined, BentoLayerGetRoot());
        with(mainElement)
        {
            BentoLayoutSetPadding(_padding);
            BentoLayoutSetGutter(_padding, _padding);
            BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
            BentoLayoutTable(2); //TODO - Add alignment options
            
            BentoCreate(oBentoExText, { text: "Label" });
            BentoCreate(oBentoExButton, { text: "Button 1" });
            
            BentoCreate(oBentoExText, { text: "Label 2" });
            BentoCreate(oBentoExButton, { text: "Button" });
            
            BentoForeachChild(undefined, function()
            {
                BentoLayoutSetAnchor(0.5, 0.5);
            });
        }
    }
}