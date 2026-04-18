// Feather disable all

// This object is the common ancestor for all object-based Bento elements. All objects that you
// intend to work with Bento (i.e. to be created by `BentoCreate()`) **must** inherit from
// `oBentoAncestor`.

// Check we've been created correctly.
var _system = __BentoSystem();
if (_system.__creatingObject)
{
    var _parent = _system.__tempParent;
}
else
{
    if (BENTO_REQUIRE_CREATE)
    {
        __BentoError("Bento instances must be created with `BentoCreate()`");
    }
    else
    {
        var _parent = BentoLayerGetRoot();
    }
}

// These variables give the position of various parts of this element in worldspace. They're
// read-only in the sense that they are liable to get overwritten by the library at unexpected
// times.

bentoLeft   = x - (sprite_exists(sprite_index)? sprite_get_xoffset(sprite_index) : 0);
bentoTop    = y - (sprite_exists(sprite_index)? sprite_get_yoffset(sprite_index) : 0);
bentoRight  = bentoLeft + sprite_width;
bentoBottom = bentoTop + sprite_height;
bentoX      = x;
bentoY      = y;
bentoWidth  = sprite_width;
bentoHeight = sprite_height;

// Bento instances are expected to persist between rooms.
persistent = true;

// Make a struct to contain Bento-related variables. This keeps the instance clean in the debugger.
BENTO_VARS = new __BentoClassVariables(self);

// Set the parent before going to the Create event for the element.
BentoSetParent(_parent, self);