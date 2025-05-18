<img src="https://raw.githubusercontent.com/JujuAdams/Bento/master/LOGO.png" width="50%" style="display: block; margin: auto;" />
<h1 align="center">0.2 alpha</h1>
<p align="center">Cross-platform UI framework for GameMaker by <a href="https://www.jujuadams.com/" target="_blank">Juju Adams</a></p>

<p align="center"><a href="https://github.com/JujuAdams/Bento/releases/" target="_blank">Download the .yymps</a></p>

---

## Introduction

Bento is a cross-platform device-agnostic UI framework. It simplifies much of the tedious UI construction process by providing you with tools to lay out and control a user interface whilst remaining efficient and convenient. It has all the basics you'd expect:

- Mouse, keyboard, gamepad, and touchscreen input
- Focus, scroll, and clipping (scissor test) features
- Separate layers for modals, separate environments for multiplayer
- Custom layout engine that is considerably simpler than GameMaker's native flexpanels
- Fast with operations cached wherever possible
- Easy-to-use transform functions to create procedural animations
- Supports a mixture of instances and structs as UI elements

Bento is not a complete kitchen sink UI solution. Trying to solve every UI problem with a single package would end up with an enormous and intimidating codebase. Instead, Bento's goal is to give you the core tools needed to build a simple UI with minimum hassle, and then to give you the necessary tools to build your own advanced custom UI components whilst relying on Bento's foundations.

Because Bento is a little different to other GameMaker libraries, familiarity with its principles and technology is advised. You can read more about how Bento works [here](Technology). That having been said, basic use is straight-forward so if you'd like to get stuck in you can jump ahead to [setting up the library](Setting-Up). At any point if you get stuck then you should refer to the [example project in the GitHub repo](https://github.com/JujuAdams/Bento/).

At any rate, thanks for checking out Bento. It's been a long time coming!

## Updating

Releases go out once in while, typically expedited if there is a serious bug. This library uses [semantic versioning](https://semver.org/). In short, if the left-most number in the version is increased then this is a "major version increase". Major version increases introduce breaking changes and you'll almost certainly have to rewrite some code. However, if the middle or right-most number in the version is increased then you probably won't have to rewrite any code. For example, moving from `1.1.0` to `2.0.0` is a major version increase but moving from `1.1.0` to `1.2.0` isn't.

?> Please always read patch notes. Very occasionally a minor breaking change in an obscure feature may be introduced by a minor version increase.

At any rate, the process to update is as follows:

1. **Back up your whole project using source control!**
2. Back up the contents of your configuration script (`__BentoConfig*`) within your project. Duplicating scripts is sufficient
3. Delete all library scripts from your project. Unless you've moved things around, this means deleting the library folder from the asset browser
4. Import the latest [.yymps](https://github.com/JujuAdams/Bento/releases/)
5. Restore your configuration scripts from the back-up line by line

!> Because configuration macros might be added or removed between versions, it's important to restore your configuration scripts carefully.

## About & Support

Bento supports all GameMaker export platforms, with the exception of HTML5. Bento supports GameMaker 2024.11 (and later). If you'd like to report a bug or suggest a feature, please use the repo's [Issues page](https://github.com/JujuAdams/Bento/issues). Bento is constantly being maintained and upgraded; bugs are usually addressed within a few days of being reported.

Bento is primarily built and maintained by [Juju](https://www.jujuadams.com/) who has been stick in UI pergatory ever since he first opened GameMaker. Juju's worked on a lot of [commercial GameMaker games](http://www.jujuadams.com/) and has many hodge-podge UI systems in his time. Bento is the product of practical experience working as a consultant.

Many, many other people have contributed to GameMaker's open source community via bug reports and feature requests. Bento wouldn't exist without them and we're eternally grateful for their creativity and patience.

## License

Bento is licensed under the [MIT License](https://github.com/JujuAdams/Bento/blob/master/LICENSE).