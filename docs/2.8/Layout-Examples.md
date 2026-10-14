## Basic Size & Positioning

<figure><img src="assets/DocsRectangle.png" style="width:80%; display: block; margin: 25px auto 15px; max-width: 300px; height: auto;" /></figure>

```gml
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
```

&nbsp;

## Anchors

<figure><img src="assets/DocsAnchor.png" style="width:80%; display: block; margin: 25px auto 15px; max-width: 300px; height: auto;" /></figure>

```gml
with(BentoLayerGetRoot()) //Step inside the root element for the layer
{
    with(BentoCreate(oDocsElement)) //Create a new element in the top-left
    {
        image_blend = c_red;
        BentoLayoutSetSize(100, 150); //Set the size to exactly 150x150
    }
    
    with(BentoCreate(oDocsElement)) //Create a new element in the top-right
    {
        image_blend = c_lime;
        BentoLayoutSetSize(50, 150); //Set the size to exactly 50x150
        BentoLayoutSetAnchor(1, 0);
    }
    
    with(BentoCreate(oDocsElement)) //Create a new element in the bottom-left
    {
        image_blend = c_blue;
        BentoLayoutSetSize(150, 50); //Set the size to exactly 150x50
        BentoLayoutSetAnchor(0, 1);
    }
    
    with(BentoCreate(oDocsElement)) //Create a new element in the bottom-right
    {
        image_blend = c_yellow;
        BentoLayoutSetSize(50, 50); //Set the size to exactly 50x50
        BentoLayoutSetAnchor(1, 1);
    }
    
    with(BentoCreate(oDocsElement)) //Create a new element in the bottom-right
    {
        image_blend = c_orange;
        BentoLayoutSetSize(200, 200); //Set the size to exactly 200x200
        BentoLayoutSetAnchor(0.5, 0.5);
    }
    
    with(BentoCreate(oDocsElement)) //Create a new element in the bottom-right
    {
        image_blend = c_fuchsia;
        BentoLayoutSetSize(40, 40); //Set the size to exactly 20x20
        BentoLayoutSetAnchor(0.5, 0.5);
    }
}
```

&nbsp;

## List (x-axis)

<figure><img src="assets/DocsListX.png" style="width:80%; display: block; margin: 25px auto 15px; max-width: 300px; height: auto;" /></figure>

```gml
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
```

&nbsp;

## List (y-axis)

<figure><img src="assets/DocsListY.png" style="width:80%; display: block; margin: 25px auto 15px; max-width: 300px; height: auto;" /></figure>

```gml
with(BentoLayerGetRoot()) //Step inside the root element for the layer
{
    BentoLayoutList(BENTO_AXIS_Y, fa_left, fa_top);
    
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
```

&nbsp;

## Inflate

<figure><img src="assets/DocsInflate.png" style="width:80%; display: block; margin: 25px auto 15px; max-width: 300px; height: auto;" /></figure>

```gml
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

            //Inflate in the x-axis
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_NORMAL);
        }
        
        with(BentoCreate(oDocsElement))
        {
            image_blend = c_blue;
            BentoLayoutSetSize(50, 50);

            //Inflate in the y-axis
            BentoLayoutSetResize(BENTO_RESIZE_NORMAL, BENTO_RESIZE_INFLATE);
        }
    }
    
    with(BentoCreate(oDocsElement))
    {
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

            //Inflate in both axes
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
        }
        
        with(BentoCreate(oDocsElement))
        {
            image_blend = c_blue;
            BentoLayoutSetSize(50, 50);

            //Inflate in both axes
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
        }
    }
}
```

&nbsp;

## Deflate

<figure><img src="assets/DocsDeflate.png" style="width:80%; display: block; margin: 25px auto 15px; max-width: 300px; height: auto;" /></figure>

```gml
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
```