function TestColumns()
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
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
            BentoLayoutList(BENTO_AXIS_X, 0.5, 0.5);
            
            with(BentoCreate(oBentoExSpacer))
            {
                BentoLayoutSetResize(BENTO_RESIZE_NORMAL, BENTO_RESIZE_INFLATE);
                BentoLayoutSetSize((display_get_gui_width() - _padding * 3) * (1/4), undefined);
                BentoLayoutList(BENTO_AXIS_Y, 0.5, 0.5);
                BentoLayoutSetGutter(undefined, _padding);
                
                with(BentoCreate(oBentoExButton))
                {
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_NORMAL);
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