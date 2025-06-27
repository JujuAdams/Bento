// Feather disable all

/// Creates a Bento element based on input JSON data. This function can be used to create multiple
/// element and define multiple properties for those elements. More information on the expected
/// JSON format can be found below.
/// 
/// This function will return the element that gets created or, if the root node of the JSON is an
/// array, this function will return an array of root elements that have been created.
/// 
/// @param rootNode
/// @param [metadata]
/// @param [parent=self]
/// 
/// 
/// 
/// The root node can be an array or a JS object (hereafter called a "struct" in keeping with
/// GameMaker's terminology). If the root node is an array, all members of that array must be structs
/// and those structs must conform to the general Bento element definition specification in this
/// document.
/// 
/// 
/// 
/// Bento element definitions are structs. The struct must contain either an `.object` property or a
/// `.construct` property. This determines whether an instance or a struct is eventually created. You
/// can mix and match objects and structs in the JSON you provide.
/// 
/// If you choose to use the `.object` property then this value should be the GameMaker object that
/// is to created. The `.object` property can be the name of the object as a string, a GameMaker
/// handle, or a stringified GameMaker handle. As with all objects, any object specified in JSON must
/// inherit from `oBentoAncestor`.
/// 
/// Example:
/// ```
/// {
///     object: oBentoSprite
/// }
/// ```
/// 
/// Element definition structs may contain a `.vars` property if you have created an instance. If
/// specified, the value of the `.vars` property should be a struct that contains variable definitions
/// that will be passed to the created element. These variables are set before the Create event is
/// executed for the new instance. This is analogous to the `var_struct` argument for
/// `instance_create_*()`.
/// 
/// Example:
/// ```
/// {
///     object: oBentoSprite,
///     vars: {
///         sprite_index: sBentoMaskCircle
///     }
/// }
/// ```
/// 
/// 
/// 
/// If you choose to use the `.construct` property then this value should define a constructor that
/// should be instantiated to generate a struct. This can be done in a variety of ways as per your use
/// case and personal preference:
/// 
/// 1. `construct: ConstructorFunction`
/// 2. `construct: "ConstructorFunction"`
/// 3. `construct: [ConstructorFunction, <arg0>, ...]`
/// 4. `construct: ["ConstructorFunction", <arg0>, ...]`
/// 
/// If the value is an array then the constructor will be executed using the first (index 0) entry in
/// the array as the constructor function and the remaining entries in the array as arguments to that
/// constructor function. You may also specify a function name, as a string, instead of an actual
/// function reference which is helpful when importing JSON stored in external files.
/// 
/// Bear in mind that the constructor must inherit from `BentoConstrAncestor`. You may **not** use the
/// `.vars` property with the `.construct` property - if you want to customize struct values then you
/// take care of that in the arguments to the constructor.
/// 
/// Examples:
/// ```
/// {
///     construct: BentoConstrText
/// }
/// ```
/// 
/// ```
/// {
///     construct: [BentoConstrSprite, sBentoMaskCircle]
///     //This executes `BentoConstrSprite(sBentoMaskCircle)`
/// }
/// ```
/// 
/// 
/// 
/// Element definitions struct may also contain a `.name` property. This value will be passed to
/// `BentoNameSet()` targetting the created element.
/// 
/// Example:
/// ```
/// {
///     construct: [BentoConstrSprite, sBentoMaskCircle],
///     name: "circular ui"
/// }
/// ```
/// 
/// 
/// 
/// Element definition structs may also contain a `.children` property. If specified, this can be one
/// of three things:
/// 1. An array
/// 2. A method
/// 3. A string
/// 
/// If the `.children` of properties is set as an array of Bento element definitions. These Bento
/// instance definitions, when instantiated, will be created as childred of the parent instance.
/// 
/// Example:
/// ```
/// {
///     object: oBentoSprite,
///     children: [
///         {
///             object: oBentoSprite
///         },
///         {
///             object: oBentoSprite
///         }
///     ]
/// }
/// ```
/// 
/// The `.children` property may also be a method. This method will be executed when
/// `BentoCreateFromJSON()` is called. This method must return an array that contains Bento element
/// definitions. These elements will then be created as children. This method will be executed with
/// one argument, that is the metadata provided when calling `BentoCreateFromJSON()`.
/// 
/// Example:
/// ```
/// function ExampleGenerator(_metdata)
/// {
///     return array_create_ext(_metadata, function(_index)
///     {
///         return {
///             object: oBentoSprite,
///             name: $"element {_index}"
///         };
///     });
/// }
/// 
/// BentoCreateFromJSON({
///     object: oBentoSprite,
///     children: ExampleGenerator
/// },
/// 20);
/// ```
/// 
/// The `.children` property may also be a string. In this case, the string will be passed to a
/// function that you define using the `BENTO_JSON_CHILDREN_STRING_PROCESSOR` macro. This string
/// processor function should return an array of Bento element definitions which will then be created.
/// This feature is intended for use with runtime code compilation and execution - you can compile the
/// string found in JSON to then create children. The function specified by the above macro is called
/// with two arguments: the first is the string, the second is the metadata provided when calling
/// `BentoCreateFromJSON()`.
/// 
/// Example:
/// ```
/// #macro BENTO_JSON_CHILDREN_STRING_PROCESSOR  ExampleStringProcessor
/// 
/// function ExampleStringProcessor(_string, _metadata)
/// {
///     if (string_copy(_string, 1, 9) == "generate ")
///     {
///         return array_create_ext(real(string_delete(_string, 1, 9)), function(_index)
///         {
///             return {
///                 object: oBentoSprite,
///                 name: $"element {_index}"
///             };
///         });
///     }
///     else
///     {
///         return [];
///     }
/// }
/// 
/// BentoCreateFromJSON({
///     object: oBentoSprite,
///     children: "generate 20"
/// });
/// ```
/// 
/// 
/// 
/// Element definition structs may contain a `.layout` property. If specified, this should be a struct
/// that contains definitions for layout rules. This struct is passed to `BentoLayoutSetFromJSON()`
/// targetting the created element. Please see that function for documentation.
/// 
/// Example:
/// ```
/// {
///     object: oBentoList,
///     layout: {
///         resize: ["shrink", "static"],
///         size: [100, 70],
///         axis: "x"
///     },
///     children: [
///         {
///             object: oBentoSprite,
///             vars: {
///                 image_blend: c_red,
///             },
///             layout: {
///                 resize: ["static", "expand"],
///                 size: [30, 30]
///             },
///         },
///         {
///             object: oBentoSprite,
///             vars: {
///                 image_blend: c_blue,
///             },
///             layout: {
///                 resize: ["static", "expand"],
///                 size: [30, 30]
///             },
///         },
///     ],
/// }
/// ```

function BentoCreateFromJSON(_rootNode, _metadata = undefined, _parent = self)
{
    if (is_array(_rootNode))
    {
        var _array = [];
        var _i = 0;
        repeat(array_length(_rootNode))
        {
            array_push(_array, __BentoCreateViaJSONInner(_rootNode[_i], _metadata, _parent));
            ++_i;
        }
        
        return _array;
    }
    else
    {
        return __BentoCreateViaJSONInner(_rootNode, _metadata, _parent);
    }
}

/// @param json
/// @param parent
/// @param metadata

function __BentoCreateViaJSONInner(_json, _metadata, _parent)
{
    if (is_array(_json))
    {
        var _i = 0;
        repeat(array_length(_json))
        {
            __BentoCreateViaJSONInner(_json[_i], _metadata, _parent);
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
            
            if (not __BentoObjectInheritsFrom(_object, oBentoAncestor))
            {
                __BentoError($"Object \"{object_get_name(_object)}\" does not inherit from {object_get_name(oBentoAncestor)}");
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
                var _processor = BENTO_JSON_CHILDREN_STRING_PROCESSOR;
                if (is_callable(_processor))
                {
                    _children = _processor(_children, _metadata);
                }
                else
                {
                    __BentoError($".children was provided as a string but `BENTO_JSON_CHILDREN_STRING_PROCESSOR` is not a function");
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
                __BentoCreateViaJSONInner(_children, _metadata, _element);
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