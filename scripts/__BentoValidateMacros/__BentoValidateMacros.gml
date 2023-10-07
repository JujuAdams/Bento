function __BentoValidateMacros()
{
    if (!is_string(BENTO_DEFAULT_BUTTON_NAME) && !is_undefined(BENTO_DEFAULT_BUTTON_NAME))
    {
        __BentoError("BENTO_DEFAULT_BUTTON_NAME must be a string or undefined");
    }
    
    if (!is_numeric(BENTO_DEFAULT_FONT) || !font_exists(BENTO_DEFAULT_FONT))
    {
        __BentoError("BENTO_DEFAULT_FONT must be a font");
    }
    
    if ((BENTO_HOT_RELOAD_MODE != 0) && (BENTO_HOT_RELOAD_MODE != 1) && (BENTO_HOT_RELOAD_MODE != 2))
    {
        __BentoError("BENTO_HOT_RELOAD_MODE must be 0, 1, or 2");
    }
    
    if (!is_numeric(BENTO_HOT_RELOAD_SCAN_PERIOD_IN_FOCUS) || (BENTO_HOT_RELOAD_SCAN_PERIOD_IN_FOCUS < 0))
    {
        __BentoError("BENTO_HOT_RELOAD_SCAN_PERIOD_IN_FOCUS must be a number greater than 0");
    }
    
    if (!is_numeric(BENTO_HOT_RELOAD_SCAN_PERIOD_OUT_OF_FOCUS) || (BENTO_HOT_RELOAD_SCAN_PERIOD_OUT_OF_FOCUS < 0))
    {
        __BentoError("BENTO_HOT_RELOAD_SCAN_PERIOD_OUT_OF_FOCUS must be a number greater than 0");
    }
    
    if ((BENTO_REPORT_LEVEL != 0) && (BENTO_REPORT_LEVEL != 1) && (BENTO_REPORT_LEVEL != 2))
    {
        __BentoError("BENTO_REPORT_LEVEL must be 0, 1, or 2");
    }
    
    if (!is_method(BENTO_TRACE) && (not (is_numeric(BENTO_TRACE) && script_exists(BENTO_TRACE))))
    {
        __BentoError("BENTO_TRACE must be a script or method");
    }
}