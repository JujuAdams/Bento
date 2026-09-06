// Feather disable all

/// Sets parameters for a table column. The `index` parameter determines which column should be
/// adjusted. If you pass `undefined` as the column index then all columns will be adjusted,
/// overwriting any existing values. Columns are zero-indexed such that column `0` is the first
/// column on the far left of the table.
/// 
/// You may specify a maximum width of the column (though the overall width of the table is
/// constrained by the maximum width of the table element itself). If you would like a column to
/// expand as far as possible then set the `maxWidth` parameter to `infinity`.
/// 
/// The `hAlign` parameter controls how children are positioned if content doesn't fill up the full
/// width of a column. This value should typically be a number from `0` to `1`.
/// 
/// N.B. Do not use `fa_*` constants with this function. Provide a number for the alignments.
/// 
/// @param [index]
/// @param hAlign
/// @param maxWidth
/// @param [element=self]

function BentoLayoutSetTableColumn(_index = undefined, _hAlign, _maxWidth, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__layoutType != BENTO_LAYOUT_TABLE)
        {
            __BentoError("Element is not a table. Please call `BentoLayoutTable()` before `BentoLayoutSetTableColumn()`");
            return;
        }
        
        //FIXME - Create maps on demand
        
        var _dirty = false;
        if (_index == undefined)
        {
            if ((ds_map_size(__tableHAlignMap) > 0) || (ds_map_size(__tableMaxWidthMap) > 0))
            {
                _dirty = true;
            }
            
            ds_map_clear(__tableHAlignMap);
            ds_map_clear(__tableMaxWidthMap);
            
            if (_hAlign != undefined)
            {
                if (__tableDefaultHAlign != _hAlign)
                {
                    __tableDefaultHAlign = _hAlign;
                    _dirty = true;
                }
            }
            
            if (_maxWidth != undefined)
            {
                if (__tableDefaultMaxWidth != _maxWidth)
                {
                    __tableDefaultMaxWidth = _maxWidth;
                    _dirty = true;
                }
            }
        }
        else
        {
            if (__tableHAlignMap[? _index] != _hAlign)
            {
                __tableHAlignMap[? _index] = _hAlign;
                _dirty = true;
            }
            
            if (__tableMaxWidthMap[? _index] != _maxWidth)
            {
                __tableMaxWidthMap[? _index] = _maxWidth;
                _dirty = true;
            }
        }
        
        if (_dirty)
        {
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
        }
    }
}