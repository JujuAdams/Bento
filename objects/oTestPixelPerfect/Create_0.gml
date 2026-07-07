// Feather disable all

width  = 310;
height = 170;

gpu_set_tex_filter(false);
surface = -1;

with(BentoLayerGetRoot())
{
    with(BentoCreate(oBentoExRect))
    {
        image_blend = c_red;
        
        BentoLayoutList(BENTO_AXIS_X, 0, 0);
        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
        
        with(BentoCreate(oBentoExRect))
        {
            image_blend = c_lime;
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
        }
        
        with(BentoCreate(oBentoExRect))
        {
            image_blend = c_blue;
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
        }
        
        with(BentoCreate(oBentoExRect))
        {
            image_blend = c_yellow;
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
        }
    }
    
    //BentoLayoutList(BENTO_AXIS_X, 0, 0);
    //BentoLayoutSetPadding(10);
    //BentoLayoutSetGutter(10);
    //
    //with(BentoCreate(oBentoExRect))
    //{
    //    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
    //}
    //
    //with(BentoCreate(oBentoExRect))
    //{
    //    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
    //}
}
