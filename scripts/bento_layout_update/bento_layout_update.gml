/// @param element

function bento_layout_update(_element)
{
    with(_element)
    {
        position_update();
        var _bbox_content = properties.bbox_content;
        
        var _content_max_width  = 1 + _bbox_content.r - _bbox_content.l;
        var _content_max_height = 1 + _bbox_content.b - _bbox_content.t;
        
        if (style.layout == "flexbox")
        {
            #region Flexbox Emulation
            
            var _content_valign = style.flexbox.content_valign
            var _line_halign    = style.flexbox.line_halign;
            var _line_valign    = style.flexbox.line_valign;
            
            //Set some state variables
            var _line = -1;
            var _line_array = [];
        
            var _line_y = 0;
        
            var _e = 0;
            var _children_count = array_length(children);
            while(_e < _children_count)
            {
                //Create a line if we need it
                if (!is_struct(_line))
                {
                    _line = {
                        x             : 0,
                        y             : _line_y,
                        width         : 0,
                        height        : 0,
                        element_start : _e,
                        element_count : 0,
                    }
                
                    _line_array[@ array_length(_line_array)] = _line;
                }
            
                //Get our child
                var _child = children[_e];
                
                if (is_string(_child) && (_child == "__bento_layout_newline"))
                {
                    //Line break special case
                    _line_y += _line.height;
                    _line = -1;
                }
                else if (_child.properties.bento_layout_auto)
                {
                    var _child_width  = __bento_width_perc( _child.parent.properties.bbox_content, _child.properties.width );
                    var _child_height = __bento_height_perc(_child.parent.properties.bbox_content, _child.properties.height);
                    
                    //TODO - Include padding and margin
                    
                    //Figure out where to place the element
                    if (_line.width + _child_width > _content_max_width)
                    {
                        if (_line.element_count == 0)
                        {
                            with(_line)
                            {
                                width  = _child_width;
                                height = _child_height;
                                element_start = _e;
                                element_count = 1;
                            }
                        }
                        else
                        {
                            --_e;
                        }
                        
                        _line_y += _line.height;
                        _line = -1;
                    }
                    else
                    {
                        with(_line)
                        {
                            width += _child_width;
                            height = max(height, _child_height);
                            element_count++;
                        }
                    }
                }
                
                ++_e;
            }
            
            var _line_count = array_length(_line_array);
            if (array_length(_line_array) > 0)
            {
                var _line = _line_array[_line_count - 1];
                var _content_height = _line.y + _line.height;
                var _content_space  = _content_max_height - _content_height;
                
                var _content_x = _bbox_content.l;
                var _content_y = _bbox_content.t;
                
                var _line_gap = 0;
                var _line_x   = _content_x;
                var _line_y   = _content_y;
                
                #region Content vertical alignment / line gap
                
                switch(_content_valign)
                {
                    case "top":
                    break;
                    
                    case "center":
                    case "centre":
                    case "middle":
                        _line_y += _content_space/2;
                    break;
                    
                    case "bottom":
                        _line_y += _content_space;
                    break;
                    
                    case "between":
                    case "space between":
                    case "space-between":
                        if (_line_count == 1)
                        {
                            //Special case for only one element
                            _line_y += _content_space/2;
                        }
                        else
                        {
                            _line_gap = _content_space/(_line_count - 1);
                        }
                    break;
                    
                    case "around":
                    case "space around":
                    case "space-around":
                        if (_line_count == 1)
                        {
                            //Special case for only one element
                            _line_y += _content_space/2;
                        }
                        else
                        {
                            _line_gap = _content_space/_line_count;
                            _line_y += _line_gap/2;
                        }
                    break;
                }
                
                #endregion
                
                var _l = 0;
                repeat(array_length(_line_array))
                {
                    var _line = _line_array[_l];
                    
                    var _element_gap = 0;
                    var _element_x   = _line_x;
                    var _element_y   = _line_y;
                    
                    #region Line justification / element gap
                    
                    var _space = _content_max_width - _line.width;
                    switch(_line_halign)
                    {
                        case "left":
                        break;
                        
                        case "center":
                        case "centre":
                        case "middle":
                            _element_x += _space/2;
                        break;
                        
                        case "right":
                            _element_x += _space;
                        break;
                        
                        case "between":
                        case "space between":
                        case "space-between":
                            if (_line.element_count == 1)
                            {
                                //Special case for only one element
                                _element_x += _space/2;
                            }
                            else
                            {
                                _element_gap = _space/(_line.element_count - 1);
                            }
                        break;
                        
                        case "around":
                        case "space around":
                        case "space-around":
                            if (_line.element_count == 1)
                            {
                                //Special case for only one element
                                _element_x += _space/2;
                            }
                            else
                            {
                                _element_gap = _space/_line.element_count;
                                _element_x += _element_gap/2;
                            }
                        break;
                        
                        case "even":
                        case "evenly":
                        case "space evenly":
                        case "space-evenly":
                            if (_line.element_count == 1)
                            {
                                //Special case for only one element
                                _element_x += _space/2;
                            }
                            else
                            {
                                _element_gap = _space/(_line.element_count + 1);
                                _element_x += _element_gap;
                            }
                        break;
                    }
                    
                    #endregion
                    
                    var _e = _line.element_start;
                    repeat(_line.element_count)
                    {
                        var _child             = children[_e];
                        var _child_properties  = _child.properties;
                        var _child_bbox_margin = _child_properties.bbox_margin;
                        
                        var _child_width  = __bento_width_perc( _child.parent.properties.bbox_content, _child_properties.width );
                        var _child_height = __bento_height_perc(_child.parent.properties.bbox_content, _child_properties.height);
                        
                        //TODO - Include padding and margin
                        var _full_width  = _child_width;
                        var _full_height = _child_height;
                        
                        #region Vertical alignment
                        
                        var _element_y = _line_y;
                        switch(_line_valign)
                        {
                            case "top":
                            break;
                            
                            case "center":
                            case "centre":
                            case "middle":
                                _element_y += (_line.height - _full_height)/2;
                            break;
                            
                            case "bottom":
                                _element_y += _line.height - _full_height;
                            break;
                            
                            case "stretch":
                            break;
                        }
                        
                        #endregion
                        
                        //Position the element
                        
                        //TODO - Include padding and margin
                        _child_bbox_margin.l = _element_x;
                        _child_bbox_margin.t = _element_y;
                        
                        _child_bbox_margin.r = _child_bbox_margin.l + _full_width;
                        
                        if (_line_valign == "stretch")
                        {
                            _child_bbox_margin.b = _line_y + _line.height;
                        }
                        else
                        {
                            _child_bbox_margin.b = _child_bbox_margin.t + _child_height;
                        }
                        
                        _element_x += _full_width + _element_gap;
                        
                        //Now resolve the child
                        bento_layout_update(_child);
                        
                        ++_e;
                    }
                    
                    _line_y += _line.height + _line_gap;
                    
                    ++_l;
                }
            }
            
            #endregion
        }
        else if (style.layout == "grid")
        {
            #region CSS Grids Emulation
            
            var _content_halign = style.grid.content_halign;
            var _content_valign = style.grid.content_valign;
            var _element_halign = style.grid.element_halign;
            var _element_valign = style.grid.element_valign;
            
            var _grid_columns    = style.grid.columns;
            var _grid_column_gap = style.grid.column_gap;
            var _grid_rows       = style.grid.rows;
            var _grid_row_gap    = style.grid.row_gap;
            
            var _grid_width  = array_length(_grid_columns);
            var _grid_height = array_length(_grid_rows);
            
            //Initialise our usage grid
            var _grid_element = array_create(_grid_width);
            var _x = 0;
            repeat(_grid_width)
            {
                _grid_element[@ _x] = array_create(_grid_height, undefined);
                ++_x;
            }
            
            #region Place children on the grid
            
            var _x = 0;
            var _y = 0;
            var _grid_x_count = 0;
            var _grid_y_count = 1;
            var _e = 0;
            repeat(array_length(children))
            {
                var _child = children[_e];
                
                if (is_string(_child) && (_child == "__bento_layout_newline"))
                {
                    //Line break special case
                    _x = 0;
                    ++_y;
                }
                else if (_child.properties.bento_layout_auto)
                {
                    _grid_element[_x][@ _y] = _child;
                    
                    //Move to the next cell
                    ++_x;
                    _grid_x_count = max(_grid_x_count, _x);
                    
                    if (_x >= _grid_width)
                    {
                        if (_y >= _grid_height)
                        {
                            _y = _grid_height - 1;
                            //break;
                        }
                        else
                        {
                            _x = 0;
                            ++_y;
                            ++_grid_y_count;
                        }
                    }
                }
                
                ++_e;
            }
            
            #endregion
            
            #region Find the pixel size of the grid
            
            var _content_width = _grid_column_gap*(_grid_x_count - 1) + 1;
            var _x = 0;
            repeat(_grid_x_count)
            {
                _content_width += _grid_columns[_x];
                ++_x;
            }
            
            var _content_height = _grid_row_gap*(_grid_y_count - 1) + 1;
            var _y = 0;
            repeat(_grid_y_count)
            {
                _content_height += _grid_columns[_y];
                ++_y;
            }
            
            #endregion
            
            var _grid_l = _bbox_content.l;
            var _grid_t = _bbox_content.t;
            
            #region Content justification
            
            var _space = _content_max_width - _content_width;
            switch(_content_halign)
            {
                case "left":
                break;
                
                case "center":
                case "centre":
                case "middle":
                    _grid_l += _space/2;
                break;
                
                case "right":
                    _grid_l += _space;
                break;
                
                case "stretch":
                    //TODO
                break;
                
                case "between":
                case "space between":
                case "space-between":
                    if (_grid_x_count == 1)
                    {
                        //Special case for only one element
                        _grid_l += _space/2;
                    }
                    else
                    {
                        _grid_column_gap += _space/(_grid_x_count - 1);
                    }
                break;
                
                case "around":
                case "space around":
                case "space-around":
                    if (_grid_x_count == 1)
                    {
                        //Special case for only one element
                        _grid_l += _space/2;
                    }
                    else
                    {
                        _grid_column_gap = (_grid_column_gap*(_grid_x_count - 1) + _space)/_grid_x_count;
                        _grid_l += _grid_column_gap/2;
                    }
                break;
                
                case "even":
                case "evenly":
                case "space evenly":
                case "space-evenly":
                    if (_grid_x_count == 1)
                    {
                        //Special case for only one element
                        _grid_l += _space/2;
                    }
                    else
                    {
                        _grid_column_gap = (_grid_column_gap*(_grid_x_count - 1) + _space)/(_grid_x_count + 1);
                        _grid_l += _grid_column_gap;
                    }
                break;
            }
            
            #endregion
            
            #region Content alignment
            
            var _space = _content_max_height - _content_height;
            switch(_content_valign)
            {
                case "top":
                break;
                
                case "center":
                case "centre":
                case "middle":
                    _grid_t += _space/2;
                break;
                
                case "bottom":
                    _grid_t += _space;
                break;
                
                case "stretch":
                    //TODO
                break;
                
                case "between":
                case "space between":
                case "space-between":
                    if (_grid_y_count == 1)
                    {
                        //Special case for only one element
                        _grid_t += _space/2;
                    }
                    else
                    {
                        _grid_row_gap += _space/(_grid_y_count - 1);
                    }
                break;
                
                case "around":
                case "space around":
                case "space-around":
                    if (_grid_y_count == 1)
                    {
                        //Special case for only one element
                        _grid_t += _space/2;
                    }
                    else
                    {
                        _grid_row_gap = (_grid_row_gap*(_grid_y_count - 1) + _space)/_grid_y_count;
                        _grid_t += _grid_row_gap/2;
                    }
                break;
                
                case "even":
                case "evenly":
                case "space evenly":
                case "space-evenly":
                    if (_grid_y_count == 1)
                    {
                        //Special case for only one element
                        _grid_t += _space/2;
                    }
                    else
                    {
                        _grid_row_gap = (_grid_row_gap*(_grid_y_count - 1) + _space)/(_grid_y_count + 1);
                        _grid_t += _grid_row_gap;
                    }
                break;
            }
            
            #endregion
            
            #region Position children based on where they are on the grid
            
            var _cell_t = _grid_t;
            var _y = 0;
            repeat(_grid_y_count)
            {
                var _cell_l = _grid_l;
                var _x = 0;
                repeat(_grid_x_count)
                {
                    var _child = _grid_element[_x][_y];
                    if (_child != undefined)
                    {
                        var _child_properties  = _child.properties;
                        var _child_bbox_margin = _child_properties.bbox_margin;
                        var _child_width       = __bento_width_perc( _child.parent.properties.bbox_content, _child_properties.width );
                        var _child_height      = __bento_height_perc(_child.parent.properties.bbox_content, _child_properties.height);
                        
                        //Find the dimensions of the element, including padding
                        var _child_padding = _child.style.padding;
                        if (!is_struct(_child_padding))
                        {
                            var _padding_x = 2*_child_padding;
                            var _padding_y = 2*_child_padding;
                        }
                        else
                        {
                            var _padding_x = _child_padding.l + _child_padding.r;
                            var _padding_y = _child_padding.t + _child_padding.b;
                        }
                        
                        var _element_l = _cell_l;
                        var _element_t = _cell_t;
                        
                        #region Element horizontal alignment
                        
                        var _space = _grid_columns[_x] - (_child_width + _padding_x);
                        switch(_element_halign)
                        {
                            case "left":
                            break;
                            
                            case "center":
                            case "centre":
                            case "middle":
                                _element_l += _space/2;
                            break;
                            
                            case "right":
                                _element_l += _space;
                            break;
                            
                            case "stretch":
                                _child_width += _space;
                            break;
                            
                            default:
                                throw "Bento: Invalid element justification \"" + string(_element_halign) + "\"";
                            break;
                        }
                        
                        #endregion
                        
                        #region Element vertical alignment
                        
                        var _space = _grid_rows[_y] - (_child_height + _padding_y);
                        switch(_element_valign)
                        {
                            case "top":
                            break;
                            
                            case "center":
                            case "centre":
                            case "middle":
                                _element_t += _space/2;
                            break;
                            
                            case "bottom":
                                _element_t += _space;
                            break;
                            
                            case "stretch":
                                _child_height += _space;
                            break;
                            
                            default:
                                throw "Bento: Invalid element alignment \"" + string(_element_halign) + "\"";
                            break;
                        }
                        
                        #endregion
                        
                        //Position the element
                        if (!is_struct(_child_padding))
                        {
                            _child_bbox_margin.l = _element_l + _child_padding;
                            _child_bbox_margin.t = _element_t + _child_padding;
                        }
                        else
                        {
                            _child_bbox_margin.l = _element_l + _child_padding.l;
                            _child_bbox_margin.t = _element_t + _child_padding.t;
                        }
                        
                        _child_bbox_margin.r = _child_bbox_margin.l + _child_width;
                        _child_bbox_margin.b = _child_bbox_margin.t + _child_height;
                        
                        //Now resolve the child
                        bento_layout_update(_child);
                    }
                    
                    _cell_l += _grid_columns[_x] + _grid_column_gap;
                    ++_x;
                }
                
                _cell_t += _grid_rows[_y] + _grid_row_gap;
                ++_y;
            }
            
            #endregion
            
            #endregion
        }
    }
}