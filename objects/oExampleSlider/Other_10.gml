/// @desc Step

// Feather disable all

event_inherited();

var _value = BentoRefGet(reference);

var _stepCount   = ceil((valueMax - valueMin) / valueStep);
var _handleStep  = min(_stepCount, floor((_value - valueMin) / valueStep));
var _handleWidth = handleWidth ?? (bentoWidth / _stepCount);
var _stepWidth   = (bentoWidth - _handleWidth) / _stepCount;
var _handleLeft  = bentoLeft + _stepWidth*_handleStep;
var _handleRight = _handleLeft + _handleWidth;

if (BentoUsingPointer())
{
    handleHover = (BentoCursorGetHover() && (BentoCursorGetX() > _handleLeft) && (BentoCursorGetX() < _handleRight));
    
    var _set = false;
    
    if (handleHover)
    {
        if (BentoPrimaryGetPress())
        {
            handleHold = true;
        }
    }
    else if (clickToSet && BentoPrimaryGetClick())
    {
        _set = true;
    }
    
    if (handleHold && BentoPrimaryGetHold())
    {
        _set = true;
    }
    
    if (_set)
    {
        _handleStep = round((BentoCursorGetX() - _handleWidth/2 - bentoLeft) / _stepWidth);
    }
    
    if (not BentoPrimaryGetHold())
    {
        handleHold = false;
    }
}
else if (BentoUsingDirectional())
{
    handleHover = BentoCursorGetHover();
    handleHold  = false;
    
    // Detect directional input to scroll throught the option array.
    if (BentoCursorGetHover() && (BentoCursorGetDX() != 0))
    {
        _handleStep += sign(BentoCursorGetDX());
    }
}

_value = clamp(valueStep*_handleStep + valueMin, valueMin, valueMax);
BentoRefSet(reference, _value);