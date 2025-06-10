// Feather disable all

/// @param initialText
/// @param callback
/// @param [element=self]

function GuiTextOpen(_initialText, _callback, _hostElement = self)
{
    static _textUseSteamKeyboard = __GuiSystem().__textUseSteamKeyboard;
    
    if (not GuiExists(_hostElement)) return;
    
    with(_hostElement.GUI_VARS.__layer.__environment)
    {
        //TODO - Make text input exclusive in global scope across environments
        
        if (__textElement != _hostElement)
        {
            //There can only be one!
            if (__textHandler != undefined)
            {
                __textHandler.__Terminate(GUI_TEXT_INACTIVE);
            }
            
            __textElement = _hostElement;
            
            //Unpack text config
            with(_hostElement.GUI_VARS.__textConfig)
            {
                var _maxLength      = __maxLength;
                var _caption        = __caption;
                var _mode           = __mode;
                var _keyboardType   = __keyboardType;
                var _returnKey      = __returnKey;
                var _capitalization = __capitalization;
                var _textPrediction = __textPrediction;
            }
            
            //All handler want to trim the initial text
            _initialText = string_copy(_initialText, 1, _maxLength);
            
            //If there's no forced mode then figure it out
            if (_mode == undefined)
            {
                if (GUI_ON_MOBILE)
                {
                    _mode = GUI_TEXT_MODE_MOBILE;
                }
                else if (GUI_ON_DESKTOP)
                {
                    _mode = (GUI_STEAMWORKS_SUPPORT && _textUseSteamKeyboard)? GUI_TEXT_MODE_STEAM : GUI_TEXT_MODE_KEYBOARD;
                }
                else
                {
                    _mode = GUI_TEXT_MODE_MOBILE;
                }
            }
            
            //Make a new handler
            switch(_mode)
            {
                case GUI_TEXT_MODE_KEYBOARD: __textHandler = new __GuiTextClassKeyboard(self, _initialText, _callback, _maxLength); break;
                case GUI_TEXT_MODE_MOBILE:   __textHandler = new __GuiTextClassMobile(  self, _initialText, _callback, _maxLength, _keyboardType, _returnKey, _capitalization, _textPrediction); break;
                case GUI_TEXT_MODE_DIALOG:   __textHandler = new __GuiTextClassDialog(  self, _initialText, _callback, _maxLength, _caption); break;
                case GUI_TEXT_MODE_STEAM:    __textHandler = new __GuiTextClassSteam(   self, _initialText, _callback, _maxLength, _caption); break;
                
                default:
                    __GuiError($"Invalid mode provided ({_mode})");
                break;
            }
        }
    }
}