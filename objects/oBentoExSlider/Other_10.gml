// Feather disable all

/// @desc Step

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
        handleHover = true;
        _handleStep = round((BentoCursorGetX() - _handleWidth/2 - bentoLeft) / _stepWidth);
    }
    
    if (not BentoPrimaryGetHold())
    {
        handleHold = false;
    }
}
else if (BentoUsingDirectional())
{
    handleHover = BentoCursorGetHover() && ((not useFocus) || (BentoFocusGetType() != BENTO_FOCUS_NONE));
    handleHold  = false;
    
    if (useFocus)
    {
        if (BentoPrimaryGetClick())
        {
            BentoFocusToggle(BENTO_FOCUS_POINTER_CANCEL_ALWAYS);
        }
        
        if (BentoHotkeyGetPress(BENTO_HOTKEY_CANCEL))
        {
            BentoFocusClose();
        }
    }
    
    if (handleHover)
    {
        if (BentoCursorGetHover() && (BentoCursorGetDX(0.3) != 0))
        {
            _handleStep += sign(BentoCursorGetDX());
        }
    }
}

_value = clamp(valueStep*_handleStep + valueMin, valueMin, valueMax);
if (BentoRefSet(reference, _value))
{
    if (is_callable(func))
    {
        func(_value);
    }
}