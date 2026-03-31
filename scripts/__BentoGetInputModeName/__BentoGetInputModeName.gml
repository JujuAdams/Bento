/// @param mode

function __BentoGetInputModeName(_mode)
{
    if (_mode == BENTO_MODE_MOUSE)
    {
        return "`BENTO_MODE_MOUSE`";
    }
    else if (_mode == BENTO_MODE_KEYBOARD)
    {
        return "`BENTO_MODE_KEYBOARD`";
    }
    else if (_mode == BENTO_MODE_GAMEPAD)
    {
        return "`BENTO_MODE_GAMEPAD`";
    }
    else if (_mode == BENTO_MODE_TOUCH)
    {
        return "`BENTO_MODE_TOUCH`";
    }
    else
    {
        return "<unsupported>";
    }
}