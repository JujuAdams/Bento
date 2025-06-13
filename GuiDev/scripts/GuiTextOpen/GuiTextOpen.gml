// Feather disable all

/// @param initialText
/// @param callback
/// @param [element=self]

function GuiTextOpen(_initialText, _callback, _hostElement = self)
{
    static _system = __GuiSystem();
    static _textUseSteamKeyboard = __GuiSystem().__textUseSteamKeyboard;
    
    if (not GuiExists(_hostElement)) return;
    
    with(_hostElement.GUI_VARS.__layer.__environment)
    {
        if ((_system.__textHandlerEnvironment != undefined) && (_system.__textHandlerEnvironment != self))
        {
            __GuiTrace("Cannot open text input, another environment is already receiving text input");
            return;
        }
        
        if (__textElement == _hostElement)
        {
            if (__textHandler != undefined)
            {
                __textHandler.__callback = _callback;
            }
        }
        else
        {
            //There can only be one!
            if (__textHandler != undefined)
            {
                __textHandler.__Terminate(GUI_TEXT_INACTIVE);
            }
            
            __textElement = _hostElement;
            _system.__textHandlerEnvironment = self;
            
            //Unpack text config
            with(_hostElement.GUI_VARS.__textConfig)
            {
                var _maxLength      = __maxLength;
                var _caption        = __caption;
                var _keyboardType   = __keyboardType;
                var _returnKey      = __returnKey;
                var _capitalization = __capitalization;
                var _textPrediction = __textPrediction;
            }
            
            //All handler want to trim the initial text
            _initialText = string_copy(_initialText, 1, _maxLength);
            
            //If there's no forced mode then figure it out
            if (GUI_ON_MOBILE)
            {
                if (GUI_ON_IOS)
                {
                    __textHandler = new __GuiTextClassiOS(self, _initialText, _callback, _maxLength, _keyboardType, _returnKey, _capitalization, _textPrediction);
                }
                else
                {
                    __textHandler = new __GuiTextClassAndroid(self, _initialText, _callback, _maxLength, _keyboardType, _returnKey, _capitalization, _textPrediction);
                }
            }
            else if (GUI_ON_DESKTOP)
            {
                if (GUI_STEAMWORKS_SUPPORT && _textUseSteamKeyboard)
                {
                    __textHandler = new __GuiTextClassSteam(self, _initialText, _callback, _maxLength, _caption);
                }
                else
                {
                    __textHandler = new __GuiTextClassKeyboard(self, _initialText, _callback, _maxLength);
                }
            }
            else
            {
                __textHandler = new __GuiTextClassDialog(self, _initialText, _callback, _maxLength, _caption);
            }
            
            //Make sure our layer is updated
            __layerCurrent.__dirtyFlags |= __GUI_DIRTY_STEP | __GUI_DIRTY_HOVERABLE;
        }
    }
}