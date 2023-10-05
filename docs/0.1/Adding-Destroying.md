# Adding & Destroying

&nbsp;

This page covers dynamically adjusting your UI layout after it has first been generated.

&nbsp;

## Adding

You may, from to time, need to create a UI element after an interface has been laid out. This might happen when constructing a server browser or an inventory etc.  This can be accomplished in both BentoScript and GML easily enough. The key point to remember is that you must always have a UI element "open" and that this open UI element will act as the parent for the new UI element you intend to create.

<!-- tabs:start -->

#### **BentoScript**

```
//Optional - Find a UI element with the given identifier
var existingUI = BoxFind("indentifier")

//Open up an existing struct to add a UI element to
use existingUI {

	//Construct a UI element as normal
	build BentoRectangle {
		xywh = ["50%", "50%", 100, 100]
	}

}
```

#### **GML**

```gml
//Optional - Find a UI element with the given identifier
var _existingUI = BentoFind("indentifier");

//Open up an existing struct to add a UI element to
BentoOpen(_existingUI);

	//Construct a UI element as normal
	BentoOpen(new BentoClassRectangle());
		BentoCurrent().Set("xywh", ["50%", "50%", 100, 100]);
	BentoClose();

BentoClose();
```

<!-- tabs:end -->

&nbsp;

## Destroying

Destroying a UI element is achieved by calling the `.Destroy()` method on the target UI element. This will immediately remove the UI element from the parent and cease all functionality for the UI element.

<!-- tabs:start -->

#### **BentoScript**

```
//Optional - Find a UI element with the given identifier
var existingUI = BoxFind("indentifier")

//Destroy this UI element
existingUI.Destroy()
```

#### **GML**

```gml
//Optional - Find a UI element with the given identifier
var _existingUI = BentoFind("indentifier");

//Destroy this UI element
_existingUI.Destroy();
```

<!-- tabs:end -->