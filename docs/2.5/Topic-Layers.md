# Layouts

Bento builds user interfaces [within a tree](Topic-Principles?id=bento-grows-on-trees):

```
system
╰─ environment
   ├─ layer A
   │  ╰─ root element
   │     ├─ element
   │     │  ├─ element
   │     │  ╰─ element
   │     ╰─ ...
   ├─ layer B
   ╰─ ...
```

Layers exist inside environments. You can have any number of layers in an environment but layers must have a unique name (per environment).

Layers are drawn in the order they appear in the tree from front to back. `layer A` will be drawn below `layer B` in the example above. Only the layer drawn last and on top (which is typically the most recently created layer) can receive player input. Any other layer is considered "backgrounded". Backgrounded layers will usually not execute any update code (that's [User Event 0](Topic-Building-Elements)) but will continue to draw themselves using the other user events. In the above example, `layer A` is backgrounded and cannot be interacted with and `layer B` is in the foreground and will operate as normal. You can reorder layers as you see fit to control which layer is drawn last and thus receiving input.

Each layer has precisely one root element. Other than never having any sibling elements, the root element behaves like any other element. You may create further elements as children of the root element, and those elements may have children, and so on. Root elements cannot be destroyed. Root elements further have their offset and dimensions set when `BentoSystemUpdate()` is called: the root element's offset is the same as the x/y coordinate passed into `BentoSystemUpdate()` and the root element's dimensions are the same as the overall system dimensions.

Layers must be explicited created (`BentoLayerCreate()`) and destroyed (`BentoLayerDestroy()`). Destroying a layer will recursively destroy all elements on that layer. When a new layer is created on top of the layer stack and becomes the layer receiving user input, a few things happen:

- The [navigation cursor](Topic-Navigation) on the newly backgrounded layer has its position saved
- If the [primary button](Topic-Hover-Hold-Click-Focus?id=hold-amp-click) was held then its state is transitioned to "released" followed by "no hold". No click event is generated
- Similarly, any held hotkeys are released but no click event is generated
- Any updates on the backgrounded layer stop after a couple of frames. This is not immediate to give elements the opportunity to react to be backgrounded

Destroying the top layer allows the next layer underneath to receive user input. Cursor control is returned to the new top layer using the saved position of the cursor.

Best practice with layers is to actively create layers as you need them and destroy them as soon as you have no use for them. Layers can be used to create many types of UI pattern, such as:

- Context menu modals
- Confirmation dialogs
- Gamepad disconnection warnings
- Network error messages

A practical, albeit slightly lazy, way to check if your game is paused is to check if your Bento environment contains any layers. Provided that you're destroying layers that you're not using, the absence of any layers indicates that there's no pause menu open.
