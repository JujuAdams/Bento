function TestListSetPosition()
{
    with(oMain)
    {
        BentoLayerClear("example layer");
        with(BentoCreateBlank(BentoGetRoot()))
        {
            BentoLayoutList(BENTO_AXIS_Y, 0, 0);
            BentoSetPosition(100, 100);
            
            BentoCreate(oBentoExButton, { text: "Button A" });
            BentoCreate(oBentoExButton, { text: "Button B" });
            BentoCreate(oBentoExButton, { text: "Button C" });
        }
    }
}