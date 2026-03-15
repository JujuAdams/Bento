// Feather disable all

function ExampleCreditsAndLicenses()
{
    with(oMain)
    {
        var _json = {
            object: oBentoExSpacer,
            layout: {
                padding: 40,
                gutter: 35,
                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                list: [BENTO_AXIS_Y, 0.5, 0],
            },
            children: [
                {
                    object: oBentoExSpacer,
                    layout: {
                        list: [BENTO_AXIS_X, 0.5, 0.5],
                        gutter: 35,
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                    },
                    children: [
                        {
                            object: oBentoExText,
                            vars: {
                                text: "Credits & Licenses",
                                font: fntBentoExCandyBeansBig,
                            },
                        },
                        {
                            object: oBentoExBackButton,
                            select: true,
                            vars: {
                                func: ExampleHomePage,
                            },
                        },
                    ],
                },
                {
                    object: oBentoExScrollingList,
                    layout: {
                        gutter: 20,
                        padding: 20,
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                    },
                    children: [
                        {
                            object: oBentoExText,
                            vars:
                            {
                                text: "Candy Beans Font",
                                font: fntBentoExCandyBeansBig,
                                hAlign: fa_center,
                            },
                            layout: {
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                            },
                        },
                        {
                            object: oBentoExSpacer,
                            layout: {
                                gutter: 35,
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                                list: [BENTO_AXIS_X, 0.5, 0.5],
                            },
                            children: [
                                {
                                    object: oBentoExButton,
                                    vars: {
                                        text: "Candy Beans license",
                                        func: function()
                                        {
                                            url_open("FSLA_NonCommercial_License.html");
                                        }
                                    },
                                },
                                {
                                    object: oBentoExButton,
                                    vars: {
                                        text: "Chequered Ink's website",
                                        func: function()
                                        {
                                            url_open("https://chequered.ink/");
                                        }
                                    },
                                },
                            ],
                        },
                        {
                            object: oBentoExText,
                            vars:
                            {
                                text: "Permission kindly given by Chequered Ink Ltd. for use of the Candy Beans font in this example project. Candy Beans may not be reused outside of the terms of the license found alongside the project files (and linked below).",
                                frame: false,
                            },
                            layout: {
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                            },
                        },
                    ],
                },
                {
                    object: oBentoExScrollingList,
                    layout: {
                        gutter: 20,
                        padding: 20,
                        resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                    },
                    children: [
                        {
                            object: oBentoExText,
                            vars:
                            {
                                text: "Bento",
                                font: fntBentoExCandyBeansBig,
                                hAlign: fa_center,
                            },
                            layout: {
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                            },
                        },
                        {
                            object: oBentoExSpacer,
                            layout: {
                                gutter: 35,
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE],
                                list: [BENTO_AXIS_X, 0.5, 0.5],
                            },
                            children: [
                                {
                                    object: oBentoExButton,
                                    vars: {
                                        text: "Open repo",
                                        func: function()
                                        {
                                            url_open("https://www.github.com/jujuadams/Bento/");
                                        }
                                    },
                                },
                                {
                                    object: oBentoExButton,
                                    vars: {
                                        text: "Juju's website",
                                        func: function()
                                        {
                                            url_open("https://www.jujuadams.com/");
                                        }
                                    },
                                },
                            ],
                        },
                        {
                            object: oBentoExTextScroll,
                            vars:
                            {
                                text: "MIT License\n\nCopyright (c) 2026 Julian Adams\n\nPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.",
                                frame: false,
                            },
                            layout: {
                                resize: [BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE],
                            },
                        },
                    ],
                },
            ],
        };
        
        BentoDestroy(mainElement);
        mainElement = BentoCreateFromJSON(_json, undefined, BentoGetRoot());
    }
}