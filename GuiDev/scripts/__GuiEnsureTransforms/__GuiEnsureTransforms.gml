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
            
            if ((__transformOffsetX != 0) || (__transformOffsetY != 0)
            ||  (__transformScaleX  != 1) || (__transformScaleY  != 1)
            ||  (__transformAngle   != 0)
            ||  (__transformOriginX != undefined) || (__transformOriginY != undefined))
            {
                var _originX = (__transformOriginX == undefined)? __attachedElement.guiX : (__attachedElement.guiLeft + __transformOriginX);
                var _originY = (__transformOriginY == undefined)? __attachedElement.guiY : (__attachedElement.guiTop  + __transformOriginY);
                
                var _cos =  dcos(__transformAngle);
                var _sin = -dsin(__transformAngle);
                
                if (__transformMatrix == undefined)
                {
                    __layer.__drawDirty = true;
                }
                
                __transformMatrix = [ __transformScaleX*_cos, __transformScaleX*_sin, 0, 0,
                                     -__transformScaleY*_sin, __transformScaleY*_cos, 0, 0,
                                      0, 0, 1, 0,
                                      _originX - (_originX*__transformScaleX*_cos - _originY*__transformScaleY*_sin), _originY - (_originX*__transformScaleX*_sin + _originY*__transformScaleY*_cos), 0, 1];
            }
            else
            {
                if (__transformMatrix != undefined)
                {
                    __layer.__drawDirty = true;
                }
                
                __transformMatrix = undefined;
            }
        }
    }
}