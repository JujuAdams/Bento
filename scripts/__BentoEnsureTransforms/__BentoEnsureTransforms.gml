// Feather disable all

/// Must be called in the scope of `__BentoClassLayer`.

function __BentoEnsureTransforms()
{
    array_foreach(__dirtyTransformsArray, _funcApply);
    array_resize(__dirtyTransformsArray, 0);
    
    static _funcApply = function(_bentoVars)
    {
        with(_bentoVars)
        {
            __transformDirty = false;
            
            var _scaleX  = __transformScaleX;
            var _scaleY  = __transformScaleY;
            var _angle   = __transformAngle;
            var _offsetX = __transformOffsetX;
            var _offsetY = __transformOffsetY;
            
            if ((_offsetX != 0) || (_offsetY != 0) || (_scaleX != 1) || (_scaleY != 1) || (_angle != 0))
            {
                var _cos =  dcos(_angle);
                var _sin = -dsin(_angle);
                
                //We're newly applying a transform matrix, this means we need to change what methods are called for
                //this element in the draw order
                var _transformMatrix = __transformMatrix;
                if (_transformMatrix == undefined)
                {
                    __layer.__dirtyFlags |= __BENTO_DIRTY_DRAW;
                    
                    //Create a new array for the matrix to live in
                    _transformMatrix = matrix_build_identity();
                    __transformMatrix = _transformMatrix;
                }
                
                var _x = __attachedElement.bentoX
                var _y = __attachedElement.bentoY
                
                if (__transformOffsetAbsolute)
                {
                    _offsetX -= _x;
                    _offsetY -= _y;
                }
                
                var _originX = __transformOriginX;
                var _originY = __transformOriginY;
                var _originX = (_originX == undefined)? _x : (__attachedElement.bentoLeft + _originX);
                var _originY = (_originY == undefined)? _y : (__attachedElement.bentoTop  + _originY);
                
                //Update the existing matrix
                _transformMatrix[@  0] =  _scaleX*_cos;
                _transformMatrix[@  1] =  _scaleX*_sin;
                _transformMatrix[@  4] = -_scaleY*_sin;
                _transformMatrix[@  5] =  _scaleY*_cos;
                _transformMatrix[@ 12] =  _offsetX + _x - (_scaleX*_originX*_cos - _scaleY*_originY*_sin);
                _transformMatrix[@ 13] =  _offsetY + _y - (_scaleY*_originY*_sin + _scaleY*_originY*_cos);
            }
            else
            {
                //We're newly removing a transform matrix, this means we need to change what methods are called for
                //this element in the draw order
                if (__transformMatrix != undefined)
                {
                    __layer.__dirtyFlags |= __BENTO_DIRTY_DRAW;
                }
                
                __transformMatrix = undefined;
            }
        }
    }
}