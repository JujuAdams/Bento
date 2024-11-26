// Feather disable all

function __GuiClassDirectionalState() constructor
{
    __prevPositive = false;
    __prevNegative = false;
    
    __direction = 0;
    __stage     = 0;
    __count     = 0;
    __pressTime = -infinity;
    
    __output = 0;
    
    static __Update = function(_inputDirection, _frame)
    {
        static _system = __GuiSystem();
        
        var _positive = sign(_inputDirection) > 0;
        var _negative = sign(_inputDirection) < 0;
        
        if (_positive && (not __prevPositive))
        {
            __direction = 1;
            __pressTime = _frame;
            __stage     = 0;
            __count     = 0;
            __output    = 0;
        }
        else if (_negative && (not __prevNegative))
        {
            __direction = -1;
            __pressTime = _frame;
            __stage     = 0;
            __count     = 0;
            __output    = 0;
        }
        else if ((not _positive) && (not _negative))
        {
            __direction = 0;
            __stage     = 0;
            __count     = 0;
            __output    = 0;
        }
        
        if (__direction != 0)
        {
            if (__stage == 0)
            {
                if (((__pressTime - _frame) mod _system.__directionalNavPreDelay) == 0)
                {
                    __output = __direction;
                    
                    ++__count;
                    if (__count >= 2)
                    {
                        __pressTime = _frame;
                        ++__stage;
                        __count = 0;
                    }
                }
                else
                {
                    __output = 0;
                }
            }
            else if (__stage == 1)
            {
                if (((__pressTime - _frame) mod _system.__directionalNavDelay) == 0)
                {
                    __output = __direction;
                    
                    ++__count;
                    if (__count >= _system.__directionalNavDelayCount)
                    {
                        __pressTime = _frame;
                        ++__stage;
                        __count = 0;
                    }
                }
                else
                {
                    __output = 0;
                }
            }
            else if (__stage == 2)
            {
                if (((__pressTime - _frame) mod _system.__directionalNavDelayShorter) == 0)
                {
                    __output = __direction;
                }
                else
                {
                    __output = 0;
                }
            }
        }
        
        __prevPositive = _positive;
        __prevNegative = _negative;
    }
}