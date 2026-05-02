// Feather disable all

/// Starts text input, targeting the given element. Only one element may be targeted for text input
/// globally across all Bento environments. Text input will automatically close on most platforms
/// but on desktop platforms (Windows, MacOS, Linux) where direct text input from a keyboard is
/// supported, you will need to detect user input and then call `BentoTextClose()` as is
/// appropriate.
/// 
/// N.B. Elements that are receiving text input by calling `BentoTextOpen()` will override focus
///      rules whilst text input is open.
/// 
/// N.B. When receiving text input on desktop (and not using Steam's keyboard), text input will
///      automatically close if there has been no keyboard input for 10 seconds. This ensures that
///      your game won't lock up if there are issues with input (such as a gamepad disconnecting).
/// 
/// The `callback` argument must be provided when calling this function. The callback will be
/// executed whenever text changes. The callback will also be executed when text input has been
/// closed by the OS on non-desktop platforms (consoles and mobile devices etc.).
/// 
/// The callback will be executed with two arguments: the new text that has been inputted, and the
/// text input state (in that order). The text input state will be one of the following constants;
/// 
/// `BENTO_TEXT_PENDING`
///     Text input is on-going.
/// 
/// `BENTO_TEXT_CONFIRM`
///     The user has confirmed text input e.g. by pressing the return key on the onscreen keyboard.
/// 
/// `BENTO_TEXT_ABORT`
///     The user has aborted text input e.g. by pressing the back button on the touchscreen.
/// 
/// `BENTO_TEXT_ERROR`
///     Aan upstream error has occurred causing text input to fail.
/// 
/// `BENTO_TEXT_INACTIVE`
///     The text input subsystem is inactive and no element is being targeted. This state shouldn't
///     be passed but you should still handle it in case of a programming error.
/// 
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