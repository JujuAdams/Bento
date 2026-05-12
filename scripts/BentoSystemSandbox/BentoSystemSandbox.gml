// Feather disable all

/// Convenience quick start function to get Bento up and running in your project using a typical
/// test configuration. This is provided to play around with Bento rather than as a serious tool.
/// 
/// N.B. This function should never be used in production. You should instead manage input, update
///      and drawing yourself by using the necessary functions.
/// 
/// @param x
/// @param y
/// @param width
/// @param height

function BentoSystemSandbox(_x, _y, _width, _height)
{
    //Lots of ugly state tracking. Given this is not meant for production I'm gonna leave it as is :)
    static _lastMouseX = undefined;
    static _lastMouseY = undefined;
    
    static _deviceLastInputMap = ds_map_create();
    static _deviceNewInputMap  = ds_map_create();
    
    static _lastDevice = undefined;
    static _threshold  = 0.3;
    
    if (event_type != ev_draw)
    {
        __BentoError("Must call `BentoSystemSandbox()` in one of the Draw events (Draw, Draw GUI etc.)");
    }
    
    //Force this silly feature off. This might break some mobile games
    device_mouse_dbclick_enable(false);
    
    ///////
    // Mouse detection
    ///////
    
    var _mouseMoved = false;
    
    //Grab the mouse position in the correct coordinate space
    if ((event_number == ev_gui) || (event_number == ev_gui_begin) || (event_number == ev_gui_end))
    {
        var _mouseX = device_mouse_x_to_gui(0);
        var _mouseY = device_mouse_y_to_gui(0);
    }
    else
    {
        var _mouseX = device_mouse_x(0);
        var _mouseY = device_mouse_y(0);
    }
    
    if ((_lastMouseX == undefined) || (_lastMouseY == undefined))
    {
        //First set - don't consider the mouse as moved
        _lastMouseX = _mouseX;
        _lastMouseY = _mouseY;
    }
    else if (point_distance(_mouseX, _mouseY, _lastMouseX, _lastMouseY) > 100)
    {
        //Only consider the mouse as moved if it has moved *a lot*
        
        _lastMouseX = _mouseX;
        _lastMouseY = _mouseY;
        
         _mouseMoved = true;
    }
    
    if (_mouseMoved || device_mouse_check_button(0, mb_any))
    {
        var _lastInput = _deviceLastInputMap[? -2] ?? -infinity;
        _deviceLastInputMap[? -2] = current_time;
        
        //Only swap to this device if we see a leading edge
        if (current_time - _lastInput > 100)
        {
            _deviceNewInputMap[? -2] = true;
        }
    }
    
    ///////
    // Keyboard detection
    ///////
    
    //Only respond to arrow key + space input, and only when not in text input
    if ((not BentoTextGetOpen())
    &&  (keyboard_check(vk_up)
      || keyboard_check(vk_down)
      || keyboard_check(vk_left)
      || keyboard_check(vk_right)
      || keyboard_check(vk_space)))
    {
        var _lastInput = _deviceLastInputMap[? -1] ?? -infinity;
        _deviceLastInputMap[? -1] = current_time;
        
        //Only swap to this device if we see a leading edge
        if (current_time - _lastInput > 100)
        {
            _deviceNewInputMap[? -1] = true;
        }
    }
    
    ///////
    // Gamepad detection
    ///////
    
    //Crude and simple gamepad input detector
    static _funcAnyInput = function(_device, _threshold)
    {
        return ((point_distance(0, 0, gamepad_axis_value(_device, gp_axislh), gamepad_axis_value(_device, gp_axislv)) > _threshold)
              || gamepad_button_check(_device, gp_face1)
              || gamepad_button_check(_device, gp_face2)
              || gamepad_button_check(_device, gp_face3)
              || gamepad_button_check(_device, gp_face4)
              || gamepad_button_check(_device, gp_padu)
              || gamepad_button_check(_device, gp_padd)
              || gamepad_button_check(_device, gp_padl)
              || gamepad_button_check(_device, gp_padr)
              || gamepad_button_check(_device, gp_start)
              || gamepad_button_check(_device, gp_select));
    }
    
    var _i = 0;
    repeat(gamepad_get_device_count())
    {
        if (gamepad_is_connected(_i))
        {
            if (_funcAnyInput(_i, _threshold))
            {
                var _lastInput = _deviceLastInputMap[? _i] ?? current_time;
                _deviceLastInputMap[? _i] = current_time;
                
                //Only swap to this device if we see a leading edge. This prevents hot swap to stuck gamepads
                if (current_time - _lastInput > 100)
                {
                    _deviceNewInputMap[? _i] = true;
                }
            }
            else
            {
                //Guarantee we have a valid timecode even if the gamepad isn't active
                if (not ds_map_exists(_deviceLastInputMap, _i))
                {
                    _deviceLastInputMap[? _i] = current_time;
                }
            }
        }
        else
        {
            //Wipe our memory of disconnected gamepads
            ds_map_delete(_deviceLastInputMap, _i);
        }
        
        ++_i;
    }
    
    if (current_time - (_deviceLastInputMap[? _lastDevice ?? -666] ?? -infinity) > 100)
    {
        if (_deviceNewInputMap[? -2]) //Mouse input
        {
            _lastDevice = -2;
        }
        else if (_deviceNewInputMap[? -1]) //Keyboard input
        {
            _lastDevice = -1;
        }
        else
        {
            //Iterate backwards to avoid picking up XInput devices that duplicate DInput devices
            var _i = gamepad_get_device_count()-1;
            repeat(gamepad_get_device_count())
            {
                if (_deviceNewInputMap[? _i])
                {
                    _lastDevice = _i;
                    break;
                }
                
                --_i;
            }
        }
    }
    
    //Swap input based on our device
    if (_lastDevice == -2)
    {
        BentoSetMode(BENTO_ON_MOBILE? BENTO_MODE_TOUCH : BENTO_MODE_MOUSE);
    }
    else if (_lastDevice == -1)
    {
        BentoSetMode(BENTO_MODE_KEYBOARD);
    }
    else if (_lastDevice != undefined)
    {
        BentoSetMode(BENTO_MODE_GAMEPAD);
    }
    
    if (BentoUsingPointer())
    {
        //Handles both mouse and touch input
        BentoInputPointer(_mouseX - _x, _mouseY - _y, device_mouse_check_button(0, mb_left));
        BentoInputHotkey(BENTO_HOTKEY_CANCEL, keyboard_check(vk_escape));
        
        if (BentoUsingMouse())
        {
            BentoInputHotkey(BENTO_HOTKEY_MOUSE_WHEEL_UP,   mouse_wheel_up());
            BentoInputHotkey(BENTO_HOTKEY_MOUSE_WHEEL_DOWN, mouse_wheel_down());
        }
    }
    else
    {
        if (BentoUsingKeyboard())
        {
            BentoInputNavigation(keyboard_check(vk_right) - keyboard_check(vk_left),
                                  keyboard_check(vk_down) - keyboard_check(vk_up),
                                  keyboard_check(vk_space));
            BentoInputHotkey(BENTO_HOTKEY_CANCEL, keyboard_check(vk_escape));
        }
        else if (BentoUsingGamepad())
        {
            if (_lastDevice != undefined)
            {
                BentoInputNavigation(gamepad_axis_value(_lastDevice, gp_axislh) + (gamepad_button_check(_lastDevice, gp_padr) - gamepad_button_check(_lastDevice, gp_padl)),
                                      gamepad_axis_value(_lastDevice, gp_axislv) + (gamepad_button_check(_lastDevice, gp_padd) - gamepad_button_check(_lastDevice, gp_padu)),
                                      gamepad_button_check(_lastDevice, gp_face1));
                BentoInputHotkey(BENTO_HOTKEY_CANCEL, gamepad_button_check(_lastDevice, gp_face2));
            }
        }
    }
    
    //Update the entire Bento system
    BentoSystemStep(_x, _y, _width, _height);
    
    //And then draw it
    BentoSystemDraw();
    
    //Make sure this map is fresh for next frame
    ds_map_clear(_deviceNewInputMap);
}