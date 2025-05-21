# Technology - Reposition Code

?> This page covers some of the technology behind Bento. Because Bento is a framework that is intended to be used as the basis for later custom UI solutions, it's important that it's clear how things work and why. I encourage you to read Bento's source code as you read through this page.

&nbsp;

When an element executes its Reposition code, either User Event 3 will be executed (for instance elements) or the `funcReposition` method will be executed (struct elements).

Reposition callback code is a special feature of Bento. This code is executed whenever Bento recalculates the UI layout. Reposition code is helpful when creating custom components as a way to update any cached values you might have that rely on Bento's calculated layout positions (`bentoLeft` `bentoWidth` etc.).

?> You can read more about layouts [here](Tech-Layouts).