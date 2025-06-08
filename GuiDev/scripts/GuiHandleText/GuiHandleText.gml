// Feather disable all

/// The optional `forceMode` parameter should be one of the `GUI_TEXT_MODE_*` constants. If this
/// parameter is not provided (or set to `undefined`) then a suitable mode will be chosen for you.
///
/// `mobileSettings` should be a struct. The provided struct can optionally contain the following
/// variables:
/// 
/// .keyboardType
///   Sets the keyboard type to show. The value should be one of tne of the `kbv_type_*` constants.
///   Defaults to `kbv_type_default`.
/// 
/// .returnKey
///   Sets the label on the return key / confirm button. The value should be one of tne of the
///   `kbv_returnkey_*` constants. Defaults to `kbv_returnkey_default`.
/// 
/// .capitalization
///   Sets whether autocapitalization should be enabled. The value should be one of tne of the
///   `kbv_autocapitalize_*` constants. Defaults to `kbv_autocapitalize_none`.
/// 
/// .textPrediction
///   Sets whether text prediction should be enabled. Defaults to `false`.
/// 
/// @param [initialText=""]
/// @param [maxLength=300]
/// @param [caption=""]
/// @param [forceMode]
/// @param [mobileSettings]
/// @param [element=self]

function GuiHandleText(_initialText = "", _maxLength = 300, _caption = "", _mode = undefined, _mobileSettings = {}, _hostElement = self)
{
    static _textSystem = __GuiSystem().__textContainer;
    
    var _returnText = _initialText;
    
    with(_textSystem)
    {
        if (GuiPrimaryGetClick(_hostElement))
        {
            if (__hostElement == undefined)
            {
                if (__handler != undefined)
                {
                    __handler.__Terminate(GUI_TEXT_INACTIVE);
                }
                
                GuiFocusOpen(GUI_FOCUS_POINTER_CANCEL_ON_CLICK, _hostElement);
                __hostElement = _hostElement;
                
                if (_mode == undefined)
                {
                    if (GUI_ON_MOBILE)
                    {
                        _mode = GUI_TEXT_MODE_MOBILE;
                    }
                    else if (GUI_ON_DESKTOP)
                    {
                        _mode = (GUI_STEAMWORKS_SUPPORT && __useSteamKeyboard)? GUI_TEXT_MODE_STEAM : GUI_TEXT_MODE_KEYBOARD;
                    }
                    else
                    {
                        _mode = GUI_TEXT_MODE_MOBILE;
                    }
                }
                
                switch(_mode)
                {
                    case GUI_TEXT_MODE_KEYBOARD: __handler = new __GuiTextClassKeyboard(_initialText, _maxLength);                break;
                    case GUI_TEXT_MODE_MOBILE:   __handler = new __GuiTextClassMobile(_initialText, _maxLength, _mobileSettings); break;
                    case GUI_TEXT_MODE_DIALOG:   __handler = new __GuiTextClassDialog(_initialText, _caption, _maxLength);        break;
                    case GUI_TEXT_MODE_STEAM:    __handler = new __GuiTextClassSteam(_initialText, _caption, _maxLength);         break;
                }
                
                return _returnText;
            }
        }
        
        if (__handler != undefined)
        {
            if (GuiExists(__hostElement))
            {
                if (GuiFocusGetTop(GuiGetLayer(__hostElement)) == __hostElement)
                {
                    _returnText = __text;
                }
                else
                {
                    __handler.__Terminate(GUI_TEXT_INACTIVE);
                }
            }
        }
    }
    
    return _returnText;
}