// Feather disable all

function DocsListX()
{
    screenshotName = "DocsListX.png";
    
    with(BentoLayerGetRoot()) //Step inside the root element for the layer
    {
        BentoLayoutList(BENTO_AXIS_X, fa_left, fa_top);
        
        with(BentoCreate(oDocsElement)) //Create a new element
        {
            image_blend = c_red;
            BentoLayoutSetSize(100, 100); //Set the size to exactly 50x50
        }
        
        with(BentoCreate(oDocsElement)) //Create a new element
        {
            image_blend = c_lime;
            BentoLayoutSetSize(100, 100); //Set the size to exactly 50x50
        }
        
        with(BentoCreate(oDocsElement)) //Create a new element
        {
            image_blend = c_blue;
            BentoLayoutSetSize(100, 100); //Set the size to exactly 50x50
        }
        
        with(BentoCreate(oDocsElement)) //Create a new element
        {
            image_blend = c_yellow;
            BentoLayoutSetSize(100, 100); //Set the size to exactly 50x50
        }
    }
}