/// Endpoint for the BentoScript function DebugBreakpoint(). Place a GameMaker native breakpoint in
/// the function to help pause BentoScript execution.

function BentoDebugBreakpoint()
{
    static _counter = 0;
    
    if (debug_mode)
    {
        if (BENTO_REPORT_LEVEL > 1)
        {
            __BentoTrace("BentoDebugBreakpoint ", _counter, " =    ", debug_get_callstack());
            debug_event("BentoDebugBreakpoint ", _counter);
            ++_counter;
        }
    }
}