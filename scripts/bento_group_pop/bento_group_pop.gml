function bento_group_pop()
{
    ds_stack_pop(global.__bento_group_stack);
    bento_group = ds_stack_top(global.__bento_group_stack);
}