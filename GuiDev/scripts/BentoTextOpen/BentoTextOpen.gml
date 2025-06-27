// Feather disable all

/// @param initialText
/// @param callback
/// @param [element=self]

function BentoTextOpen(_initialText, _callback, _hostElement = self)
{
    static _system = __BentoSystem();
    static _textUseSteamKeyboard = __BentoSystem().__textUseSteamKeyboard;
    
    if (not BentoExists(_hostElement)) return;
    
    with(_hostElement.BENTO_VARS.__layer.__environment)
    {
        if ((_system.__textHandlerEnvironment != undefined) && (_system.__textHandlerEnvironment != self))
        {
            __BentoTrace("Cannot open text input, another environment is already receiving text input");
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
                __textHandler.__Terminate(BENTO_TEXT_INACTIVE);
            }
            
            __textElement = _hostElement;
            _system.__textHandlerEnvironment = self;
            
            //Unpack text config
            with(_hostElement.BENTO_VARS.__textConfig)
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
            
            if (BENTO_ON_MOBILE)
            {
                if (BENTO_ON_IOS)
                {
                    __textHandler = new __BentoTextClassiOS(self, _initialText, _callback, _maxLength, _keyboardType, _returnKey, _capitalization, _textPrediction);
                }
                else
                {
                    __textHandler = new __BentoTextClassAndroid(self, _initialText, _callback, _maxLength, _keyboardType, _returnKey, _capitalization, _textPrediction);
                }
            }
            else if (BENTO_ON_DESKTOP)
            {
                if (BENTO_STEAMWORKS_SUPPORT && _textUseSteamKeyboard)
                {
                    __textHandler = new __BentoTextClassSteam(self, _initialText, _callback, _maxLength, _caption);
                }
                else
                {
                    __textHandler = new __BentoTextClassKeyboard(self, _initialText, _callback, _maxLength);
                }
            }
            else
            {
                __textHandler = new __BentoTextClassDialog(self, _initialText, _callback, _maxLength, _caption);
            }
            
            //Make sure our layer is updated
            __layerCurrent.__dirtyFlags |= __BENTO_DIRTY_STEP | __BENTO_DIRTY_HOVERABLE;
        }
    }
}