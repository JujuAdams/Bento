// Feather disable all

function __BentoClassTurbo() constructor
{
    __prevActive = false;
    
    __stage     = 0;
    __count     = 0;
    __pressTime = -infinity;
    
    __outputX = 0;
    __outputY = 0;
    
    static __Update = function(_dX, _dY, _frame)
    {
        static _system = __BentoSystem();
        
        if (abs(_dX) < 0.001)
        {
            _dX = 0;
        }
        
        if (abs(_dY) < 0.001)
        {
            _dY = 0;
        }
        
        if ((_dX == 0) && (_dY == 0))
        {
            __prevActive = false;
            
            __stage   = 0;
            __count   = 0;
            __outputX = 0;
            __outputY = 0;
        }
        else
        {
            if (not __prevActive)
            {
                __prevActive = true;
                
                //Last frame wasn't active - reset values
                __pressTime = _frame;
                __stage     = 0;
                __count     = 0;
                
                //First press output value is precise to the thumbstick position
                __outputX = _dX;
                __outputY = _dY;
            }
            else
            {
                //Lock off subsequent retriggers to 45 degrees
                var _angle = point_direction(0, 0, _dX, _dY);
                _angle = 45*floor((_angle + 22.5) / 45);
               _dX =  dcos(_angle);
               _dY = -dsin(_angle);
                
                if (abs(_dX) < 0.001)
                {
                    _dX = 0;
                }
                
                if (abs(_dY) < 0.001)
                {
                    _dY = 0;
                }
                
                //Default to no output, we'll override this if necessary
                __outputX = 0;
                __outputY = 0;
            }
            
            if (__stage == 0)
            {
                //Waiting for the first retrigger to fire off
                if (((__pressTime - _frame) mod _system.__globalDirPreDelay) == 0)
                {
                    __outputX = _dX;
                    __outputY = _dY;
                    
                    ++__count;
                    if (__count >= 2) //First press counts so we want to start retriggering on the second increment
                    {
                        __pressTime = _frame;
                        ++__stage;
                        __count = 0;
                    }
                }
            }
            else if (__stage == 1)
            {
                //Slow repeat until we reach the target count
                if (((__pressTime - _frame) mod _system.__globalDirDelay) == 0)
                {
                    __outputX = _dX;
                    __outputY = _dY;
                    
                    ++__count;
                    if (__count >= _system.__globalDirDelayCount)
                    {
                        __pressTime = _frame;
                        ++__stage;
                        __count = 0;
                    }
                }
            }
            else if (__stage == 2)
            {
                //Fast repeat forever
                if (((__pressTime - _frame) mod _system.__globalDirDelayShorter) == 0)
                {
                    __outputX = _dX;
                    __outputY = _dY;
                }
            }
        }
    }
}