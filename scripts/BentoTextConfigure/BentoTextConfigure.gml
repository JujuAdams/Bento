// Feather disable all

/// Configures text input for the host element. This function does not start text input per se
/// (please use `BentoTextOpen()` for that) but it is important in setting up the desired
/// interaction rules. Most of the settings that this function exposes are only relevant on
/// certain platforms.
///
/// `maxLength`
///  Platforms: All
///  Default value: 300
///     The maximum length string that text input can receive. There is a further length cap on iOS
///     of 1,000 characters due to wonky text input behavior on that platform.
/// 
/// `caption`
///  Platforms: Steam Deck, PlayStation, Xbox, Switch
///  Default value: ""
///     The caption to show on the OS text input dialog box.
/// 
/// `keyboardType`
///  Platforms: Android, iOS, tvOS
///  Default value: `kbv_type_default`
///   Sets the keyboard type to show. The value should be one of tne of the `kbv_type_*` constants.
/// 
/// `returnKey`
///  Platforms: Android, iOS, tvOS
///  Default value: `kbv_returnkey_default`
///   Sets the label on the return key / confirm button. The value should be one of tne of the
///   `kbv_returnkey_*` constants.
/// 
/// `capitalization`
///  Platforms: Android, iOS, tvOS
///  Default value: `kbv_autocapitalize_none`
///   Sets whether autocapitalization should be enabled. The value should be one of tne of the
///   `kbv_autocapitalize_*` constants.
/// 
/// `textPrediction`
///  Platforms: Android, iOS, tvOS
///  Default value: `false`
///   Sets whether text prediction should be enabled.
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
    with(_hostElement.BENTO_VARS.__textConfig)
    {
        __maxLength      = _maxLength;
        __caption        = _caption;
        __keyboardType   = _keyboardType;
        __returnKey      = _returnKey;
        __capitalization = _capitalization;
        __textPrediction = _textPrediction;
    }
}