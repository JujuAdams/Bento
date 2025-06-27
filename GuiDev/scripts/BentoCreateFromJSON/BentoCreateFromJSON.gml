// Feather disable all

/// Creates a GUI instances based on input JSON data. This function can be used to create multiple
/// instances and define multiple properties for those instances. More information on the expected
/// JSON format can be found in the `GUI JSON Format` note.
/// 
/// This function will return the instance that gets created or, if the root node of the JSON is
/// an array, this function will return the first instance that gets created.
/// 
/// @param json
/// @param [parent=self]
/// @param [metadata]

function BentoCreateFromJSON(_json, _parent = self, _metadata = undefined)
{
    var _firstElement = undefined;
    
    if (is_array(_json))
    {
        var _i = 0;
        repeat(array_length(_json))
        {
            var _element = __BentoCreateViaJSONInner(_json[_i], _parent, _metadata);
            
            if (_firstElement == undefined)
            {
                _firstElement = _element;
            }
            
            ++_i;
        }
        
        return _firstElement;
    }
    else
    {
        return __BentoCreateViaJSONInner(_json, _parent, _metadata);
    }
}

/// @param json
/// @param parent
/// @param metadata

function __BentoCreateViaJSONInner(_json, _parent, _metadata)
{
    if (is_array(_json))
    {
        var _i = 0;
        repeat(array_length(_json))
        {
            __BentoCreateViaJSONInner(_json[_i], _parent, _metadata);
            ++_i;
        }
    }
    else if (is_struct(_json))
    {
        if (variable_struct_exists(_json, "object"))
        {
            if (variable_struct_exists(_json, "struct"))
            {
                __BentoError($"JSON must only contain .object or .struct");
            }
            
            //Determine object to create
            //We accept object handles, stringified object handles, and object names
            var _object = _json[$ "object"];
            if (is_string(_object))
            {
                var _convertedObject = asset_get_index(_object);
            
                if (not object_exists(_convertedObject))
                {
                    _convertedObject = handle_parse(_object);
                }
            }
            else if (not is_handle(_object))
            {
                __BentoError($"Could not find object \"{object_get_name(_object)}\" (wrong datatype \"{typeof(_object)}\")");
            }
            
            if (not object_exists(_object))
            {
                __BentoError($"Could not find object \"{object_get_name(_object)}\"");
            }
            
            if (not __BentoObjectInheritsFrom(_object, oBentoLibAncestor))
            {
                __BentoError($"Object \"{object_get_name(_object)}\" does not inherit from {object_get_name(oBentoLibAncestor)}");
            }
            
            //Unpack and validate the .vars property
            var _vars = _json[$ "vars"];
            if ((_vars != undefined) && (not is_struct(_vars)))
            {
                __BentoError($".vars property is incorrect datatype, must be a struct (was \"{typeof(_vars)}\")");
            }
            
            //Create the instance itself
            var _element = BentoCreateObject(_object, _vars, _parent);
        }
        else if (variable_struct_exists(_json, "struct"))
        {
            var _struct = _json[$ "struct"];
            if (is_struct(_struct))
            {
                var _element = _struct;
            }
            else
            {
                __BentoError($".struct property is incorrect datatyle, must be a struct (wrong datatype \"{typeof(_object)}\")");
            }
        }
        else
        {
            __BentoError($"JSON must contain one of either .object or .struct");
        }
        
        var _forceStep = _json[$ "forceStep"];
        if (_forceStep != undefined)
        {
            BentoSetForceStep(_forceStep, _element);
        }
        
        var _button = _json[$ "button"];
        if (_button != undefined)
        {
            BentoSetButton(_button, _element);
        }
        
        var _visible = _json[$ "visible"];
        if (_visible != undefined)
        {
            BentoSetVisible(_visible, _element);
        }
        
        //Name the instance
        var _name = _json[$ "name"];
        if (_name != undefined)
        {
            if (is_method(_name))
            {
                _name = _name(_metadata);
                
                if (not is_string(_name))
                {
                    __BentoError($".name method did not return a string (was {typeof(_name)})");
                }
            }
            
            if (is_string(_name))
            {
                BentoNameSet(_name, _element);
            }
            else
            {
                __BentoError($".name property is incorrect datatype, must be a string (was \"{typeof(_vars)}\")");
            }
        }
        
        //Offset the instance
        var _offset = _json[$ "offset"];
        if (_offset != undefined)
        {
            if (is_array(_offset))
            {
                if (array_length(_offset) != 2)
                {
                    __BentoError($".offset property must have 2 elements if it is an array (length = {array_length(_offset)})");
                }
        
                BentoSetOffset(_offset[0], _offset[1], _element);
            }
            else if (is_struct(_offset))
            {
                BentoSetOffset(_offset[$ "x"], _offset[$ "y"], _element);
            }
            else
            {
                __BentoError($".offset property must be a 2-element array or a struct (typeof \"{typeof(_offset)}\")");
            }
        }
        
        //Apply layout options
        var _layout = _json[$ "layout"];
        if (_layout != undefined)
        {
            if (not is_struct(_json))
            {
                __BentoError($".layout property is incorrect datatype, must be a struct (was \"{typeof(_json)}\")");
            }
            
            BentoLayoutSetFromJSON(_layout, _element);
        }
        
        var _children = _json[$ "children"];
        if (_children != undefined)
        {
            if (is_string(_children))
            {
                var _processor = GUI_JSON_CHILDREN_STRING_PROCESSOR;
                if (is_callable(_processor))
                {
                    _children = _processor(_children, _metadata);
                }
                else
                {
                    __BentoError($".children was provided as a string but `GUI_JSON_CHILDREN_STRING_PROCESSOR` is not a function");
                }
            }
            
            if (is_method(_children))
            {
                _children = _children(_metadata);
                
                if (not is_array(_children))
                {
                    __BentoError($".children method did not return an array (was {typeof(_children)})");
                }
            }
            
            if (not is_array(_children))
            {
                __BentoError($".children property must be an array (was {typeof(_children)})");
            }
            else
            {
                __BentoCreateViaJSONInner(_children, _element, _metadata, false);
            }
        }
        
        var _scissor = _json[$ "scissor"];
        if (_scissor != undefined)
        {
            if (not is_struct(_scissor))
            {
                __BentoError($".scissor property must be a struct (was {typeof(_children)})");
            }
            else
            {
                var _nameArray = variable_struct_get_names(_scissor);
                var _i = 0;
                repeat(array_length(_nameArray))
                {
                    var _name  = _nameArray[_i];
                    var _value = _scissor[$ _name];
                    
                    if (_name == "enabled")
                    {
                        __BentoJSONScissor_enabled(_element, _value);
                    }
                    else if (_name == "padding")
                    {
                        __BentoJSONScissor_padding(_element, _value);
                    }
                    else
                    {
                        __BentoError($"Scissor property name \"{_name}\" not recognized or not supported");
                    }
                    
                    ++_i;
                }
            }
        }
        
        var _scroll = _json[$ "scroll"];
        if (_scroll != undefined)
        {
            if (not is_struct(_scroll))
            {
                __BentoError($".scroll property must be a struct (was {typeof(_scroll)})");
            }
            else
            {
                var _nameArray = variable_struct_get_names(_scroll);
                var _i = 0;
                repeat(array_length(_nameArray))
                {
                    var _name  = _nameArray[_i];
                    var _value = _scroll[$ _name];
                    
                    if (_name == "enabled")
                    {
                        __BentoJSONScroll_enabled(_element, _value);
                    }
                    else if (_name == "padding")
                    {
                        __BentoJSONScroll_padding(_element, _value);
                    }
                    else
                    {
                        __BentoError($"Scroll property name \"{_name}\" not recognized or not supported");
                    }
                    
                    ++_i;
                }
            }
        }
        
        return _element;
    }
    else
    {
        __BentoError($"JSON structure must be made from arrays and structs (found datatype \"{typeof(_json)}\")");
    }
}



////////
// .enabled
////////
function __BentoJSONScissor_enabled(_element, _value)
{
    if (is_bool(_value))
    {
        BentoClipSetEnabled(_value, _element);
    }
    else
    {
        __BentoError($".enabled scissor property must be a boolean (was {typeof(_value)})");
    }
}



////////
// .padding
////////
function __BentoJSONScissor_padding(_element, _value)
{
    if (is_numeric(_value))
    {
        BentoClipSetPadding(_value, _value, _value, _value, _element);
    }
    else if (is_array(_value))
    {
        if (array_length(_value) != 4)
        {
            __BentoError($".padding scissor property must have 4 elements if it is an array (length = {array_length(_value)})");
        }
        
        BentoClipSetPadding(_value[0], _value[1], _value[2], _value[3], _element);
    }
    else if (is_struct(_value))
    {
        BentoClipSetPadding(_value[$ "l"] ?? _value[$ "left"],
                             _value[$ "t"] ?? _value[$ "top"],
                             _value[$ "r"] ?? _value[$ "right"],
                             _value[$ "b"] ?? _value[$ "bottom"],
                             _element);
    }
    else
    {
        __BentoError($".padding scissor property must be a number, a 4-element array, or a struct (typeof \"{typeof(_value)}\")");
    }
}



////////
// .enabled
////////
function __BentoJSONScroll_enabled(_element, _value)
{
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __BentoError($".padding scroll property must have 2 elements if it is an array (length = {array_length(_value)})");
        }
        
        BentoScrollSetEnabled(_value[0], _value[1], _element);
    }
    else if (is_struct(_value))
    {
        BentoScrollSetEnabled(_value[$ "h"] ?? _value[$ "x"],
                            _value[$ "v"] ?? _value[$ "y"],
                            _element);
    }
    else
    {
        __BentoError($".enabled scroll property must be a 2-element array or a struct (typeof \"{typeof(_value)}\")");
    }
}



////////
// .padding
////////
function __BentoJSONScroll_padding(_element, _value)
{
    if (is_array(_value))
    {
        if (array_length(_value) != 4)
        {
            __BentoError($".padding scroll property must have 4 elements if it is an array (length = {array_length(_value)})");
        }
        
        BentoClipSetPadding(_value[0], _value[1], _value[2], _value[3], _element);
    }
    else if (is_struct(_value))
    {
        BentoScrollSetPadding(_value[$ "l"] ?? _value[$ "left"],
                            _value[$ "t"] ?? _value[$ "top"],
                            _value[$ "r"] ?? _value[$ "right"],
                            _value[$ "b"] ?? _value[$ "bottom"],
                            _element);
    }
    else
    {
        __BentoError($".padding scroll property must be a 4-element array or a struct (typeof \"{typeof(_value)}\")");
    }
}