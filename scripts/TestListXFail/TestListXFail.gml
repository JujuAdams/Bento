function TestListXFail()
{
    var _padding = 10;
    
    with(oMain)
    {
        BentoDestroy(mainElement);
        
        mainElement = BentoCreateBlank(BentoLayerGetRoot());
        with(mainElement)
        {
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
            BentoLayoutList(BENTO_AXIS_X, 0.5, 0.5);
            BentoLayoutSetPadding(_padding);
            BentoLayoutSetGutter(_padding);
            
            with(BentoCreateBlank())
            {
                BentoLayoutSetResize(BENTO_RESIZE_NORMAL, BENTO_RESIZE_INFLATE);
                BentoLayoutSetSize(0.3*display_get_gui_width(), undefined);
                BentoLayoutList(BENTO_AXIS_Y, 0.5, 0.5);
                BentoLayoutSetPadding(_padding);
                BentoLayoutSetGutter(_padding, _padding);
                
                with(BentoCreateBlank())
                {
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                    BentoLayoutList(BENTO_AXIS_X, 0.5, 0.5);
                    BentoLayoutSetGutter(_padding);
                    
                    with(BentoCreate(oBentoExButton))
                    {
                        BentoLayoutSetSize(100);
                        BentoLayoutSetResize(BENTO_RESIZE_INFLATE);
                    }
                    
                    with(BentoCreate(oBentoExButton))
                    {
                        BentoLayoutSetSize(100);
                        BentoLayoutSetResize(BENTO_RESIZE_INFLATE);
                    }
                }
                
                with(BentoCreate(oBentoExButton))
                {
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                }
            }
            
            with(BentoCreate(oBentoExButton))
            {
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
            }
        }
    }
}