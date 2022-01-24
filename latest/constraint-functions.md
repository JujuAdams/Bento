# Constraint Functions

&nbsp;

## `BentoConstraintRequire(expression, ...)`

**Returns:** N/A (`undefined`)

|Name        |Datatype|Purpose                                                                                                        |
|------------|--------|---------------------------------------------------------------------------------------------------------------|
|`expression`|string  |Expression to use for the constraint                                                                           |
|`...`       |string  |Further expression(s) to apply                                                                                 |

Strongest possible constraint. This should generally only be used for critical functionality-related constraints such as preventing buttons from being placed outside of the visible portion of the screen.

&nbsp;

## `BentoConstraint(expression, ...)`

**Returns:** N/A (`undefined`)

|Name        |Datatype|Purpose                                                                                                        |
|------------|--------|---------------------------------------------------------------------------------------------------------------|
|`expression`|string  |Expression to use for the constraint                                                                           |
|`...`       |string  |Further expression(s) to apply                                                                                 |

Middle-weight constraint. Useful for describing firm relationships which should hold unless something has gone wrong.

&nbsp;

## `BentoConstraintWeak(expression, ...)`

**Returns:** N/A (`undefined`)

|Name        |Datatype|Purpose                                                                                                        |
|------------|--------|---------------------------------------------------------------------------------------------------------------|
|`expression`|string  |Expression to use for the constraint                                                                           |
|`...`       |string  |Further expression(s) to apply                                                                                 |

Weakest type of constraint. 

&nbsp;

## `BentoSuggest(expression, ...)`

**Returns:** N/A (`undefined`)

|Name        |Datatype|Purpose                                                                                                        |
|------------|--------|---------------------------------------------------------------------------------------------------------------|
|`expression`|string  |Expression to use for the suggested value                                                                      |
|`...`       |string  |Further expression(s) to apply                                                                                 |

Allows the suggestion of a fixed value for a property.

?> Only `=` operators may be used for expressions defined using `BentoSuggest()`.

&nbsp;

## `BentoTemplateSprite(sprite, [keepAspectRatio=true], [scale=1])`

**Returns:** N/A (`undefined`)

|Name               |Datatype    |Purpose                                                                                       |
|-------------------|------------|----------------------------------------------------------------------------------------------|
|`sprite`           |sprite index|Sprite to read width and height information from                                              |
|`[keepAspectRatio]`|boolean     |Optional. Whether to ensure the aspect ratio of the box remaining constant. Defaults to `true`|
|`[scale]`          |number      |Optional. Suggested scale for the sprite. Defaults to `1`                                     |

This function is provided for convenience and allows a box to have its width and height set to that of a sprite. Calling this function is equivalent to calling the following code:

```JS
//Suggest a fixed width and height for the sprite
var width  = sprite_get_height(sprite);
var height = sprite_get_height(sprite);
BentoSuggest("width = " + string(width), "height = " + string(height));

if (keepAspectRatio)
{
    //If we want to keep a fixed aspect ratio, also add a constraint to ensure that
    var _aspectRatio = _width / _height;
    BentoConstraint("width = " + string(_aspectRatio) + "*height");
}
```
