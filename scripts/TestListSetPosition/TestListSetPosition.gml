function TestListSetPosition()
{
    with(oMain)
    {
        BentoDestroy(mainElement);
        
        mainElement = BentoCreateBlank(BentoLayerGetRoot());
        with(mainElement)
        {
            BentoLayoutList(BENTO_AXIS_Y, 0, 0);
            BentoSetPosition(100, 100);
            
            BentoCreate(oBentoExButton, { text: "Button A" });
            BentoCreate(oBentoExButton, { text: "Button B" });
            BentoCreate(oBentoExButton, { text: "Button C" });
        }
    }
}