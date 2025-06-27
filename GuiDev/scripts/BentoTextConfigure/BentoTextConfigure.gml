// Feather disable all

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
/// @param [maxLength=300]
/// @param [caption=""]
/// @param [keyboardType]
/// @param [returnKey]
/// @param [capitalization]
/// @param [textPrediction]
/// @param [element=self]

function BentoTextConfigure(_maxLength = 300, _caption = "", _keyboardType = kbv_type_default, _returnKey = kbv_returnkey_default, _capitalization = kbv_autocapitalize_none, _textPrediction = false, _hostElement = self)
{
    if (not BentoExists(_hostElement)) return;
    with(_hostElement.GUI_VARS.__textConfig)
    {
        __maxLength      = _maxLength;
        __caption        = _caption;
        __keyboardType   = _keyboardType;
        __returnKey      = _returnKey;
        __capitalization = _capitalization;
        __textPrediction = _textPrediction;
    }
}