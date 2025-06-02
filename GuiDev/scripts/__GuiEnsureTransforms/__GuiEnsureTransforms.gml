// Feather disable all

/// Must be called in the scope of `__GuiClassLayer`.

function __GuiEnsureTransforms()
{
    array_foreach(__dirtyTransformsArray, _funcApply);
    array_resize(__dirtyTransformsArray, 0);
    
    static _funcApply = function(_guiVars)
    {
        with(_guiVars)
        {
            __transformDirty = false;
            
            var _scaleX  = __transformScaleX;
            var _scaleY  = __transformScaleY;
            var _angle   = __transformAngle;
            var _originX = __transformOriginX;
            var _originY = __transformOriginY;
            
            if ((__transformOffsetX != 0) || (__transformOffsetY != 0)
            ||  (_scaleX != 1) || (_scaleY != 1) || (_angle != 0)
            ||  (_originX != undefined) || (_originY != undefined))
            {
                var _originX = (_originX == undefined)? __attachedElement.guiX : (__attachedElement.guiLeft + _originX);
                var _originY = (_originY == undefined)? __attachedElement.guiY : (__attachedElement.guiTop  + _originY);
                
                var _cos =  dcos(_angle);
                var _sin = -dsin(_angle);
                
                //We're newly applying a transform matrix, this means we need to change what methods are called for
                //this element in the draw order
                if (__transformMatrix == undefined)
                {
                    __layer.__drawDirty = true;
                }
                
                //TODO - Don't generate a new transform matrix if we don't have to
                __transformMatrix = [ _scaleX*_cos, _scaleX*_sin, 0, 0,
                                     -_scaleY*_sin, _scaleY*_cos, 0, 0,
                                      0, 0, 1, 0,
                                      __transformOffsetX + _originX - (_originX*_scaleX*_cos - _originY*_scaleY*_sin), __transformOffsetY + _originY - (_originX*_scaleX*_sin + _originY*_scaleY*_cos), 0, 1];
            }
            else
            {
                //We're newly removing a transform matrix, this means we need to change what methods are called for
                //this element in the draw order
                if (__transformMatrix != undefined)
                {
                    __layer.__drawDirty = true;
                }
                
                __transformMatrix = undefined;
            }
        }
    }
}