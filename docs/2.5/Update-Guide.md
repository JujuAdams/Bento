# Updating

&nbsp;

Releases go out once in while, typically expedited if there is a serious bug. This library uses semantic versioning. In short, if the left-most number in the version is increased then this is a “major version increase”. Major version increases introduce breaking changes and you’ll almost certainly have to rewrite some code. However, if the middle or right-most number in the version is increased then you probably won’t have to rewrite any code. For example, moving from `1.1.0` to `2.0.0` is a major version increase but moving from `1.1.0` to `1.2.0` isn’t.

?> Please always read patch notes. Very occasionally a minor breaking change in an obscure feature may be introduced by a minor version increase.

At any rate, the process to update is as follows:

1. **Back up your whole project using source control!***
2. Back up the contents of `__BentoConfig` within your project. Duplicating scripts is sufficient.
3. Delete all library scripts from your project. Unless you’ve moved things around, this means deleting the library folder from the asset browser.
4. Import the latest .yymps
5. Restore your configuration scripts from the back-up line by line.

!> Because configuration macros might be added or removed between versions, it’s important to restore your configuration script carefully.