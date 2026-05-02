// Feather disable all

/// Returns a struct that contains data relating to the visual transform state that has been set
/// with the `BentoTransform*()`. functions.
/// 
/// @param [element=self]

function BentoTransformGetData(_element = self)
{
    static _staticStruct = {
        xOffset: 0,
        yOffset: 0,
        xScale:  1,
        yScale:  1,
        angle:   0,
        xOrigin: 0,
        yOrigin: 0,
    };
    
    if (BentoExists(_element))
    {
        with(_element.BENTO_VARS)
        {
            _staticStruct.xOffset = __transformOffsetX;
            _staticStruct.yOffset = __transformOffsetY;
            _staticStruct.xScale  = __transformScaleX;
            _staticStruct.yScale  = __transformScaleY;
            _staticStruct.angle   = __transformAngle;
            _staticStruct.xOrigin = __transformOriginX;
            _staticStruct.yOrigin = __transformOriginY;
        }
    }
    else
    {
        with(_staticStruct)
        {
            xOffset = 0;
            yOffset = 0;
            xScale  = 1;
            yScale  = 1;
            angle   = 0;
            xOrigin = 0;
            yOrigin = 0;
        }
    }
    
    return _staticStruct;
}