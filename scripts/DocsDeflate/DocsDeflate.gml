// Feather disable all

function DocsDeflate()
{
    screenshotName = "DocsDeflate.png";
    
    with(BentoLayerGetRoot()) //Step inside the root element for the layer
    {
        BentoLayoutList(BENTO_AXIS_Y, 0.5, 0.5);
        BentoLayoutSetGutter(10, 10);
        
        with(BentoCreate(oDocsElement)) //Create a new element
        {
            BentoLayoutSetSize(300, 150);
            BentoLayoutList(BENTO_AXIS_X, 0, 0);
            BentoLayoutSetPadding(6);
            
            with(BentoCreate(oDocsElement)) //Create a new element
            {
                image_blend = c_red;
                BentoLayoutSetSize(50, 50); //Set the size to exactly 50x50
            }
            
            with(BentoCreate(oDocsElement)) //Create a new element
            {
                image_blend = c_lime;
                BentoLayoutSetSize(50, 50); //Set the size to exactly 50x50
            }
            
            with(BentoCreate(oDocsElement)) //Create a new element
            {
                image_blend = c_blue;
                BentoLayoutSetSize(50, 50); //Set the size to exactly 50x50
            }
        }
        
        with(BentoCreate(oDocsElement))
        {
            BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_NORMAL);
            
            BentoLayoutSetSize(300, 150);
            BentoLayoutList(BENTO_AXIS_X, 0, 0);
            BentoLayoutSetPadding(6);
            
            with(BentoCreate(oDocsElement))
            {
                image_blend = c_red;
                BentoLayoutSetSize(50, 50);
            }
            
            with(BentoCreate(oDocsElement))
            {
                image_blend = c_lime;
                BentoLayoutSetSize(50, 50);
            }
            
            with(BentoCreate(oDocsElement))
            {
                image_blend = c_blue;
                BentoLayoutSetSize(50, 50);
            }
        }
        
        with(BentoCreate(oDocsElement))
        {
            BentoLayoutSetResize(BENTO_RESIZE_NORMAL, BENTO_RESIZE_DEFLATE);
            
            BentoLayoutSetSize(300, 150);
            BentoLayoutList(BENTO_AXIS_X, 0.5, 0);
            BentoLayoutSetPadding(6);
            
            with(BentoCreate(oDocsElement))
            {
                image_blend = c_red;
                BentoLayoutSetSize(50, 50);
            }
            
            with(BentoCreate(oDocsElement))
            {
                image_blend = c_lime;
                BentoLayoutSetSize(50, 50);
            }
            
            with(BentoCreate(oDocsElement))
            {
                image_blend = c_blue;
                BentoLayoutSetSize(50, 50);
            }
        }
    }
}