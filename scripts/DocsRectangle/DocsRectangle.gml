// Feather disable all

function DocsRectangle()
{
    screenshotName = "DocsRectangle.png";
    
    with(BentoLayerGetRoot()) //Step inside the root element for the layer
    {
        with(BentoCreate(oDocsElement))
        {
            image_blend = c_red;
            BentoLayoutSetSize(50, 50);
        }
        
        with(BentoCreate(oDocsElement))
        {
            image_blend = c_lime;
            BentoLayoutSetSize(150, 50);
            BentoSetPosition(0, 50);
        }
        
        with(BentoCreate(oDocsElement))
        {
            image_blend = c_blue;
            BentoLayoutSetSize(50, 100);
            BentoSetPosition(150, 0);
        }
        
        with(BentoCreate(oDocsElement))
        {
            image_blend = c_yellow;
            BentoLayoutSetSize("100% - 200", 100);
            BentoSetPosition(200, 100);
        }
        
        with(BentoCreate(oDocsElement))
        {
            image_blend = c_orange;
            BentoLayoutSetSize(100, 100);
            BentoSetPosition("50% - 50", "50% - 50");
        }
        
        with(BentoCreate(oDocsElement))
        {
            image_blend = c_fuchsia;
            BentoLayoutSetSize("100%", "50% - 50");
            BentoSetPosition(0, "50% + 50");
        }
    }
}