// This script contains definitions that bind native GameMaker functions to functions that can
// be executed using BentoScript in external UI definition files.
// 
// YOU SHOULD EDIT AND EXPAND THIS SCRIPT TO SUIT YOUR NEEDS

if (script_execute_ext(min, [2, 1]) == 2) //Hm... something's not right
{
    //Works around a bug in GameMaker LTS
    BentoAddFunction("min",   function(_a, _b) { return min(_a, _b); });
    BentoAddFunction("max",   function(_a, _b) { return max(_a, _b); });
    BentoAddFunction("clamp", function(_a, _b, _c) { return clamp(_a, _b, _c); });
    BentoAddFunction("lerp",  function(_a, _b, _c) { return lerp(_a, _b, _c); });
}
else
{
    BentoAddNativeFunction(min);
    BentoAddNativeFunction(max);
    BentoAddNativeFunction(clamp);
    BentoAddNativeFunction(lerp);
}

BentoAddNativeFunction(dsin);
BentoAddNativeFunction(dcos);
BentoAddNativeFunction(dtan);
BentoAddNativeFunction(sin);
BentoAddNativeFunction(cos);
BentoAddNativeFunction(tan);
BentoAddNativeFunction(floor);
BentoAddNativeFunction(ceil);
BentoAddNativeFunction(round);
BentoAddNativeFunction(abs);
BentoAddNativeFunction(sign);
BentoAddNativeFunction(string);
BentoAddNativeFunction(is_struct);
BentoAddNativeFunction(is_array);
BentoAddNativeFunction(is_string);
BentoAddNativeFunction(is_numeric);
BentoAddNativeFunction(array_length);
BentoAddNativeFunction(array_push);
BentoAddNativeFunction(array_pop);
BentoAddNativeFunction(array_insert);
BentoAddNativeFunction(array_delete);
BentoAddNativeFunction(draw_rectangle);
BentoAddNativeFunction(draw_circle);
BentoAddNativeFunction(draw_text);
BentoAddNativeFunction(draw_text_ext);
BentoAddNativeFunction(draw_sprite);
BentoAddNativeFunction(draw_sprite_ext);
BentoAddNativeFunction(draw_sprite_stretched);
BentoAddNativeFunction(draw_sprite_stretched_ext);

BentoAddFunction("Time", function() { return current_time; });