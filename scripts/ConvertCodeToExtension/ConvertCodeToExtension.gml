/// @param yypPath
/// @param assetFolder
/// @param [excludeAssetArray]

function ConvertCodeToExtension(_yypPath, _assetFolder, _excludeAssetArray = [])
{
    var _excludeAssetMap = ds_map_create();
    
    var _i = 0;
    repeat(array_length(_excludeAssetArray))
    {
        _excludeAssetMap[? _excludeAssetArray[_i]] = true;
        ++_i;
    }
    
    var _assetFolderString = $"folders/{_assetFolder}/";
    var _assetFolderStringLength = string_length(_assetFolderString);
    var _assetFolderStringAlt = $"folders/{_assetFolder}.yy";
    var _assetFolderStringAltLength = string_length(_assetFolderStringAlt);
    
    var _buffer = buffer_load(_yypPath);
    var _jsonString = buffer_read(_buffer, buffer_text);
    buffer_delete(_buffer);
    var _yypJSON = json_parse(_jsonString);
    
    var _projectDirectory = filename_dir(_yypPath) + "/";
    
    var _resourcesArray = _yypJSON.resources;
    var _i = 0;
    repeat(array_length(_resourcesArray))
    {
        var _resourceData = _resourcesArray[_i].id;
        if (not ds_map_exists(_excludeAssetMap, _resourceData.name))
        {
            var _path = _resourceData.path;
            if (string_copy(_path, 1, 8) == "scripts/")
            {
                var _buffer = buffer_load(_projectDirectory + filename_change_ext(_path, ".yy"));
                var _jsonString = buffer_read(_buffer, buffer_string);
                buffer_delete(_buffer);
                
                var _yyJSON = json_parse(_jsonString);
                if ((string_copy(_yyJSON.parent.path, 1, _assetFolderStringLength) == _assetFolderString)
                ||  (string_copy(_yyJSON.parent.path, 1, _assetFolderStringAltLength) == _assetFolderStringAlt))
                {
                    var _buffer = buffer_load(_projectDirectory + filename_change_ext(_path, ".gml"));
                    __ProcessGMLBuffer(_buffer);
                    buffer_delete(_buffer);
                }
            }
        }
        
        ++_i;
    }
    
    ds_map_destroy(_excludeAssetMap);
}

function __ProcessGMLBuffer(_buffer)
{
    var _bufferSize = buffer_get_size(_buffer);
    buffer_seek(_buffer, buffer_seek_start, 0);
    
    var _functionEndPos   = -1;
    var _functionStartPos = undefined;
    
    while(buffer_tell(_buffer) < _bufferSize)
    {
        var _byte = buffer_read(_buffer, buffer_u8);
        
        if ((_byte == ord("/")) && (buffer_peek(_buffer, buffer_tell(_buffer), buffer_u8) == ord("/")))
        {
            buffer_seek(_buffer, buffer_seek_relative, 1);
            __ReadOverLineComment(_buffer);
        }
        if ((_byte == ord("/")) && (buffer_peek(_buffer, buffer_tell(_buffer), buffer_u8) == ord("*")))
        {
            buffer_seek(_buffer, buffer_seek_relative, 1);
            __ReadOverBlockComment(_buffer);
        }
        else if (_byte == ord("\""))
        {
            __ReadOverString(_buffer);
        }
        else if ((_byte == ord("$")) && (buffer_peek(_buffer, buffer_tell(_buffer), buffer_u8) == ord("\"")))
        {
            buffer_seek(_buffer, buffer_seek_relative, 1);
            __ReadOverTemplateString(_buffer);
        }
        else if (_byte == ord("{"))
        {
            var _functionPrevEndPos = _functionEndPos+1;
            _functionStartPos = buffer_tell(_buffer)-1;
            __ReadOverCode(_buffer);
            _functionEndPos = buffer_tell(_buffer)-1;
            
            buffer_poke(_buffer, _functionStartPos, buffer_u8, 0x00);
            buffer_poke(_buffer, _functionEndPos, buffer_u8, 0x00);
            
            var _functionHeaderString = buffer_peek(_buffer, _functionPrevEndPos, buffer_string);
            var _functionBodyString = buffer_peek(_buffer, _functionStartPos+1, buffer_string);
            
            show_debug_message("==============================================================================================================================");
            show_debug_message(_functionHeaderString);
            show_debug_message("==============================================================================================================================");
            show_debug_message(_functionBodyString);
            show_debug_message("==============================================================================================================================");
        }
    }
}

function __ReadOverLineComment(_buffer)
{
    var _bufferSize = buffer_get_size(_buffer);
    while(buffer_tell(_buffer) < _bufferSize)
    {
        var _byte = buffer_read(_buffer, buffer_u8);
        if (_byte == ord("\n"))
        {
            break;
        }
    }
}

function __ReadOverBlockComment(_buffer)
{
    var _bufferSize = buffer_get_size(_buffer);
    while(buffer_tell(_buffer) < _bufferSize)
    {
        var _byte = buffer_read(_buffer, buffer_u8);
        if ((_byte == ord("*")) && (buffer_peek(_buffer, buffer_tell(_buffer), buffer_u8) == ord("/")))
        {
            buffer_seek(_buffer, buffer_seek_relative, 1);
            break;
        }
    }
}

function __ReadOverString(_buffer)
{
    var _bufferSize = buffer_get_size(_buffer);
    while(buffer_tell(_buffer) < _bufferSize)
    {
        var _byte = buffer_read(_buffer, buffer_u8);
        if ((_byte == ord("\"")) && (buffer_peek(_buffer, buffer_tell(_buffer)-2, buffer_u8) != ord("\\")))
        {
            break;
        }
    }
}

function __ReadOverTemplateString(_buffer)
{
    var _bufferSize = buffer_get_size(_buffer);
    while(buffer_tell(_buffer) < _bufferSize)
    {
        var _byte = buffer_read(_buffer, buffer_u8);
        if ((_byte == ord("{")) && (buffer_peek(_buffer, buffer_tell(_buffer)-2, buffer_u8) != ord("\\")))
        {
            __ReadOverCode(_buffer);
        }
        else if ((_byte == ord("\"")) && (buffer_peek(_buffer, buffer_tell(_buffer)-2, buffer_u8) != ord("\\")))
        {
            break;
        }
    }
}

function __ReadOverCode(_buffer)
{
    var _braceCount = 1;
    
    var _bufferSize = buffer_get_size(_buffer);
    while(buffer_tell(_buffer) < _bufferSize)
    {
        var _byte = buffer_read(_buffer, buffer_u8);
        if (_byte == ord("{"))
        {
            ++_braceCount;
        }
        else if (_byte == ord("}"))
        {
            --_braceCount;
            
            if (_braceCount <= 0)
            {
                break;
            }
        }
        else if ((_byte == ord("/")) && (buffer_peek(_buffer, buffer_tell(_buffer), buffer_u8) == ord("/")))
        {
            buffer_seek(_buffer, buffer_seek_relative, 1);
            __ReadOverLineComment(_buffer);
        }
        if ((_byte == ord("/")) && (buffer_peek(_buffer, buffer_tell(_buffer), buffer_u8) == ord("*")))
        {
            buffer_seek(_buffer, buffer_seek_relative, 1);
            __ReadOverBlockComment(_buffer);
        }
        else if (_byte == ord("\""))
        {
            __ReadOverString(_buffer);
        }
        else if ((_byte == ord("$")) && (buffer_peek(_buffer, buffer_tell(_buffer), buffer_u8) == ord("\"")))
        {
            buffer_seek(_buffer, buffer_seek_relative, 1);
            __ReadOverTemplateString(_buffer);
        }
    }
}