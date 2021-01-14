function bento_group_reset()
{
    bento_group = undefined;
    ds_stack_clear(global.__bento_group_stack);
}