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
            BentoLayoutSetGutter(_padding);
            BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
            BentoLayoutTable(2);
            
            BentoCreate(oBentoExText, { text: "Label" });
            BentoCreate(oBentoExButton, { text: "Button" });
        }
    }
}