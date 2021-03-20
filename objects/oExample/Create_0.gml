root = BentoCreateRoot();
with(root)
{
    SetPosition(10, 10, undefined, undefined, undefined, undefined, 300, 300);
    BentoTemplateRectangle(c_white, 1.0);
    
    with(Child())
    {
        SetPosition(10, 10, undefined, undefined, undefined, undefined, 50, 50);
        BentoTemplateRectangle(c_red, 1.0);
    }
    
    with(Child())
    {
        SetPosition(70, 10, undefined, undefined, undefined, undefined, 50, 50);
        BentoTemplateRectangle(c_red, 1.0);
    }
}