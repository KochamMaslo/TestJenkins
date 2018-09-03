/*
* This file contains style definitions for:
* - highlight and selection (1)
* - default Portal style, default display style for analyses and predefined quries (2)
* (1) group can contain two base parameters:
* - "color"
* - "translucency" (value between 0 and 1, where 1 means totally transparent)
* (2) group can contain all possible parameters.
* In addition, style definitions can be set globally ("*") or can be based on service layer ID (regexp), 
* this means that you can set different default styles for particular feature classes. The definitions 
* are applied in sequence, so the global setting should be defined first.
*
* The definitions structure is strictly defined. 6 types of styles can be used (integer value or text value):
* 1 - "SimplePointStyle"
* 2 - "SimpleLineStyle"
* 3 - "SimpleFillStyle"
* 4 - "AreaStyle"
* 5 - "CompoundStyle"
* 6 - "TextStyle"
* Every definition MUST contain "type" parameter.
* Simple styles (1-3) and text style (6) contains also base parameters:
* - color: HEX value i.e. "#F0F8FF" (1-3, 6)
* - translucency: number value between 0 and 1, where 1 means totally transparent (1-3, 6)
* - width: number value indicating the thickness of the line (2)
* - size: number value indicating the size of point or text (1, 6)
* - bold, italic, underline: bool value indicating the text parameters (6)
* - rotation: number value indicating the rotation of text in degrees (6)
* Complex styles (4, 5) contains only "styles" parameter that is an array of:
* - "SimpleLineStyle" and "SimpleFillStyle" (4)
* - "AreaStyle", "SimpleLineStyle", "SimplePointStyle" and "TextStyle" (5)
*/

Type.registerNamespace("Sys.Application.Configuration.StyleConfig");

Sys.Application.Configuration.StyleConfig.definitions = {
    "default": {
        "*": {
            type: "CompoundStyle",
            styles: [{
                type: "AreaStyle",
                styles: [{
                    type: "SimpleLineStyle",
                    color: "#000000",
                    width: 2,
                    translucency: 0.0
                }, {
                    type: "SimpleFillStyle",
                    color: "#aaaaaa",
                    translucency: 0.0
                }]
            }, {
                type: "SimpleLineStyle",
                color: "#000000",
                width: 2,
                translucency: 0.0
            }, {
                type: "SimplePointStyle",
                color: "#000000",
                size: 3,
                translucency: 0.0
            }, {
                type: "TextStyle",
                color: "#000000",
                size: 7,
                translucency: 0.0,
                rotation: 0,
                bold: false,
                italic: false,
                underline: false
            }]
        }
    },
    "highlight": {
        "*": {
            type: "CompoundStyle",
            styles: [{
                type: "AreaStyle",
                styles: [{
                    type: "SimpleLineStyle",
                    color: "#4180d0"
                }, {
                    type: "SimpleFillStyle",
                    color: "#dfe8f6",
                    translucency: 0.7
                }]
            }, {
                type: "SimpleLineStyle",
                color: "#4180d0"
            }, {
                type: "SimplePointStyle",
                color: "#4180d0"
            }, {
                type: "TextStyle",
                color: "#4180d0"
            }]
        }
    },
    "select": {
        "*": {
            type: "CompoundStyle",
            styles: [{
                type: "AreaStyle",
                styles: [{
                    type: "SimpleLineStyle",
                    color: "#56d249"
                }, {
                    type: "SimpleFillStyle",
                    color: "#56d249",
                    translucency: 0.7
                }]
            }, {
                type: "SimpleLineStyle",
                color: "#56d249"
            }, {
                type: "SimplePointStyle",
                color: "#56d249",
                size: 6
            }, {
                type: "TextStyle",
                color: "#56d249"
            }]
        }
    },
    "redlining": {
        "*": {
            type: "CompoundStyle",
            styles: [{
                type: "AreaStyle",
                styles: [{
                    type: "SimpleLineStyle",
                    color: "#ff0000"
                }, {
                    type: "SimpleFillStyle",
                    color: "#ff0000",
                    translucency: 0.7
                }]
            }, {
                type: "SimpleLineStyle",
                color: "#ff0000"
            }, {
                type: "SimplePointStyle",
                color: "#ff0000",
                size: 6
            }, {
                type: "TextStyle",
                color: "#56d249",
                size: 12
            }]
        }
    },
    "analysis": {
    },
    "predefinedQuery": {
    }
};