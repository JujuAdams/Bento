// Feather disable all

/// @param [xFrom=0]
/// @param [yFrom=0]
/// @param [scaleFrom=1]
/// @param [alphaFrom=1]
/// @param duration
/// @param [animCurve=linear]
/// @param [element=self]

function BentoAnimSimpleIn(_xFrom = 0, _yFrom = 0, _scaleFrom = 1, _alphaFrom = 1, _duration, _animCurve = undefined, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        __animSimple = __BENTO_ANIM_SIMPLE_IN;
        __animString = "";
        
        __animDestroyAtEnd = false;
        
        __animSimpleXFrom      = _xFrom;
        __animSimpleYFrom      = _yFrom;
        __animSimpleXScaleFrom = _scaleFrom;
        __animSimpleYScaleFrom = _scaleFrom;
        __animSimpleAlphaFrom  = _alphaFrom;
        
        __animSimpleXTo      = __transformOffsetX;
        __animSimpleYTo      = __transformOffsetY;
        __animSimpleXScaleTo = __transformScaleX;
        __animSimpleYScaleTo = __transformScaleY;
        __animSimpleAlphaTo  = 1; //TODO - Get current
    }
}