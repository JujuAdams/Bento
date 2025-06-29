// Feather disable all

/// @param [xTo=0]
/// @param [yTo=0]
/// @param [scaleTo=1]
/// @param [alphaTo=1]
/// @param duration
/// @param [animCurve=linear]
/// @param [destroyAtEnd=true]
/// @param [element=self]

function BentoAnimSimpleOut(_xTo = 0, _yTo = 0, _scaleTo = 1, _alphaTo = 1, _duration, _animCurve = undefined, _destroyAtEnd = true, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        __animSimple = __BENTO_ANIM_SIMPLE_OUT;
        __animString = "";
        
        __animDestroyAtEnd = true;
        
        __animSimpleXFrom      = __transformOffsetX;
        __animSimpleYFrom      = __transformOffsetY;
        __animSimpleXScaleFrom = __transformScaleX;
        __animSimpleYScaleFrom = __transformScaleY;
        __animSimpleAlphaFrom  = 1; //TODO - Get current
        
        __animSimpleXTo      = _xTo;
        __animSimpleYTo      = _yTo;
        __animSimpleXScaleTo = _scaleTo;
        __animSimpleYScaleTo = _scaleTo;
        __animSimpleAlphaTo  = _alphaTo;
    }
}