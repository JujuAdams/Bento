// Feather disable all

/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param outline

function draw_diamond(_left, _top, _right, _bottom, _outline)
{
    var _x = 0.5*(_left + _right);
    var _y = 0.5*(_top + _bottom);
    
    if (_outline)
    {
        draw_primitive_begin(pr_linestrip);
        draw_vertex(_x, _top);
        draw_vertex(_right, _y);
        draw_vertex(_x, _bottom);
        draw_vertex(_left, _y);
        draw_vertex(_x, _top);
        draw_primitive_end();
    }
    else
    {
        draw_primitive_begin(pr_trianglestrip);
        draw_vertex(_x, _top);
        draw_vertex(_right, _y);
        draw_vertex(_left, _y);
        draw_vertex(_x, _bottom);
        draw_primitive_end();
    }
}