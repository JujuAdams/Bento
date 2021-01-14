/// @param [group]

#macro bento_group   global.__bento_group

global.__bento_group = undefined;
global.__bento_group_stack = ds_stack_create();

function bento_group_push()
{
    bento_group = ((argument_count > 0) && (argument[0] != undefined))? argument[0] : new bento_class_group();
    ds_stack_push(global.__bento_group_stack, bento_group);
    return bento_group;
}