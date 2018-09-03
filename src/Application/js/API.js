/* jshint indent : 4, strict : true, maxparams: 4, maxdepth: 3, eqeqeq: true */
/* jshint forin: true, latedef: true, newcap: true, noarg: true */
/* jshint noempty: true, nonew: true, undef: true, unused: true */
/* jshint trailing: true, quotmark: true, lastsemic: true, browser: true */
/* global Sys, Type, console */

/**
* @ignore
* @preserve Geospatial Portal JavaScript API
* A valid Geospatial Portal SDK license is required for customizing
* Geospatial Portal, GeoMedia WebMap, and/or ERDAS APOLLO.
* A valid product license is required to run each copy of Geospatial Portal,
* GeoMedia WebMap, and/or ERDAS APOLLO that has been customized using the
* Geospatial Portal SDK.
* © 2013, 2014, 2015, 2016 Intergraph® Corporation and/or its affiliates.
* All Rights Reserved.
*/
(function (window, undefined) {
    "use strict";

    var T_FUNCTION = "function",
        T_NUMBER = "number",
        T_STRING = "string",
        T_OBJECT = "object",
        T_UNDEFINED = "undefined",
        T_BOOLEAN = "boolean",
        // Fired events
        F_SUCCESS = "success",
        F_FAILURE = "failure",
        // Messages
        M_APOLLO_MISSING = "Apollo Catalog not available",
        M_ITEM_NOT_SUITABLE = "Item is not suitable for this action",
        M_EXTENSION_NOT_PROVIDED = "Extension not provided",
        M_APOLLO_ARITY = "Specified input values count does not match process inputs number",
        // Portal events
        E_USER_AUTHENTICATED = "userAuthenticated",
        E_REFRESH_MAP_LEGEND_CONTROL = "refreshMapLegendControl",
        E_VISIBILITY_CHANGED = "visibilityChanged",
        E_LOCATABILITY_CHANGED = "locatabilityChanged",
        E_MAPSERVICE_INITIALIZED = "mapServiceInitialized",
        E_MAPSERVICE_INIT_FAILED = "mapServiceInitFailed",
        E_USERMAPLIST_CHANGED = "userMapListChanged",
        E_MAPRANGE_CHANGED = "mapRangeChanged",
        E_SCALE_CHANGED = "scaleChanged",
        E_CANCEL_MAP_OPERATION = "cancelMapOperation",
        E_CRS_CHANGED = "crsChanged",
        E_SHOW_WEBBROWSER = "showWebBrowser",
        E_HIDE_WEBBROWSER = "hideWebBrowser",
        E_SETTINGS_CHANGED = "settingsChanged",
        E_MAPLAYER_PRIORITY_CHANGED = "mapLayerPriorityChanged",
        E_PRIORITY_CHANGED = "priorityChanged",
        E_SHOW = "show",
        E_HIDE = "hide",
        E_SHOW_FEATUREINFO = "showFeatureInfo",
        E_SHOW_FEATUREINFO_LOADING = "showFeatureInfoLoading",
        E_SHOW_FEATUREINFO_ALL_LAYERS = "showFeatureInfoForAllLayers",
        E_FEATUREINFO_ALL_FINISHED = "featureInfoForAllLayersFinished",
        E_VARIANT_CHANGED = "mapStateVariantChanged",
        E_OPACITY_CHANGED = "opacityChanged",
        E_PICTOGRAM_CHANGED = "legendItemPictogramChanged",
        E_LEGENDITEM_ADDED = "newLegendItemAdded",
        E_LEGENDITEM_REMOVED = "legendItemRemoved",
        E_LEGENDITEM_VISIBILITY_CHANGED = "visibilityChanged",
        E_MAPLAYER_RENDERING = "mapLayerRendering",
        E_MAPLAYER_RENDERED = "mapLayerRendered",
        E_SELECTEDFEATURES_CHANGED = "selectedFeaturesChanged",
        // portal
        GP_INTERNAL = "$GP.internal",
        P_PLATFORM = "Intergraph.WebSolutions.Core.WebClient.Platform",
        P_APOLLO_COMMON = "Intergraph.WebSolutions.Core.SDIPortal.Apollo.Common.Apollo",
        P_MAPSERVICE_MANAGER = P_PLATFORM + ".MapServices.MapServiceManager",
        P_MAPSTATE_MANAGER = P_PLATFORM + ".MapContent.MapStateManager",
        P_UTIL = P_PLATFORM + ".Common.Util",
        P_USER_MANAGER = P_PLATFORM + ".User.UserManager",
        P_EVENT = P_PLATFORM + ".ClientScript.ClientEventManager",
        P_CRS = P_PLATFORM + ".Common.CoordinateReferenceSystemManager",
        P_WEB_REQUEST = P_PLATFORM + ".Web.WebRequestWrapper",
        P_LOG = P_PLATFORM + ".ClientScript.ClientLogWriter",
        P_SETTINGS = P_PLATFORM + ".ClientScript.Settings",
        P_REDLINING = P_PLATFORM + ".ClientScript.Draw.Redlinig",
        P_MAPRANGE = P_PLATFORM + ".MapContent.MapRange",
        P_SIZE = P_PLATFORM + ".Common.Size",
        P_FEATURE_DATASET = P_PLATFORM + ".Geodatabase.FeatureDataset",
        P_FEATURECLASS = P_PLATFORM + ".Geodatabase.FeatureClass",
        P_FEATURE = P_PLATFORM + ".Geodatabase.Feature",
        P_POINT = P_PLATFORM + ".ClientScript.Draw.Geometry.Point",
        P_CONTROLS = "Intergraph.WebSolutions.Core.WebClient.Controls",
        P_SEARCHRESULTACTION_MANAGER = P_CONTROLS + ".SearchResultActionManager",
        P_ANALYSIS_MANAGER = P_PLATFORM + ".Data.AnalysisManager",
        P_GEOJSON = "$geoJSON",
        P_APOLLO = "$apollo",
        P_STYLEBASE = P_PLATFORM + ".Style.StyleBase",
        P_SELECTEDFEATURES = P_PLATFORM + ".Data.SelectedFeaturesManager",
        P_DSM = P_PLATFORM + ".ClientScript.Draw.DynamicStyleManager",
        P_DFEM = P_PLATFORM + ".ClientScript.Draw.DynamicFeatureEventManager",
        P_SUPPORT = P_PLATFORM + ".ClientScript.Edit.Support",
        P_FIELDCONTAINER = P_PLATFORM + ".Geodatabase.FieldContainer",
        P_LID = P_PLATFORM + ".MapServices.LegendItemDefinition",
        P_DATAVIEW_IPLUGIN = P_CONTROLS + ".Plugins.IDataViewControlPlugin",
        P_DATAVIEW_MANAGER = P_CONTROLS + ".Plugins.DataViewControlManager",
        P_SESSION_MANAGER = P_PLATFORM + ".Session.SessionManager",
        P_QDI = P_PLATFORM + ".MapServices.QueryDefinitionItem",
        P_VSPM = P_PLATFORM + ".Common.VendorSpecificParametersManager",
    // namespaces
        N_OGC = "http://www.opengis.net/ogc",
    // others
        portalObjCache = {},
        gp,
        originalgp,
        hasOwnProperty = Object.prototype.hasOwnProperty;

    /* HELPER FUNCTIONS */

    function warn() {
        if (!isSet(console) || typeof console.warn !== T_FUNCTION) return;
        console.warn.apply(console, Array.prototype.slice.call(arguments));
    }

    function isSet(x) {
        return typeof x !== T_UNDEFINED;
    }

    function isAnySet() {
        var args = Array.prototype.slice.call(arguments);
        for (var i = 0, l = args.length; i < l; i++)
            if (isSet(args[i]))
                return true;
        return false;
    }

    function isEverySet() {
        var args = Array.prototype.slice.call(arguments);
        for (var i = 0, l = args.length; i < l; i++)
            if (!isSet(args[i]))
                return false;
        return true;
    }

    // http://www.ietf.org/rfc/rfc4122.txt
    function createUuid () {
        var s = [];
        var hexDigits = "0123456789abcdef";
        for (var i = 0; i < 36; i++) {
            s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
        }
        s[14] = "4";  // bits 12-15 of the time_hi_and_version field to 0010
        s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1);  // bits 6-7 of the clock_seq_hi_and_reserved to 01
        s[8] = s[13] = s[18] = s[23] = "-";

        var uuid = s.join("");
        return uuid;
    }

    function getPortalObj(name) {
        if (portalObjCache[name])
            return portalObjCache[name];
        var chain = name.split("."),
            ret = window;
        for (var i = 0, l = chain.length; i < l; i++) {
            ret = ret[chain[i]];
            if (typeof ret === T_UNDEFINED) break;
        }
        portalObjCache[name] = ret;
        return ret;
    }

    function alwaysTrue() { return true; }

    // Creates findBy function with variable parameters length.
    // This findBy function can be used as a predicate
    // Each parameter is {key: "key", value: "value"}
    // If value is a RegExp, then this RegExp is evaluated instead of ===
    // Example: findBy({key: "name", value: "Name1"})
    function makeFindByPredicate() {
        var args = Array.prototype.slice.call(arguments);
        return function (object) {
            return args.some(function(kv) {
                var value = kv.value,
                    currentValue = object[kv.key];
                return value instanceof RegExp ? value.test(currentValue) : currentValue === value;
            });
        };
    }

    // performs membership action on the server and executes the callback
    function manageUserProfile(action, username, password, fn) {
        function callback(executor) {
            if (!getPortalObj(P_UTIL).checkExecutor(executor, getPortalObj(P_UTIL).showError))
                return;
            var result = executor.get_object();
            if (result.error) {
                getPortalObj(P_UTIL).showError(result.error);
                return;
            }
            if (result.success)
                getPortalObj(P_USER_MANAGER).logIn(username);
            else
                getPortalObj(P_USER_MANAGER).logIn(null);
            getPortalObj(P_EVENT).notify(E_USER_AUTHENTICATED, {}, null);
            // TODO: handle dirty exits above
            if (typeof fn === T_FUNCTION)
                fn({ username: username, result: result });
        }

        var request = getPortalObj(P_WEB_REQUEST).create({
            name: "Membership",
            query: { action: action },
            body: { login: username, password: password, remember: false },
            includeCRS: false,
            callback: callback
        });
        request.invoke();
    }

    // TODO: copied from SettingsPanel
    // TODO: refactor SettingsPanel, it should be in $crs
    function updateFitAllRanges(crs) {
        if (crs.west >= crs.east || crs.south >= crs.north)
            return;

        function transformCallback(points) {
            if (!points)
                return;
            var xMin = Math.min(points[0].x, points[1].x);
            var xMax = Math.max(points[2].x, points[3].x);
            var yMin = Math.min(points[0].y, points[2].y);
            var yMax = Math.max(points[1].y, points[3].y);
            var newRange = new (getPortalObj(P_MAPRANGE))([xMin, yMin, xMax, yMax]);
            var range = getPortalObj(P_CRS).getRange(crs.value);
            if (!range) {
                getPortalObj(P_CRS).setRange(crs.value, newRange);
            }
            var mapStates = getPortalObj(P_MAPSTATE_MANAGER).get_mapStates();
            /*jshint forin:false */
            for (var mapStateId in mapStates) {
                if (!hasOwnProperty.call(mapStates, mapStateId))
                    continue;
                var mapState = mapStates[mapStateId];
                var fitAllRange = mapState.get_fitAllRange(crs.value);
                if (!fitAllRange)
                    mapState.set_fitAllRange(crs.value, newRange.clone(), { onlyCurrentRange: true });
            }
        }

        getPortalObj(P_CRS).transformPoints(getPortalObj(P_CRS).WGS84Id, crs.value, [
                { x: crs.west, y: crs.south },
                { x: crs.west, y: crs.north },
                { x: crs.east, y: crs.south },
                { x: crs.east, y: crs.north }
            ], { round: true }, transformCallback, null);
    }

    // recursively walks through tree structure
    // @param {Object} config Configuration options. The list of the available configuration options:
    // @param {Function} [config.transformer]
    // @param {Function} config.predicate
    // @param {String} config.childrenGetter
    // @param {Array} config.items
    function rangerWalker(config) {
        var transformer = config.transformer || function (o) { return o; };
        var ret = [];
        for (var i = 0, l = config.items.length; i < l; i++) {
            if (config.predicate(config.items[i]))
                ret.push(transformer(config.items[i]));
            ret = ret.concat(rangerWalker({
                items: config.items[i][config.childrenGetter]() || [],
                predicate: config.predicate,
                childrenGetter: config.childrenGetter,
                transformer: transformer
            }));
        }
        return ret;
    }

    function fire(name, fn, args) {
        var log = getPortalObj(P_LOG);
        log.writeVerbose("Firing [" + name + "]");
        if (!isSet(fn) && name === F_FAILURE)
            log.writeVerbose("Errback not defined");
        if (typeof fn === T_FUNCTION) {
            fn.call(null, args);
        }
    }

    function fireEventHandler(name, fn, args) {
        var log = getPortalObj(P_LOG);
        log.writeVerbose("Firing Event [" + name + "]");
        if (!isSet(fn))
            log.writeVerbose("Handler not defined");
        if (typeof fn === T_FUNCTION) {
            fn.call(null, args);
        }
    }

    // recursively determines min and max priorities of given legend item (portal)
    function getPriorities(legendItem) {
        var p = legendItem._priority,
            t = typeof p === T_NUMBER,
            ret = [t ? p : +Infinity, t ? p : -Infinity];
        var childrenz = legendItem.get_legendItems() || [];
        for (var i = 0, l = childrenz.length; i < l; i++) {
            var subret = getPriorities(childrenz[i]);
            ret = [Math.min(ret[0], subret[0]), Math.max(ret[1], subret[1])];
        }
        return ret;
    }

    // returns map state
    function getMapState(config) {
        var mapStateId = (config || {}).mapStateId || "map";
        return getPortalObj(P_MAPSTATE_MANAGER).findMapState(mapStateId);
    }

    //checks if Apollo Catalog is available
    function getApolloMapServiceId() {
        var mapServices = getPortalObj(P_MAPSERVICE_MANAGER).findByDefinitionName("Apollo");
        if (mapServices.length <= 0)
            return null;
        return mapServices[0];
    }

    // returns map layer config of a given legend item (config.legendItem)
    function getMapLayerConfig(config) {
        if (!config || config.legendItem._parent) return null;
        var p = getPriorities(config.legendItem);
        var mlc = getMapState(config).get_mapLayerConfigs() || [];
        for (var i = 0, l = mlc.length; i < l; i++) {
            if (mlc[i]._firstLegendItemPriority === p[0] && mlc[i]._lastLegendItemPriority === p[1])
                return mlc[i];
        }
        return null;
    }

    // returns map layer for a given map layer config
    function getMapLayer(mapLayerConfig) {
        if (!mapLayerConfig || typeof mapLayerConfig.get_mapState !== T_FUNCTION ) return null;
        var mapLayers = mapLayerConfig.get_mapState().get_mapControl().get_mapLayers();
        for (var i = 0, l = mapLayers.length; i < l; i++)
            if (mapLayers[i].get_config().get_id() === mapLayerConfig.get_id())
                return mapLayers[i];
        return null;
    }

    function findMapLayer(config) {
        config = config || {};
        var mapState = getMapState(config),
            mapControl = mapState.get_mapControl(),
            mapLayerName = config.mapLayerName,
            mapLayerId = config.mapLayerId,
            mapServiceId = config.mapServiceId;
        if (!mapControl)
            return null;
        var mapLayers = mapControl.get_mapLayers() || [];
        for (var i = mapLayers.length - 1; i >= 0; i--) {
            var mlc = mapLayers[i].get_config();
            if (mlc.get_mapService().get_id() === mapServiceId) {
                if (isSet(mapLayerName) && mlc.get_name() !== mapLayerName)
                    continue;
                if (isSet(mapLayerId) && mlc.get_id() !== mapLayerId)
                    continue;
                return mapLayers[i];
            }
        }
        return null;
    }

    function findLegendItemDefinitions(config) {
        config = config || {};
        var ids = config.ids,
            names = config.names,
            transformer = config.transformer,
            mapServiceId = config.mapServiceId,
            mapService = getPortalObj(P_MAPSERVICE_MANAGER).findMapService(mapServiceId),
            legendItemDefinitions = mapService.get_legendItemDefinitions() || [],
            allowedTypes = config.allowedTypes || [0],
            tmpnames = {},
            tmpids = {},
            i,
            l;
        for (i = 0, l = (names || []).length; i < l; i++)
            tmpnames[names[i]] = 1;
        for (i = 0, l = (ids || []).length; i < l; i++)
            tmpids[ids[i]] = 1;
        var ret = rangerWalker({
            items: legendItemDefinitions,
            predicate: function (lid) {
                // TODO: check what types can be added this way!!!
                if (allowedTypes.indexOf(lid.get_type()) === -1) return false;
                return (!names && !ids) || tmpids[lid.get_id()] || tmpnames[lid.get_name()];
            },
            childrenGetter: "get_legendItemDefinitions",
            transformer: transformer
        });
        return ret;
    }

    // transforms {"foo": "bar"} to [{Key: "foo"}, {Value: "bar"}]
    function config2dict(config) {
        if (typeof config === T_NUMBER ||
            typeof config === T_STRING ||
            typeof config === T_BOOLEAN ||
            typeof config === T_UNDEFINED) {
            return config;
        }
        var dict = [];
        /*jshint forin:false */
        for (var pName in config) {
            if (!hasOwnProperty.call(config, pName) || typeof config[pName] === T_FUNCTION)
                continue;
            var value = config[pName];
            if (Array.isArray(config[pName]) && config[pName] !== null)
                value = config[pName].map(config2dict);
            else if (typeof config[pName] === T_OBJECT && config[pName] !== null)
                value = config2dict(config[pName]);
            dict.push({ Key: pName, Value: value });
        }
        return dict;
    }

    // returns UI component
    // relies on Sys.Application (Microsoft Ajax stuff)
    function getComponent(pattern) {
        for (var item in Sys.Application._components) {
            if (item.match(pattern))
                return Sys.Application._components[item];
        }
        return null;
    }

    // shortcut for getting toolbar handle
    function getToolbar() {
        return getComponent(/MapToolbar$/i);
    }

    // TODO: keep the getter naming convention
    function dump(obj) {
        var ret = {};
        for (var pName in obj) {
            if (pName.match(/^get_/) && typeof obj[pName] === T_FUNCTION)
                ret[pName.replace(/^get_/, "")] = obj[pName]();
        }
        return ret;
    }

    function apply(config1, config2, defaults, p) {
        p = p || alwaysTrue;
        if (defaults)
            apply(config1, defaults);
        if (config1 && config2 && typeof config2 === T_OBJECT)
            for (var pName in config2)
                if (hasOwnProperty.call(config2, pName) && p(config2, pName))
                    config1[pName] = config2[pName];
        return config1;
    }

    function copyProperties (dst, src, processors) {
        /*jshint forin:false */
        for (var pName in src) {
            if (!Object.hasOwnProperty.call(src, pName)) continue;
            if (processors[pName])
                apply(dst, processors[pName]);
            else
                dst[pName] = src[pName];
        }
    }

    function dig (source, address) {
        var p = address.split(".") || [], ret = source;
        for (var i = 0, l = p.length; i < l; i++) {
            if (!Object.hasOwnProperty.call(ret, p[i]) || !(ret = ret[p[i]]))
                return null;
        }
        return ret;
    }

    function getXYinScreenResolution (config) {
        var mapState = getMapState(config),
            mapSize = mapState.get_mapControl().get_mapSize(),
            s = mapState.get_mapRange().getSize(),
            bl = mapState.get_mapRange().getBottomLeft(),
            x = (config.x - bl.x) * mapSize.width / s.width,
            y = mapSize.height - (config.y - bl.y) * mapSize.height/s.height;
        return {
            x: Math.round(x),
            y: Math.round(y)
        };
    }

    function getXYinMapResolution (config) {
        var mapState = getMapState(config),
            mapControl = mapState.get_mapControl();
        return {
            x: mapControl.get_xInMapResolution(config.x),
            y: mapControl.get_yInMapResolution(config.y)
        };
    }

    function quoteIfString(txt) {
        if (typeof txt === T_STRING)
            return "'" + txt + "'";
        else
            return txt;
    }

    function prepareQueryWhereClause( filter, ret) {
        ret = ret || "";
        var operands = filter.operands || [],
            length = operands.length;
        for (var i = 0 ; i < length ; i++) {
            if (typeof operands[i].operator === T_STRING){
                ret = prepareQueryWhereClause(operands[i], ret);
                if (i !== length - 1)
                    ret += " " + filter.operator + " ";
            } else {
                switch (filter.operator) {
                case "AND":
                case "OR":
                    //warning !
                    break;

                case "BETWEEN":
                case "NOT BETWEEN":
                case "IN":
                case "NOT IN":
                    ret += filter.operands[0] + " " + filter.operator + "(";
                    ret += operands.slice(1).map(quoteIfString).join(",");
                    ret += ")";
                    break;
                default:
                    ret += filter.operands[0] + " " + filter.operator + " " + quoteIfString(filter.operands[1]);
                    break;
                }
                break;
            }
        }
        return ret;
    }

    function prepareWhereAttributes(filter) {
        // cloning filter as prepareQuery is mutating
        var arg = JSON.parse(JSON.stringify(filter));
        return prepareQuery(arg);
    }

    function isLeaf(obj) {
        return !Object.prototype.hasOwnProperty.call(obj, "operator") && !Object.prototype.hasOwnProperty.call(obj, "operands");
    }

    function wrap(what) {
        return [[null, null, null, "("]]
            .concat(what)
            .concat([
                [null, null, null, ")"]
            ]);
    }

    function prepareQuery(filter) {
        var ret = [],
            op = filter.operator,
            operator = [
                [null, null, null, op]
            ],
            operands = filter.operands || [],
            len = operands.length;

        if (len === 1) {
            ret = ret
                .concat(operator)
                .concat(prepareQuery(operands[0]));
            ret = wrap(ret);
        } else if (len === 2) {
            if (isLeaf(operands[0]) && isLeaf(operands[1])) {
                var value = operands[1];
                if (Array.isArray(value))
                    value = value.join(",");
                ret = ret.concat([
                    [operands[0], op, value, null]
                ]);
            } else {
                ret = ret
                    .concat(prepareQuery(operands[0]))
                    .concat(operator)
                    .concat(prepareQuery(operands[1]));
            }
            ret = wrap(ret);
        } else {
            var x = prepareQuery({
                operator: op,
                operands: operands.splice(0, 2)
            });
            for (var i = 2; i < len; i++) {
                x = wrap(x.concat(operator)
                    .concat(prepareQuery(operands[i - 2])));
            }
            ret = ret.concat(x);
        }
        return ret;
    }

    /*
    * creates Custom Feature Info Handler. Parameters documented in
    * {@link $GP.events#featureInfo}
    * @method
    * @return {Function} handler ready to use with $GP.events.featureInfoRequested
    * @private
    */
    function createFeatureInfoHandler(config) {
        var callback = config.handler,
            transformargs = config.transformargs,
            requestcompleted = config.requestcompleted,
            httphandler = config.httphandler,
            predicate = config.predicate,
            fallback = config.fallback,
            geometryFieldNames = config.geometryFieldNames && config.geometryFieldNames.map(function(item) { return item.toLowerCase(); });

        return function(eventName, eventArgs, sender) {
            getPortalObj(P_MAPSTATE_MANAGER).saveMapStates();

            if (eventArgs.legendItemDefinition) {
                var lid = eventArgs.legendItemDefinition.get_sourceLegendItemDefinition() || eventArgs.legendItemDefinition;
                eventArgs.skipRasterLayers = lid.get_mapService().get_supportsDataEditing() || (typeof eventArgs.featureId !== "undefined" && typeof x === "undefined" && typeof y === "undefined");
                eventArgs.mapServiceId = lid.get_mapService().get_id();
                eventArgs.legendItemDefinitionKey = lid.getKey();
            }

            eventArgs.requestEndpoint = httphandler;

            // We are retrieving the feature info data from the server to always
            // deliver the same structure. Default feature info control has a separate parser
            // for the "whole feature"
            eventArgs.wholeFeature = null;

            if (typeof predicate === T_FUNCTION && !predicate(eventArgs)) {
                if (typeof fallback === T_FUNCTION)
                    fallback(eventName, eventArgs, sender);
                return;
            }

            if (typeof transformargs === T_FUNCTION)
                eventArgs = transformargs(eventArgs);
            eventArgs.geometryFieldsToSerialize = geometryFieldNames;
            if (eventArgs.action === "InsertFeature" && eventArgs.insertFeatureCallback) {
                callback({}, eventArgs);
                return;
            }

            var future = getPortalObj(GP_INTERNAL).featureInfoRetriever.getFeatureInfo(eventArgs);
            if (typeof requestcompleted === T_FUNCTION) {
                future.always(function (result) {
                    eventArgs.result = result;
                    if (!requestcompleted(result)) {
                        fallback(eventName, eventArgs, sender);
                    } else {
                        callback(result, eventArgs);
                    }
                });
            } else {
                future.always(callback);
            }
        };
    }

    /*
    * creates Custom Feature Info Handler. Parameters documented in
    * {@link $GP.events#featureInfo}
    * @method
    * @return {Function} handler ready to use with $GP.events.featureInfoForAllLayersRequested
    * @private
    */
    function createFeatureInfoForAllLayersHandler(config) {
        var callback = config.handler,
            transformargs = config.transformargs,
            requestcompleted = config.requestcompleted,
            httphandler = config.httphandler,
            predicate = config.predicate,
            fallback = config.fallback,
            geometryFieldNames = config.geometryFieldNames && config.geometryFieldNames.map(function(item) { return item.toLowerCase(); }),
            controller = getPortalObj(GP_INTERNAL).featureInfoController;

        getPortalObj(P_EVENT).unregister(E_SHOW_FEATUREINFO_LOADING, controller._checkSessionBeforeFeatureInfo, controller);

        getPortalObj(P_EVENT).register(E_FEATUREINFO_ALL_FINISHED, function(eventName, result) {
            if (typeof requestcompleted === T_FUNCTION) {
                var eventArgs = {
                    result: result
                };
                if (!requestcompleted(result)) {
                    fallback(eventName, eventArgs);
                } else {
                    callback(result, eventArgs);
                }
            } else {
                callback(result);
            }
        });

        return function(eventName, eventArgs, sender) {
            if (eventArgs.legendItemDefinition) {
                var lid = eventArgs.legendItemDefinition.get_sourceLegendItemDefinition() || eventArgs.legendItemDefinition;
                eventArgs.skipRasterLayers = lid.get_mapService().get_supportsDataEditing() || (typeof eventArgs.featureId !== "undefined" && typeof x === "undefined" && typeof y === "undefined");
                eventArgs.mapServiceId = lid.get_mapService().get_id();
                eventArgs.legendItemDefinitionKey = lid.getKey();
            }

            eventArgs.requestEndpoint = httphandler;

            // We are retrieving the feature info data from the server to always
            // deliver the same structure. Default feature info control has a separate parser
            // for the "whole feature"
            eventArgs.wholeFeature = null;

            if (typeof predicate === T_FUNCTION && !predicate(eventArgs)) {
                if (typeof fallback === T_FUNCTION)
                    fallback(eventName, eventArgs, sender);
                return;
            }

            if (typeof transformargs === T_FUNCTION)
                eventArgs = transformargs(eventArgs);

            eventArgs.geometryFieldsToSerialize = geometryFieldNames;

            getPortalObj(GP_INTERNAL).featureInfoController._checkSessionBeforeFeatureInfo(eventName, eventArgs, sender);
        };
    }

    /* (We don't want it in the generated documentation as this is private)
    * Helper methods that returns portal style object from default style name
    * and style stub.
    * Aim of this function is not to expose directly portal's style objects
    * @param {Object/String} config Configuration options. If it is string, then
    * it works as if config.defaultStyleName was passed.
    * @param {string} [config.defaultStyleName] Name of one of the portal's default
    * styles:
    * - default
    * - selectRect
    * - scale
    * - redlining
    * - highlight
    * - select
    * - editing
    * - transparent
    * @param {string} [config.style] style stub - needs to be documented
    * @return portal internal style representation
    */
    // TODO: document style stub
    // TODO: copy/move doc somewhere else
    function getPortalStyle(config) {
        config = config || {};
        var defaultStyleName,
            styleStub = null;
        if (typeof config.style === T_STRING) {
            defaultStyleName = config.style;
        }
        else {
            styleStub = config.style;
            defaultStyleName = config.defaultStyleName || "default";
        }
        var styleType = config.styleType || P_STYLEBASE;
        return new (getPortalObj(styleType))(defaultStyleName, styleStub);
    }

    // returns portal feature in a callback or an error code if it is not found
    function findFeatures(config, callback, errback) {
        findFeaturesInCache(config, callback, function () {
            queryFeatures(config, callback, errback);
        });
    }

    // convenience call for findFeatures
    function findFeature(config, callback, errback) {
        findFeatures({
            featureIds: [config.featureId],
            featureClassId: config.featureClassId,
            bbox: config.bbox,
            force: config.forceFeatureClassesRefresh
        }, function(features) {
            fire(F_SUCCESS, callback, features[0]);
        }, errback);
    }

    function findFeaturesInCache(config, callback, errback) {
        var featureClassId = config.featureClassId,
            legendItemDefinition = getLegendItemDefinition(featureClassId),
            mapService = legendItemDefinition.get_mapService(),
            mapServiceId = mapService.get_id(),
            mapLayers = getMapState(config).get_mapControl().get_mapLayers(),
            mapLayer = mapLayers.filter(function (layer) {
                var ms = layer.get_config().get_mapService();
                return (ms && ms.get_id() === mapServiceId && layer._featureCache && layer._featureCache[featureClassId]);
            })[0],
            featureIds = config.featureIds,
            ret = [],
            cache;
        if (!mapLayer || !(cache = mapLayer._featureCache[featureClassId]))
            return fire(F_FAILURE, errback, { success: false });
        /* jshint forin:false*/
        for (var pName in cache) {
            if (!cache.hasOwnProperty(pName)) continue;
            if (!cache[pName].feature) continue;
            var feature = cache[pName].feature;
            if (featureIds.indexOf(feature.getKey()[0]) > -1)
                ret.push(feature);
            if (ret.length === featureIds.length)
                break;
        }
        return fire(F_SUCCESS, callback, ret);
    }

    function createResourceIdNode(value) {
        var qdi = new (getPortalObj(P_QDI))("FeatureId", N_OGC);
        qdi.get_attributes().fid = value;
        return qdi;
    }

    // currently only the ResourceId operator is optimized
    function queryFeatures(config, callback, errback) {
        var featureClassId = config.featureClassId,
            featureIds = config.featureIds,
            legendItemDefinition = getLegendItemDefinition(featureClassId),
            mapService = legendItemDefinition.get_mapService(),
            bboxPoints = config.bboxPoints,
            force = config.forceFeatureClassesRefresh;
        var getFeatureDatasetCallback = function (featureDataset) {
            if (!featureDataset || featureDataset.error) {
                return fire(F_FAILURE, errback, {message: featureDataset || "Unknown error"});
            }
            var fc = featureDataset.findFeatureClass(featureClassId),
            features = fc.get_features() || [],
            ret = [];
            /* jshint forin:false*/
            for (var id in features) {
                if (hasOwnProperty.call(features, id) && featureIds.indexOf(features[id].getKey()[0]) > -1) {
                    ret.push(features[id]);
                    if (isSet(featureIds) && ret.length === featureIds.length)
                        break;
                }
            }
            return fire(F_SUCCESS, callback, ret);
        };
        if (featureIds.length === 1) {
            var qdi = createResourceIdNode(featureIds[0]);
            mapService.queryFeatures(legendItemDefinition, qdi, getFeatureDatasetCallback);
        } else {
            mapService.getFeatureDataset([legendItemDefinition], getFeatureDatasetCallback, null, {
                bboxPoints: bboxPoints,
                force: force
            });
        }
    }

    /**
    * Legend item - both for leaves and grouping nodes
    * @class LegendItem
    */
    function LegendItem(config) {
        if (!config.portalLegendItem) return;
        /**
        * @property {Object} _ Private internals, use at your own risk. Hic sunt leones.
        * @property {Object} _.config internal config
        * @property {Object} _.li internal portal legendItem representation
        * @property {Object} _.mlc internal portal mapLayerConfig representation
        * @private
        */
        this._ = {
            config: config,
            li: config.portalLegendItem,
            mlc: getMapLayerConfig({
                legendItem: config.portalLegendItem,
                mapStateId: config.mapStateId
            })
        };
    }

    LegendItem.prototype = {
        /**
        * Fits map range to layer
        * @param {Function} callback
        * @method fitLayer
        */
        fitLayer: function (callback) {
            var mapService = this._.li.get_definition().get_mapService(),
                mapServiceDefinitionName = this._.li._definitionName || mapService.get_definition().name,
                version = mapService.get_config().version;
            (getMapLayer(this._.mlc) || this._.li).fitLayer(getPortalObj(P_CRS).getCurrent().get_id(), function (crsId) {
                // if layer is WFS analysis, then it already has correct coords
                // WMTS and IWS have correct coord too
                if (mapServiceDefinitionName !== "WMS") return false;
                return getPortalObj(P_CRS).qualifiesForSwapById(crsId, mapServiceDefinitionName, version);
            });
            fire(F_SUCCESS, callback, { success: true });
        },

        /**
        * Returns priority
        * @return {Number} priority
        */
        get_priority: function () {
            return (this._.mlc || this._.li).get_priority();
        },

        /**
        * Sets new priority
        * @param {Number} priority
        * @param {Function} [callback] callback executed
        * @param {Function} [errback] callback executed if operation fails
        */
        set_priority: function (priority, callback, errback) {
            var config = this._.config,
                eventName,
                args = {
                    mapStateId: getMapState(config).get_id(),
                    oldPriority: this.get_priority(),
                    newPriority: priority
                },
                msg = "Bad priority";
            if (this._.mlc) {
                eventName = E_MAPLAYER_PRIORITY_CHANGED;
                if (priority < 0 || priority > getMapState(config).get_mapLayerConfigs().length) {
                    fire(F_FAILURE, errback, { success: false, priority: priority, msg: msg });
                    return;
                }
                getMapState(config).setMapLayerPriority(this._.mlc, priority);
            } else {
                eventName = E_PRIORITY_CHANGED;
                args.legendItem = this._.li;
                args.differLayers = true;
                if (priority < 0 || priority > getMapState(config).get_legend().get_flatLegend().length) {
                    fire(F_FAILURE, errback, { success: false, priority: priority, msg: msg });
                    return;
                }
                getMapState(config).setLegendItemPriority(this._.li, priority);
            }
            getPortalObj(P_EVENT).notify(eventName, args, null);
            fire(F_SUCCESS, callback, { success: true, newPriority: priority, legendItem: this });
        },

        /**
        * Removes legend item
        * @method remove
        * @param {Function} callback
        */
        remove: function (callback) {
            var items;
            if (!this._.mlc)
                items = [this._.li];
            else
                items = rangerWalker({
                    items: [this._.li],
                    mapStateId: this._.config.mapStateId,
                    childrenGetter: "get_legendItems",
                    predicate: alwaysTrue
                });
            if (items)
                getMapState(this._.config).removeLegendItems(items);
            fire(F_SUCCESS, callback, { success: true });
        },

        /**
        * Returns end user visible name of the legend item
        * @method get_name
        * @return {String}
        */
        get_name: function () {
            if (this._.mlc)
                return this._.mlc.get_name();
            return this._.li.get_name() || this._.li.get_definition().get_name();
        },

        /**
        * Sets the end user visible name of the legend item
        * @method set_name
        * @param {String} name
        */
        set_name: function (name) {
            (this._.mlc || this._.li).set_name(name);
            getPortalObj(P_EVENT).notify(E_REFRESH_MAP_LEGEND_CONTROL, { mapStateId: this._.config.mapStateId || "map" }, null);
        },

        /**
        * Returns whether legend item is visible
        * @method get_isVisible
        * @return {Boolean}
        */
        get_isVisible: function () {
            if (!this._.mlc) return this._.li.get_isVisible();
            var items = rangerWalker({
                items: [this._.li],
                mapStateId: this._.config.mapStateId,
                childrenGetter: "get_legendItems",
                predicate: function (o) {
                    return o.get_isVisible();
                }
            });
            return items.length > 0;
        },

        /**
        * Sets visibility of the legend item
        * @method set_isVisible
        * @param {Boolean} isVisible
        */
        set_isVisible: function (isVisible) {
            if (!this._.mlc) {
                this._.li.set_isVisible(isVisible);
                getPortalObj(P_EVENT).notify(E_VISIBILITY_CHANGED, { legendItems: [this._.li], mapStateId: this._.config.mapStateId || "map" });
            } else {
                var items = rangerWalker({
                    items: [this._.li],
                    mapStateId: this._.config.mapStateId,
                    childrenGetter: "get_legendItems",
                    predicate: alwaysTrue
                });
                for (var i = 0, l = items.length; i < l; i++)
                    items[i].set_isVisible(isVisible);
                getPortalObj(P_EVENT).notify(E_VISIBILITY_CHANGED, { legendItems: items, mapStateId: this._.config.mapStateId || "map" });
            }
        },

        /**
        * Returns whether legend item is locatable
        * @method get_isLocatable
        * @return {Boolean}
        */
        // TODO: portal logic is strange here...
        // on "layer" level, locatability is just "disabled" but all child legendItems remain locatable
        get_isLocatable: function () {
            if (!this._.mlc) return this._.li.get_isLocatable();
            return !this._.mlc.get_isLocatabilityDisabled();
        },

        /**
        * Sets locatability of the legend item
        * @method set_isLocatable
        * @param {Boolean} isLocatable
        */
        set_isLocatable: function (isLocatable) {
            if (!this._.mlc) {
                this._.li.set_isLocatable(isLocatable);
                getPortalObj(P_EVENT).notify(E_LOCATABILITY_CHANGED, { legendItems: [this._.li], mapStateId: this._.config.mapStateId || "map" });
            } else getMapLayer(this._.mlc)[isLocatable ? "enableLocatability" : "disableLocatability"]();
        },

        /**
        * Returns opacity. Works only on "layer" nodes. For LegendItem nodes it returns null
        * @method get_opacity
        * @return {Number?} opacity 0-100
        */
        get_opacity: function () {
            if (!this._.mlc) return null;
            return this._.mlc.get_opacity();
        },

        /**
        * Sets opacity. Works only on "layer" nodes. On LegendItem nodes it does nothing
        * @method set_opacity
        * @param {Number} opacity new opacity
        */
        set_opacity: function (opacity) {
            if (!this._.mlc) return;
            this._.mlc.set_opacity(opacity);
            getPortalObj(P_EVENT).notify(E_OPACITY_CHANGED, { mapLayerConfigId: this._.mlc.get_id() }, null);
        },

        /**
        * Returns pictogram information
        * @return {Object} pictogram
        * @return {String} pictogram.url URL of the pictogram
        * @return {Number} pictogram.width Width of the pictogram in pixels
        * @return {Number} pictogram.height Height of the pictogram in pixels
        */
        get_pictogram: function() {
            if (!this._.li) return null;
            return this._.li.get_definition().get_pictogramDefinition();
        },

        /**
        * Updates pictogram
        * @param {Object} pictogram Pictogram information
        * @param {String} pictogram.url URL of the pictogram
        * @param {Number} pictogram.width Width of the pictogram in pixels
        * @param {Number} pictogram.height Height of the pictogram in pixels
        * @return {void}
        */
        set_pictogram: function(pictogram) {
            var legendItem = this._.li;
            if (!legendItem || !pictogram) return;
            legendItem.get_definition().set_pictogramDefinition(pictogram);
            getPortalObj(P_EVENT).notify(E_PICTOGRAM_CHANGED, {
                legendItem: legendItem,
                mapStateId: legendItem.get_legend().get_mapState().get_id()
            }, this);
        }
    };

    /**
    * @class MapService
    * Service representation
    */
    function MapService(config) {
        if (!config.portalMapService) return;
        /**
        * @property {Object} _ Private internals, use at your own risk. Hic sunt leones.
        * @property {Object} _.config internal config
        * @property {Object} _.ms internal portal mapService representation
        * @private
        */
        this._ = {
            config: config,
            ms: config.portalMapService
        };
    }

    MapService.prototype = {
        /**
        * Removes map service
        * @method remove
        * @param {Function} [callback] callback executed if operation succeeds
        * @param {Function} [errback] callback executed if operation fails
        */
        remove: function (callback, errback) {
            var mapServiceId = this._.ms.get_id();
            getPortalObj(P_MAPSERVICE_MANAGER).removeMapService(mapServiceId, function () {
                var success = !getPortalObj(P_MAPSERVICE_MANAGER).findMapService(mapServiceId);
                fire(success ? F_SUCCESS : F_FAILURE, success ? callback : errback, {
                    success: success,
                    msId: mapServiceId
                });
            }, this);
        },

        /**
        * Returns id of the service
        * @method get_id
        * @return {String}
        */
        get_id: function () { return this._.ms.get_id(); },

        /**
        * Returns end user visible name of the service
        * @method get_name
        * @return {String}
        */
        get_name: function () { return this._.ms.get_name(); },

        /**
        * Returns definition name of the service
        * @method get_definitionName
        * @return {String}
        */
        get_definitionName: function () { return this._.ms._definitionName; },

        /**
        * Returns URL of the service
        * @method get_url
        * @return {String}
        */
        get_url: function () { return this._.ms.get_config().url; }
    };

    // Bogus GeoJSON class to have it in the documentation
    /**
    * @class GeoJSON
    *
    * GeoJSON is a format for encoding a variety of geographic data structures.
    * A GeoJSON object may represent a geometry, a feature, or a collection of features. 
    * GeoJSON supports the following geometry types: Point, LineString, Polygon, MultiPoint,
    * MultiLineString, MultiPolygon, and GeometryCollection. Features in GeoJSON contain a 
    * geometry object and additional properties, and a feature collection represents 
    * a list of features.
    * A complete GeoJSON data structure is always an object (in JSON terms). 
    * In GeoJSON, an object consists of a collection of name/value pairs -- also called 
    * members. For each member, the name is always a string. Member values are either
    * a string, number, object, array or one of the literals: true, false, and null. 
    * An array consists of elements where each element is a value as described above.
    *
    * [Full GeoJSON specification](http://geojson.org/geojson-spec.html)
    */

    /**
    * @class Feature
    * Feature representation. Instances of this type are not created from
    * the client code, but appear in callbacks of {@link $GP.queries} and
    * {@link $GP.selectedFeatures}.
    *
    * In some circumstances, to prevent unnecessary data transfer,
    * these objects are "proxies" to actual features. For this reason it is
    * recommended to use callbacks and not returning values.
    * 
    */
    function Feature(config) {
        /**
        * @property {Object} _ Private internals, use at your own risk. Hic sunt leones.
        * @property {Object} _.config internal config
        * @property {Object} _.f internal portal feature representation
        * @private
        */
        this._ = {
            config: config,
            f: config.portalFeature,
            proxy: {
                featureId: config.featureId,
                featureClassId: config.featureClassId
            }
        };
    }

    Feature.prototype = {
        _getPortalFeatureObj: function (callback, errback) {
            var scope = this;
            findFeature({
                featureId: this._.proxy.featureId,
                featureClassId: this._.proxy.featureClassId
            }, function(portalFeature) {
                scope._.f = portalFeature;
                callback.call(scope);
            }, errback);
        },

        /**
        * Returns a [GeoJSON](http://geojson.org/geojson-spec.html) representation of the feature.
        * Since 15.00.0512 Synchronous version of this method:
        *
        *     var obj = feature.get_geoJSON();
        *     // do something with the GeoJSON object
        *
        * is not recommended as sometimes features are represented just by their id and featureClassId.
        * To be on the safe side, use asynchronous version:
        *
        *     feature.get_geoJSON(obj) {
        *         // do something with the GeoJSON object
        *     }
        *
        * @method get_geoJSON
        * @param {Function} callback Callback executed on the resulting GeoJSON object
        * @param {GeoJSON} callback.result GeoJSON object
        * @param {Function} errback Error callback
        * @return {GeoJSON} geojson object. If feature data is not available synchronously
        * and there is no callback, then warning appears in the console and 
        * a bogus GeoJSON object is returned for backward compatibility
        */
        get_geoJSON: function (callback, errback) {
            if (!this._.f) {
                if (!isSet(callback)) warn("Deprecated: get_geoJSON on a proxy feature object without a callback function");
                var scope = this;
                this._getPortalFeatureObj(function() {
                    scope.get_geoJSON(callback, errback);
                }, errback);
                return {
                    properties: "This get_geoJSON invocation is asynchronous. Use callback to get the data.",
                    geometry: {coordinates: []}
                };
            }
            if (!this._geoJSON)
                this._geoJSON = getPortalObj(P_GEOJSON).getFeature(this._.f);
            fire(F_SUCCESS, callback, this._geoJSON);
            return this._geoJSON;
        },

        /**
        * Centers the map on the feature centroid
        * @param {Function} callback Callback executed after the zoom
        * @param {Function} errback Error callback
        * @method center
        * @return {void}
        */
        center: function(callback, errback) {
            if (!this._.f) {
                var scope = this;
                return this._getPortalFeatureObj(function() {
                    scope.center(callback, errback);
                }, errback);
            }
            var g = this._.f.get_geometry(),
                p = getPoint(g);
            return gp.map.zoom({ x: p.x, y: p.y }, callback);
        },

        /**
        * Returns feature ID
        * @method get_id
        * @return {String} ID
        */
        get_id: function () {
            return this._.proxy.featureId || this._.f.getKey()[0];
        },

        /**
        * Returns featureClassId
        * @method get_featureClassId
        * @return {String} featureClassId
        */
        get_featureClassId: function() {
            return this._.proxy.featureClassId || this._.f.get_featureClass().get_id();
        }
    };

    /**
    * @class NameSearchResult
    * Name search result item
    */
    function NameSearchResult(config) {
        /**
        * @property {Object} _ Private internals, use at your own risk. Hic sunt leones.
        * @property {Object} _.config internal config
        * @private
        */
        this._ = {
            config: config
        };
        var cpr = config.portalSearchResult;
        if (!cpr)
            return;
        /**
        * @property {Point} point Point
        * @property {Number} point.x X Coordinate
        * @property {Number} point.y Y Coordinate
        */
        this.point = {
            x: cpr.point[1],
            y: cpr.point[0]
        };
        /**
        * @property {String} id ID
        */
        this.id = cpr.id;
        /**
        * @property {String} name Name
        */
        this.name = cpr.name;
        /**
        * @property {Number[]} suggestedBBox Suggested BBOX for setting the map range
        */
        this.bbox = cpr.suggestedBBox;
        /**
        * @property {Number} score Score of the search result. Used in LUWS and OpenLS
        */
        this.score = cpr.score;
        /**
        * @property {String} index Index
        */
        this.index = cpr.index;
        /**
        * @property {String} mapServiceId Search service ID
        */
        this.serviceId = cpr.mapServiceId;
        /**
        * @property {String} mapServiceName Search service name
        */
        this.serviceName = cpr.mapServiceName;
    }

    NameSearchResult.prototype = {
        /**
        * Centers the map on the point's coordinates
        * @method zoom
        * @param {Object} [config] Configuration options
        * @param {String} [config.mapStateId] ID of a mapState
        * @param {Function} [callback] Callback executed on the matched items
        * @return {void}
        */
        zoom: function(config, callback) {
            if (typeof config === T_FUNCTION) {
                callback = config;
                config = {};
            }
            var cfg = apply({}, config || {}, {x: this.x, y: this.y});
            gp.map.zoom(cfg, callback);
        },

        /**
        * Returns [GeoJSON](http://geojson.org/geojson-spec.html) representation of the search result.
        *
        * Although this particular method is synchronous, the asynchronous 
        * invocation is preferred since 15.00.0512 to unify get_geoJSON usage.
        * Please see {@link Feature#get_geoJSON} for explanation.
        *
        * @method get_geoJSON
        * @param {Function} callback Callback executed on the resulting GeoJSON object
        * @param {GeoJSON} callback.result GeoJSON object
        * @param {Function} errback Error callback
        * @return {GeoJSON} geojson object.
        */
        get_geoJSON: function (callback, errback) {
            if (!isSet(errback) && !this.point) {
                fire(F_FAILURE, errback, { message: "No data" });
                return null;
            }
            var ret = {
                "type": "Feature",
                "geometry": {
                    "type": "Point",
                    "coordinates": [this.point.x, this.point.y]
                },
                "properties": {
                    "name": this.name,
                    "score": this.score,
                    "bbox": this.bbox,
                    "id": this.id,
                    "mapServiceId": this.mapServiceId,
                    "mapServiceName": this.mapServiceName,
                    "index": this.index
                }
            };
            if (!isSet(callback)) {
                fire(F_SUCCESS, callback, ret);
            }
            return ret;
        }
    };

    /**
    * @class ApolloSearchResult
    * ERDAS APOLLO search result item
    */
    function ApolloSearchResult(config) {
        /**
        * @property {Object} _ Private internals, use at your own risk. Hic sunt leones.
        * @property {Object} _.config internal config
        * @private
        */
        this._ = {
            config: config
        };
        var cpr = config.portalSearchResult;
        if (!cpr)
            return;

        this._actionMapping = {
            wmts: "add_to_map_wmts",
            ecwp: "add_to_map_ecwp",
            wfs: "add_as_vector",
            wms: "add_to_map_wms"
        };
        /**
        * @property {Object} apollo APOLLO specific properties
        * @property {Object} apollo.temporalExtent Temporal extent
        * @property {Object} apollo.spatialExtent Spatial extent
        * @property {Object} apollo.spatialExtent.width Width
        * @property {Object} apollo.spatialExtent.height Height
        * @property {Object} apollo.spatialExtent.resolutionX Resolution X
        * @property {Object} apollo.spatialExtent.resolutionY Resolution Y
        */
        this.apollo = {};
        copyProperties(this.apollo, cpr, {
            temporalExtent: {
                temporalExtent: dig(cpr, "temporalExtent.extentValues")
            },
            spatialExtent: {
                width: dig(cpr, "spatialExtent.xExtent.size"),
                height: dig(cpr, "spatialExtent.yExtent.size"),
                resolutionX: dig(cpr, "spatialExtent.xExtent.resolution.string"),
                resolutionY: dig(cpr, "spatialExtent.yExtent.resolution.string")
            }
        });
    }

    ApolloSearchResult.prototype = {
        _performAction: function (type) {
            var actionManager = getPortalObj(P_SEARCHRESULTACTION_MANAGER),
                item = this.apollo,
                actionName = this._actionMapping[type],
                action = actionManager.getAction(actionName);
            if(action.predicate({data: item})) {
                action.handler([{ data: item, json: item }]);
                return true;
            }
            return false;
        },
        /**
        * Adds current item to map using method specified in config
        * @method addToMap
        * @param {Object} [config] Configuration options
        * @param {String} [config.type] type of a service to use (accepted values: "wms", "wmts", "ecwp", "wfs")
        * @param {Function} [callback] Callback executed on the matched items
        * @param {Function} [errback] callback executed if operation fails
        * @return {void}
        */
        addToMap: function(config, callback, errback) {
            config = config || {};
            var apolloMapServiceId = getApolloMapServiceId(),
                type = config.type || "wms";
            if(!apolloMapServiceId) {
                fire(F_FAILURE, errback, { success: false, message: M_APOLLO_MISSING });
                return;
            }
            var nfp = this.apollo.nativeFootprint,
                fp = this.apollo.footprint;

            if(nfp && nfp.envelope && nfp.envelope.length === 5)
                nfp.envelope.pop();
            if(fp && fp.envelope && fp.envelope.length === 5)
                fp.envelope.pop();

            if(this._performAction(type))
                fire(F_SUCCESS, callback, { success: true, item: this });
            else
                fire(F_FAILURE, errback, { success: false, message: M_ITEM_NOT_SUITABLE });
        },

        _zoom: function (result, config, callback, errback) {
            var mapState = getMapState(config),
                success = false,
                p0 = result.points[0],
                p1 = result.points[1];
            if(result.success) {
                if ((p0.x === p1.x) && (p0.y === p1.y))
                    mapState.centerToPoint(p0.x, p0.y);
                else
                    mapState.setMapRangeByPoints(p0.x, p0.y, p1.x, p1.y);
                success = true;
            }
            fire(success ? F_SUCCESS : F_FAILURE, success ? callback: errback, { success: success});
        },
        /**
        * Zoom the map to the extents of a given Apollo item
        * @method zoom
        * @param {Object} [config] Configuration options
        * @param {String} [config.mapStateId] ID of a mapState
        * @param {Function} [callback] Callback executed on the matched items
        * @param {Function} [errback] callback executed if operation fails
        * @return {void}
        */
        zoom: function(config, callback, errback) {
            if (typeof config === T_FUNCTION) {
                callback = config;
                errback = callback;
                config = {};
            }
            config = config || {};
            var message,
                extent = {},
                sourceSrs = null,
                geometries = [],
                xmin = Number.POSITIVE_INFINITY,
                ymin = Number.POSITIVE_INFINITY,
                xmax = Number.NEGATIVE_INFINITY,
                ymax = Number.NEGATIVE_INFINITY,
                that = this,
                z = function(r) {that._zoom(r, config, callback, errback);};
            if((!this.apollo || !this.apollo.footprint || !this.apollo.footprint.envelope) && (!this.apollo.nativeFootprint || !this.apollo.nativeFootprint.envelope)) {
                message = "No extents available. Zoom not possible.";
                fire(F_FAILURE, errback, { success: false, message: message });
                return;
            }

            if(this.apollo.nativeFootprint && this.apollo.nativeFootprint.envelope) {
                extent = this.apollo.nativeFootprint.data;
                sourceSrs = this.apollo.nativeFootprint.srs;
            }
            else {
                extent = this.apollo.footprint.data;
                sourceSrs = this.apollo.footprint.srs;
            }
            if(typeof(extent[0]) === T_NUMBER)
                geometries = [extent];
            else if (typeof(extent[0][0]) === T_NUMBER)
                geometries = extent;

            /*jshint forin:false */
            for(var geometry in geometries) {
                if(!geometries.hasOwnProperty(geometry)) continue;
                for(var j = 0; j <= geometries[geometry].length - 2; j+=2) {
                    if(geometries[geometry][j] < xmin)
                        xmin = geometries[geometry][j];
                    if(geometries[geometry][j+1] < ymin)
                        ymin = geometries[geometry][j+1];
                    if(geometries[geometry][j] > xmax)
                        xmax = geometries[geometry][j];
                    if(geometries[geometry][j+1] > ymax)
                        ymax = geometries[geometry][j+1];
                }
            }
            if(gp.crs.getCurrent() !== sourceSrs)
                gp.crs.transform({
                    sourceCrsId: sourceSrs,
                    targetCrsId: gp.crs.getCurrent(),
                    points:[{x:xmin, y:ymin}, {x:xmax, y:ymax}]
                }, z);
            else
                z({success: true, points:[{x:xmin, y:ymin}, {x:xmax, y:ymax}]});
        },

        _ensureAction: function(callback, errback, actionName) {
            var apolloMapServiceId = getApolloMapServiceId(),
                sram = getPortalObj(P_SEARCHRESULTACTION_MANAGER),
                action = sram.getAction(actionName);
            if(!apolloMapServiceId) {
                fire(F_FAILURE, errback, { success: false, message: M_APOLLO_MISSING });
            } else if(!action.predicate({data: this.apollo})) {
                fire(F_FAILURE, errback, { success: false, message: M_ITEM_NOT_SUITABLE });
            } else {
                action.handler([{json: this.apollo}]);
                fire(F_SUCCESS, callback, { success: true, item: this });
            }
        },

        /**
        * Display the index metadata of a given item
        * @method showIndexMetadata
        * @param {Function} [callback] Callback executed on the matched items
        * @param {Function} [errback] callback executed if operation fails
        * @return {void}
        */
        showIndexMetadata: function(callback, errback) {
            this._ensureAction(callback, errback, "index_metadata");
        },

        /**
        * Show the ISO metadata of current Apollo item
        * @method showISOMetadata
        * @param {Function} [callback] Callback executed on the matched items
        * @return {void}
        */
        showISOMetadata: function(callback, errback) {
            this._ensureAction(callback, errback, "iso_metadata");
        },

        /**
        * Download the ISO XML of current Apollo item
        * @method downloadISOXML
        * @param {Function} [callback] Callback executed on the matched items
        * @return {void}
        */
        downloadISOXML: function(callback, errback) {
            this._ensureAction(callback, errback, "iso_metadata_download");
        },

         /**
        * Download given apollo item from the server using specified format
        * @method openIn
        * @param {Object} config Configuration options
        * @param {Object} config.extension Extension to use.
        * @param {Function} [callback] Callback executed on the matched items
        * @param {Function} [errback] callback executed if operation fails
        * @return {void}
        */
        openIn: function(config, callback, errback) {
            var apolloMapServiceId = getApolloMapServiceId(),
                allowedClasses = ["com.erdas.rsp.babel.model.imagery.ImageReference", "com.erdas.rsp.babel.model.imagery.Aggregate"],
                form = document.createElement("form"),
                hiddenField = document.createElement("input"),
                extensionField = document.createElement("input"),
                mapServiceField = document.createElement("input");
            if (!config.extension) {
                fire(F_FAILURE, errback, {success: false, message: M_EXTENSION_NOT_PROVIDED});
                return;
            }
            if(allowedClasses.indexOf(this.apollo._class) < 0) {
                fire(F_FAILURE, errback, { success: false, message: M_ITEM_NOT_SUITABLE });
                return;
            }
            if(!apolloMapServiceId) {
                fire(F_FAILURE, errback, { success: false, message: M_APOLLO_MISSING });
                return;
            }

            function setField(target, name, value) {
                target.setAttribute("type", "hidden");
                target.setAttribute("name", name);
                target.setAttribute("value", value);
            }

            form.style.visibility = "hidden";
            form.setAttribute("method", "POST");
            form.setAttribute("target", "_blank");
            form.setAttribute("action", "ApolloSearch.WebClient.ashx?action=openIn");
            setField(hiddenField, "jsonData", gp.utils.serialize([this.apollo.id]));
            setField(extensionField, "extension", config.extension);
            setField(mapServiceField, "mapServiceId", apolloMapServiceId);
            form.appendChild(hiddenField);
            form.appendChild(extensionField);
            form.appendChild(mapServiceField);

            document.body.appendChild(form);
            form.submit();
            document.body.removeChild(form);
            fire(F_SUCCESS, callback, { success: true, item: this });
            return;
        }
    };

    function getSwapped(dataset, featureClass) {
        var jsonstring = JSON.parse(JSON.stringify(featureClass.serialize())),
            fc = new (getPortalObj(P_FEATURECLASS))(dataset, jsonstring),
            features = fc.get_features() || {};
        /* jshint forin:false */
        for (var featureId in features)
            if (hasOwnProperty.call(features, featureId)) {
                var g = features[featureId].get_geometry();
                if (g)
                    g.swapCoordinates();
            }
        return fc;
    }

    function makeDatasetCallback (config, callback, errback) {
        return function (dataset) {
            if (!dataset) {
                fire(F_FAILURE, errback, { success: false, msg: "Data not found." });
                return;
            }
            var gjs = getPortalObj(P_GEOJSON),
                result = [],
                geoJson,
                fcs = dataset.get_featureClasses() || {},
                format = config.format || "geojson";
            /* jshint forin:false */
            for (var c in fcs) {
                if (!hasOwnProperty.call(fcs, c)) continue;
                var featureClass = fcs[c];
                if (config.swapped)
                    featureClass = getSwapped(dataset, featureClass);
                geoJson = gjs.getFeatureCollection(featureClass);
                switch(format) {
                case "geojson":
                    result.push(geoJson);
                    break;
                case "featureCollectionsData":
                    result.push({
                        geojson: geoJson,
                        featureClassId: featureClass.get_id(),
                        featureClassName: featureClass._name || featureClass.get_id()
                    });
                    break;
                default:
                    return fire(F_FAILURE, errback, {success: false, msg: "No specified format"});
                }
            }
            fire(F_SUCCESS, callback, { success: true, data: result });
        };
    }


    function getDataWindow(dataWindowId) {
        return getComponent("^" + (dataWindowId || "DataWindow") + "$") || getComponent("DataPanel$");
    }

    function transformSelectedFeaturesSet(allSelectedFeatures) {
        var ret = [];
        for (var mapServiceId in allSelectedFeatures) {
            if (!hasOwnProperty.call(allSelectedFeatures, mapServiceId)) continue;
            var featureClassInfo = allSelectedFeatures[mapServiceId];
            /*jshint forin:false */
            for (var featureClassId in featureClassInfo) {
                if (!hasOwnProperty.call(featureClassInfo, featureClassId)) continue;
                var featureInfos = featureClassInfo[featureClassId];
                /*jshint forin:false */
                for (var featureId in featureInfos) {
                    ret.push({
                        featureId: featureId,
                        featureClassId: featureClassId,
                        mapServiceId: mapServiceId
                    });
                }
            }
        }
        return ret;
    }

    /**
    * @class Analysis
    * Analysis representation. Instances of this type are not supposed to
    * be created from the client code but appear in callbacks of {@link $GP.queries}
    */
    function Analysis(config) {
        /**
        * @property {Object} _ Private internals, use at your own risk. Hic sunt leones.
        * @property {Object} _.config internal config
        * @property {Object} _.portalAnalysis internal portal analysis representation
        * @private
        */
        this._ = {
            config: config.config,
            portalAnalysis: config.portalAnalysis
        };
    }

    Analysis.prototype = {
        /**
        * Returns ID of the analysis
        */
        get_id: function () {
            return this._.portalAnalysis.get_id();
        },

        /**
        * Returns Name of the analysis
        */
        get_name: function() {
            return this._.portalAnalysis.get_name();
        },

        /**
        * Adds analysis result to the legend (and to map)
        * @method addToLegend. Alias for addToMap
        * @param {Object} [config] If not passed, then callback can be passed as first parameter
        * @param {String} [config.parentLayerName] Name of the root layer where this analysis legend item should be added
        * @param {String} [config.parentLayerId] ID of the root layer where this analysis legend item should be added
        * @param {Function} callback
        * @param {Function} errback
        * @return {void}
        */
        addToLegend: function(config, callback, errback) {
            this.addToMap(config, callback, errback);
        },

        /**
        * Adds analysis result to the legend (and to map)
        * @method addToMap
        * @param {Object} [config] If not passed, then callback can be passed as first parameter
        * @param {String} [config.parentLayerName] Name of the root layer where this analysis legend item should be added
        * @param {String} [config.parentLayerId] ID of the root layer where this analysis legend item should be added
        * @param {Function} callback
        * @param {Function} errback
        * @return {void}
        */
        addToMap: function (config, callback, errback) {
            if (typeof config === T_FUNCTION) {
                config = {};
                callback = config;
                errback = callback;
            }
            config = config || {};
            var originalConfig = this._.config,
                analysisId = this._.portalAnalysis.get_id(),
                am = getPortalObj(P_ANALYSIS_MANAGER),
                analysis = am.findAnalysis(analysisId),
                parentLayerName = config.parentLayerName,
                parentLayerId = config.parentLayerId,
                mapState = getMapState(originalConfig),
                mapServiceId = analysis.get_mapServiceId();
            gp.legend.add({
                ids: [analysisId],
                parentLayerName: parentLayerName,
                parentLayerId: parentLayerId,
                mapServiceId: mapServiceId,
                mapStateId: mapState.get_id(),
                allowedTypes: [0,4]
            }, callback, errback);
        },

        /**
        * Removes analysis from legend
        * @method removeFromLegend
        * @param {Function} callback
        */
        removeFromLegend: function (callback) {
            var lit = gp.legend.find( { id: this._.portalAnalysis.get_id() } );
            lit[0].remove(callback);
        },

        /**
        * Permanently removes analysis (also from legend)
        * @method remove
        * @param {Function} callback
        */
        remove: function (callback, errback) {
            getPortalObj(P_ANALYSIS_MANAGER).deleteAnalysis(this._.portalAnalysis.get_id(), function (arg) {
                if (!!arg.error) {
                    fire(F_FAILURE, errback, { success: false });
                } else {
                    fire(F_SUCCESS, callback, { success: true });
                }
            });
        },

        /**
        * Returns analysis feature collection
        * @method getData
        * @param {Object} [config] config can be skipped
        * @param {Object} [config.force] whether to force data retrieval from the server
        * @param {Function} callback
        * @param {Function} [errback] callback executed if operation fails
        * @return {Object} feature collection in geoJSON format
        */
        getData: function (config, callback, errback) {
            if (typeof config === T_FUNCTION) {
                callback = config;
                errback = callback;
                config = {};
            }
            var force = config.force || false,
                forceObj = {},
                analysisId = this._.portalAnalysis.get_id(),
                mapServiceId = this._.portalAnalysis.get_mapServiceId(),
                service = getPortalObj(P_MAPSERVICE_MANAGER).findMapService( mapServiceId ),
                lit = service.findLegendItemDefinition( analysisId ),
                crsId = gp.crs.getCurrent(),
                crs = getPortalObj(P_CRS),
                swapped = service.get_definition().name === "WFS" && crs.qualifiesForSwapById(crsId, "WFS");
            forceObj[analysisId] = force;
            service.getFeatureDataset( [lit], makeDatasetCallback({
                swapped: swapped
            }, callback, errback), null, {force: forceObj});
        },

        /**
        * Adds the query results to the data window
        * @method addToDataView
        * @param {Object} config
        * @param {Function} callback
        * @param {Function} [errback] callback executed if operation fails
        * @return {void}
        */
        addToDataView: function (config, callback, errback) {
            config = config || {};
            var analysisId = this._.portalAnalysis.get_id(),
                mapServiceId = this._.portalAnalysis.get_mapServiceId(),
                service = getPortalObj(P_MAPSERVICE_MANAGER).findMapService(mapServiceId),
                lid = service.findLegendItemDefinition(analysisId),
                dataWindow = getDataWindow(config.dataWindowId),
                options = {}; // for future usage
            if (!lid) {
                return fire(F_FAILURE, errback, { success: false, message: "No LegendItemDefinition for analysisId=" + analysisId });
            }
            if (dataWindow) {
                dataWindow.set_hidden(false);
                dataWindow.selectAndAdd([lid], options);
                return fire(F_SUCCESS, callback, { success: true, analysisId: analysisId, mapServiceId: mapServiceId });
            } else {
                return fire(F_FAILURE, errback, { success: false, message: "No DataWindow object" });
            }
        }
    };

    /**
    * Event Listener. This class is not exposed in the API as instances of it
    * are not supposed to appear in the client code. Purpose of this
    * documentation is to provide documentation for instances of this class
    * existing in the API:
    *
    * {@link $GP.events#mapMoved}
    *
    * {@link $GP.events#featureInfoRequested}
    *
    * @class EventListener
    */
    function EventListener(config) {
        this._eventName = config.eventName;
        this._defaultHandlers = config.defaultHandlers || [];
        this._f = {};
        this._decorator = config.decorator;
    }

    EventListener.prototype = {
        /**
        * Register a handler to the event
        * @method
        * @param {Object/Function} config Configuration options or the handler function
        * @param {Function} config.handler handler to be invoked on the event occurence
        * @param {Boolean} [config.preventDefaults=true] Whether to suppress default event
        * @param {Function} [config.predicate] config.handler is executed only if config.predicate
        * function returns true. Predicate is invoked before the request is sent to the server.
        * In combination with config.fallbackToDefaults it is possible to have custom
        * feature info handler only for certain objects (or map areas)
        * @param {Boolean} [config.fallbackToDefaults=true] Whether to execute default handler
        * if config.predicate returns false, even if default handler is supressed
        * @param {String} [config.token] Token for registration. It must be unique
        * listeners (that means coming from Portal internals). If it is not provided, an unique
        * token is generated.
        * @return {String} token. Token for the event handler that should be used for
        * unregistering it. If it is null, it means that registration was not successfull.
        */
        register: function (config) {
            if (typeof config === T_FUNCTION)
                config = {handler: config};

            var handler = config.handler,
                scope = config.scope,
                preventDefaults = typeof config.preventDefaults === T_UNDEFINED ? true : config.preventDefaults,
                fallbackToDefaults = typeof config.fallbackToDefaults === T_UNDEFINED ? true : config.fallbackToDefaults,
                token = config.token || createUuid(),
                defaultHandlers = this._defaultHandlers;

            if (this._f[token] || typeof handler !== T_FUNCTION)
                return null;

            if (this._decorator) {
                if ([config.predicate, config.requestcompleted].some(function(x) {
                    return typeof x === T_FUNCTION;
                }) && fallbackToDefaults) {
                    // Fallback to execution of default handlers identified by
                    // reference to the function and reference to the scope.
                    // This is a consequence of current $event implementation (13.0)
                    config.fallback = function(eventName, eventArgs, sender) {
                        for (var i = 0, l = defaultHandlers.length; i < l; i++) {
                            var h = defaultHandlers[i].get_handler(),
                                s = defaultHandlers[i].get_scope();
                            if (typeof h === T_FUNCTION)
                                h.call(s, eventName, eventArgs, sender);
                        }
                    };
                }
                handler = this._decorator(config);
            }

            var wrapper = function (eventName, eventArgs, sender) {
                handler.call(scope, eventName, eventArgs, sender);
            };

            this._f[token] = wrapper;
            if (preventDefaults)
                this.suppressDefaults();
            getPortalObj(P_EVENT).register(this._eventName, wrapper, null);
            return token;
        },

        /**
        * Unregister the event handler
        * @method
        * @param {Object/String} config Configuration options or the token
        * @param {String} config.token. Token obtained while registering event handler
        */
        unregister: function (config) {
            var justtoken = typeof config === T_STRING,
                token = justtoken ? config : config.token,
                scope = justtoken ? null : config.scope;
            if (this._f[token]) {
                getPortalObj(P_EVENT).unregister(this._eventName, this._f[token], scope);
                this.restoreDefaults();
                delete this._f[token];
            }
        },

        /**
        * Suppress internal Portal handlers attached to the event
        * @method
        */
        suppressDefaults: function () {
            for (var i = 0, l = this._defaultHandlers.length; i < l; i++) {
                var handler = this._defaultHandlers[i].get_handler(),
                    scope = this._defaultHandlers[i].get_scope();
                if (handler) // scope may be null or undefined
                    getPortalObj(P_EVENT).unregister(this._eventName, handler, scope);
            }
            this._defaultsSuppressed = true;
        },

        /**
        * Restore internal Portal handlers attached to the event
        * @method
        */
        restoreDefaults: function () {
            if (!this._defaultsSuppressed) return;
            for (var i = 0, l = this._defaultHandlers.length; i < l; i++) {
                var handler = this._defaultHandlers[i].get_handler(),
                    scope = this._defaultHandlers[i].get_scope();
                if (handler) // scope may be null or undefined
                    getPortalObj(P_EVENT).register(this._eventName, handler, scope);
            }
        },

        /**
        * Suppress handlers attached to the event
        * @param {Boolean} [suppressDefaults=false] whether to suppress also internal Portal events
        * @method
        */
        suppress: function(suppressDefaults) {
            for (var wrapper in this._f) {
                if (hasOwnProperty.call(this._f, wrapper))
                    getPortalObj(P_EVENT).unregister(this._eventName, this._f[wrapper], null);
            }
            if (suppressDefaults)
                this.suppressDefaults();
        },

        /**
        * Restore handlers attached to the event
        * @param {Boolean} [restoreDefaults=false] whether to restore also internal Portal events
        * @method
        */
        restore: function(restoreDefaults) {
            for (var wrapper in this._f) {
                if (hasOwnProperty.call(this._f, wrapper))
                    getPortalObj(P_EVENT).register(this._eventName, this._f[wrapper], null);
            }
            if (restoreDefaults)
                this.restoreDefaults();
        }
    };

    var Queue = function(scope) {
        scope = scope || {};
        this.scope = scope;
        this.funcs = [];
    };

    Queue.prototype.push = function(fn) {
        this.funcs.push(fn);
    };

    Queue.prototype.flush = function() {
        var fn;
        /*jshint -W084 */
        while (fn = this.funcs.shift())
            fn.call(this.scope);
    };

    var RowActionPlugin = function (descriptors, actionsFilter, actionsFilterScope) {
        this._descriptors = descriptors,
        this._actionsFilter = actionsFilter;
        this._actionsFilterScope = actionsFilterScope;
    };

    RowActionPlugin.prototype = {
        getRowActionButtons: function(properties, scope) {
            var actions = this._descriptors.map(function(d) {
                if (typeof d.predicate === T_FUNCTION && !d.predicate.call(properties))
                    return [];
                return {
                    text: d.text,
                    id: d.id,
                    style: d.style,
                    handler: function(e, rowInfo) {
                        var lid = properties.legendItemDefinition.get_sourceLegendItemDefinition() || properties.legendItemDefinition;
                        d.handler.call(d.scope || scope || gp.ui.dataView, {
                            featureId: rowInfo.id,
                            data: rowInfo.data,
                            mapServiceId: properties.mapServiceId,
                            featureClassId: lid.get_id(),
                            id: properties.legendItemDefinition.get_id(),
                            clipboard: properties.clipboard,
                            fromClipboard: properties.source.fromClipboard,
                            canDelete: properties.canDelete
                        }, e);
                    }
                };
            });
            return actions.filter(this._actionsFilter, this._actionsFilterScope);
        }
    };

    /* API */

    // Global variable!

    originalgp = window.$GP;

    /**
    * # Geospatial Portal JavaScript API #
    *
    * Keep making simple things simple and complex things possible with our new JavaScript API!
    *
    * ## Getting the API ##
    * To use the API, appropriate script file must be included:
    *     <script type="text/javascript" src="js/API.min.js"></script>
    * for the minified version or
    *     <script type="text/javascript" src="js/API.js"></script>
    * for the debug version.
    *
    * All _aspx_ files in the SDK have the script file already included. _Example.aspx_ has it included
    * in debug version and all the rest of the _*.aspx_ files have it included in minified version.
    * **Don't forget to include it in your custom aspx!**
    *
    * ## Using the API ##
    * SDK comes with broad set of live and editable examples and that should make it easy to start
    * getting know what is where and what can be done. But how to start adding your custom code right
    * into your project?""
    *""
    * It is very simple - just by adding new *script* tag in your *aspx*,""
    * either pointing to a separate javascript file aimed for your customizations (as we all love order!):
    *     <script type="text/javascript" src="js/MyCustom.js"></script>
    * or just a simple inline block for playing around:
    *     <script type="text/javascript" >
    *     // Example "0"
    *     $GP.ready(function () {
    *         // Display "Hello World!"
    *         $GP.ui.info("Hello World!");
    *""
    *         // Add button to the toolbar (first tab)
    *         // that displays "Hello from toolbar!"
    *         $GP.ui.toolbar.add({
    *             xtype: "tbbutton",
    *             text: "?",
    *             handler: function (b) {
    *                 $GP.ui.info("Hello from toolbar!");
    *             }
    *         });
    *     });
    *     </script>
    * That script tag must be placed **after** the API.js (or API.min.js) script.
    *
    * **$GP.ready** function abstracts the process of loading the page and scripts necessary for
    * Geospatial Portal to operate and, as its pretty descriptive name announces, executes your
    * code when *$GP is ready*. So it may be generalized in that way:
    *     <script type="text/javascript" >
    *     $GP.ready(function () {
    *         // your code that interacts with the portal
    *     });
    *     </script>
    * To give a detailed information, there are no contraindications to define functions outside
    * of that block and then just make sure that they are executed inside of it.
    *
    * # Overview #
    * API is written in functional style JavaScript and as you can observe in the examples
    * most of the flow control happens in callbacks. This is not driven just by the aesthetics
    * but mainly because of the need of consistency within the API as the Portal relies both on
    * synchronous and asynchronous programming techniques.
    *
    * Most of the functions are written in that way:
    *     function foo (config, callback, errback) {
    *     //...
    *     }
    * where config object simulates named parameters (so instead of passing 5 formal parameters
    * we pass 1 but with a dictionary of properties), callback is function that is executed that
    * is executed when the *foo* operation succeeds (so we can treat it as a kind of _return_ statememnt from
    * the synchronous world) and errback is executed when the *foo* operation fails. Some methods do
    * not have the _errback_ parameter and there the assumption is that _callback_ is executed all the time
    * (this is for simplification where there is rather no possibility of "failing").
    *
    * # Scope #
    * API covers:
    * - map manipulation (zooming, panning, settings...)
    * - legend manipulation (adding, removing layers)
    * - registering services
    * - redlining and drawing
    * - pin layer
    * - coordinate systems
    * - ERDAS APOLLO connectivity
    * - Name search
    * - Basic user interface manipulation
    * - User maps management
    * - Selection set
    * - Other Geospatial Portal features not mentioned here
    *
    * What this API does not cover is creation of specific GUI widgets, as specific GUI widgets should be prepared with
    * specific GUI libraries aimed for creating specific GUI widgets! Current version of Geospatial Portal uses
    * ExtJS version 2.2.1 and the simplest way of creating user interface would be just to follow the Portal and
    * use embedded ExtJS library for GUI. GUI elements can be inserted into the sidebar and toolbar. Of course it
    * is possible to reach totally customized GUI for Geospatial Portal with a little effort of sculpting both in *aspx*
    * files and preparing controls in pure JavaScript!""
    *
    * ***
    * Enjoy using Geospatial Portal JavaScript API!
    * @class $GP
    * @singleton
    */
    gp = {
        _queue: new Queue(window),

        _handlePageLoad: function () {
            if (this.__pageLoadRegistered) return;
            // pageLoad is executed not only when everything is loaded but also with every ASP.NET postback
            // we want to call it just once and then just execute fn
            var oldonload = window.pageLoad;
            window.pageLoad = function () {
                if (typeof oldonload === T_FUNCTION)
                    oldonload();
                if (gp.__pageLoaded)
                    return;
                gp._queue.flush();
                gp.__pageLoaded = true;
                window.pageLoad = oldonload;
            };
            this.__pageLoadRegistered = true;
        },

        /**
        * Wrapper for window.onload that preserves other window.onload if it is present.
        * The load event fires at the end of the document loading process. At this point,
        * all of the objects in the document are in the DOM, and all the images and sub-
        * frames have finished loading.
        * @param {Function} fn Function to be executed after document is ready
        */
        ready: function (apiVersion, fn) {
            if (typeof apiVersion === T_FUNCTION && !isSet(fn)) {
                fn = apiVersion;
                apiVersion = "v1.0";
                warn("[DEPRECATED] you should call \"ready\" function using version as first parameter. Using default version: v1.0");
            }
            if (!apiVersion.match(/^v1\./i))
                throw new Error("API in version " + apiVersion + " doesn't exist");
            this._handlePageLoad();
            this._queue.push(fn);
            if (gp.__pageLoaded)
                this._queue.flush();
        },

        /**
        * Version
        * @property version
        */
        version: "16.00.0104",

        /**
        * Allows to use $GP without conflicts
        * For example: var foo = $GP.noConflict()
        * @method noConflict
        * @return {Object}
        */
        noConflict: function () {
            window.$GP = originalgp;
            return this;
        },

        /**
        * Settings for search
        * @property searchDefaults
        */
        searchDefaults: {
            ep: "all",
            action: "search",
            handler: "SearchHandler",
            mode: 1,
            profile: "full",
            classType: "com.erdas.rsp.babel.model.CatalogItem"
        }
    };

    /**
    * Unified search access point and a shortcut for specific searches
    *
    * Currently supported search types are:
    * - name search (default) Search is performed on all INameSearcher services
    *   registered in the Portal unless another entry point is specified with
    *   "ep" parameter
    * - ERDAS APOLLO search ({searchType: "apollo"})
    *
    * Examples:
    *
    * Name search with WFSG:
    *
    *     $GP.search({
    *         query: "Wars"
    *     },
    *     function (ret) {
    *         ret.results.forEach(function (item) {
    *             $GP.map.pin.add({
    *                 featureClassId: "sample",
    *                 x: item.point.x,
    *                 y: item.point.y
    *             });
    *         });
    *     });
    *
    *
    * Search in ERDAS APOLLO catalogue:
    *
    * [Simple]
    *
    *     $GP.search({
    *         searchType: "apollo",
    *         keywords: "Cherokee"
    *     }, function finish(response) {
    *         $GP.ui.info($GP.utils.serialize(response.results));
    *     });
    *
    *     or
    *
    *     $GP.search.apollo({
    *         keywords: "Cherokee",
    *     }, function finish(response) {
    *         $GP.ui.info($GP.utils.serialize(response.results));
    *     });
    *
    * [Advanced]
    *
    *      $GP.search({
    *          searchType: "apollo",
    *          keywords: "world",
    *          profile: "full",
    *          classType: "com.erdas.rsp.babel.model.imagery.DatasetReference",
    *          addToMapEnabled: true,
    *          wmtsEnabled: true,
    *          ecwpEnabled: true,
    *          jpipEnabled: false,
    *          downladable: true,
    *          orderBy: "registrationDate desc",
    *          dateType: "1",
    *          startDate: "2008-06-19T00:00:00",
    *          endDate: "2013-06-25T23:59:59",
    *          cswQuery: null,
    *          start: 0,
    *          limit: 100,
    *          bbox: ["-30, 33 ,-30, 75, 80,75, 80,33"],
    *          geometryType: "POLYGON"
    *      }, function finish(response) {
    *         $GP.ui.info($GP.utils.serialize(response.results));
    *      });
    *
    * [Operations on ApolloSearchResult]
    *
    *     $GP.search({
    *         searchType: "apollo",
    *         keywords: "Cherokee"
    *     }, function finish(response) {
    *         if (response.success) {
    *             response.results[1].addToMap({
    *                 type: "wms"
    *             }, function (response) {
    *                 if (response.success)
    *                     response.item.zoom({});
    *             });
    *         }
    *     });
    *
    * Search type can be specified by using config.searchType parameter
    * @class $GP.search
    *
    * @singleton
    */
    gp.search = function(config, callback, errback) {
        if (config.searchType === "apollo") {
            gp.search.apollo(config, callback, errback);
        } else {
            gp.search.names(config, callback, errback);
        }
    };

    function handleExecutor(callback, errback, fn, fnret) {
        return function(executor) {
            if (!getPortalObj(P_UTIL).checkExecutor(executor, getPortalObj(P_UTIL).showError)) {
                fire(F_FAILURE, errback, { success: false });
                return;
            }
            var obj = executor.get_object();
            if (obj.error) {
                if (obj.sessionExpired) {
                    getPortalObj(P_SESSION_MANAGER).resume();
                }
                fire(F_FAILURE, errback, { success: false, message: obj.error });
                return;
            }
            var ret = {
                success: true,
                results: fn(obj)
            };
            if (typeof fnret === T_FUNCTION)
                ret = fnret(ret);
            fire(F_SUCCESS, callback, ret);
        };
    }

    function getProcesses(callback, errback) {
        return handleExecutor(callback, errback, function(o) {
            return o.processes.map(function(item) {
                return new Process({
                    portalApolloProcess: item
                });
            });
        });
    }

    function getASR(callback, errback, pName, fnret) {
        return handleExecutor(callback, errback, function(o) {
            return o[pName].map(function(item) {
                return new ApolloSearchResult({
                    portalSearchResult: item
                });
            });
        }, fnret);
    }

    /**
    * ERDAS APOLLO Catalogue search
    * @method apollo
    * @param {Object} config search configuration
    * @param {Number} [config.start] start
    * @param {Number} [config.limit] limit of results that will be fetched
    * @param {String} [config.keywords]
    * @param {String} [config.classType]
    * @param {String} [confg.profile]
    * @param {String} [config.bbox]
    * @param {String} [config.geometryType]
    * @param {Boolean} [config.addToMapEnabled]
    * @param {Boolean} [config.wmtsEnabled]
    * @param {Boolean} [config.ecwpEnabled]
    * @param {Boolean} [config.jpipEnabled]
    * @param {Boolean} [config.downladable]
    * @param {String} [config.orderBy]
    * @param {String} [config.geometryType]
    * @param {String} [config.cswQuery]
    * @param {String} [config.cswQuery]
    * @param {String} [config.dateType]
    * @param {String} [config.startDate]
    * @param {String} [config.endDate]
    * @param {String} [config.nameQualifier]
    * @param {String} [config.template]
    * @param {String} [config.crsId] Optional CRS identifier (for example EPSG:4326) if it needs to be other than current UI CRS
    * @param {Boolean} [config.addToSearchPanel] Determines whether the result of the search be displayed in Search Panel.
    * @param {String} [config.title] Used together with config.addToSearchPanel. Search Result Panel Tab title. If it is not passed, "Search" will be used
    * @param {String} [config.addKeywordsToTitle] Used together with config.addToSearchPanel. Whether to append keywords to the tab title. Defaults to true.
    * @param {Function} [callback] callback executed if operation succeeds
    * @param {Object} [callback.result] Result object
    * @param {Boolean} callback.result.success Always true
    * @param {ApolloSearchResult[]} callback.result.results ERDAS APOLLO catalogue search result object representation
    * @param {Function} [errback] callback executed if operation fails
    * @param {Object} [errback.result] Result object
    * @param {Boolean} errback.result.success Always false
    * @param {String} errback.result.message Additional information
    * @param {Object} errback.result Failure information object
    * @return {void}
    */
    gp.search.apollo = function(config, callback, errback) {
        config = apply({}, config, gp.searchDefaults);
        var apolloMapServiceId = getApolloMapServiceId();
        if (!apolloMapServiceId) {
            fire(F_FAILURE, errback, { success: false, message: M_APOLLO_MISSING });
            return;
        }
        var params = {
            mapServiceId: apolloMapServiceId,
            action: "search",
            profile: config.profile,
            keywords: config.keywords,
            classType: config.classType,
            bbox: config.bbox,
            geometryType: config.geometryType,
            orderBy: config.orderBy,
            cswQuery: config.cswQuery,
            addToMap: config.addToMapEnabled,
            downloadable: config.downloadable,
            wmts: config.wmtsEnabled,
            ecwp: config.ecwpEnabled,
            jpip: config.jpipEnabled,
            dateType: config.dateType,
            dateStart: config.startDate,
            dateEnd: config.endDate,
            currentCrs: config.crsId || gp.crs.getCurrent(),
            nameQualifier: config.nameQualifier,
            queryables: config.queryables ? gp.utils.serialize(config.queryables) : null,
            template: config.template ? gp.utils.serialize(config.template) : null,
            title: config.title,
            addKeywordsToTitle: config.addKeywordsToTitle
        };

        if (isSet(config.limit) && isSet(config.start)) {
            params.limit = config.limit;
            params.start = config.start;
        }

        var apolloSearchRequest = getPortalObj(P_WEB_REQUEST).create({
            name: "ApolloSearch",
            body: params,
            callback: getASR(callback, errback, "results")
        });
        if(config.addToSearchPanel) {
            gp.ui.searchResultPanel.displayResult(params);
        }
        else
            apolloSearchRequest.invoke();
    };

    /**
    * Search in name searcher services
    * @method names
    * @param {Object} config search configuration
    * @param {String} [config.query] query
    * @param {Number} [config.start] start
    * @param {String} [config.ep] entry point (all, selective, parsing)
    * @param {Number} [config.limit] limit of results that will be fetched
    * @param {Function} [callback] callback executed if operation succeeds
    * @param {Object} [callback.result] Result object
    * @param {Boolean} callback.result.success Always true
    * @param {NameSearchResult[]} callback.result.results Name searcher search results
    * @param {Function} [errback] callback executed if operation fails
    * @param {Object} errback.result Failure information
    * @param {Boolean} errback.result.success Always false
    * @param {String} [errback.result.message] Additional information
    * @return {void}
    */
    gp.search.names = function(config, callback, errback) {
        config = apply({}, config, gp.searchDefaults);
        var nameSearchRequest = getPortalObj(P_WEB_REQUEST).create({
            name: config.handler,
            query: {},
            body: {
                action: config.action,
                ep: config.ep,
                query: config.query,
                allMapServiceIds: Object.keys(getPortalObj(P_MAPSERVICE_MANAGER).get_mapServices())[0]
            },
            includeCRS: true,
            callback: handleExecutor(callback, errback, function(o) {
                return o.values.map(function(item) {
                    return new NameSearchResult({
                        portalSearchResult: item
                    });
                });
            })
        });
        nameSearchRequest.invoke();
    };

    window.$GP = gp;
    /* jshint forin: false */
    for (var pName in originalgp)
        if (hasOwnProperty.call(originalgp, pName))
            window.$GP[pName] = originalgp[pName];

    // TODO: handle multiple map states
    gp._getMapState = getMapState;

    var hasJSON = typeof JSON === T_OBJECT;

    /**
    * Utilities
    * @class $GP.utils
    * @singleton
    */
    gp.utils = {
        /**
        * Serializes object to JSON
        * @method
        * @param {Object} object
        * @returns {String}
        */
        serialize: hasJSON ? JSON.stringify : Sys.Serialization.JavaScriptSerializer.serialize,

        /**
        * Reads object from JSON
        * @method
        * @param {String} string
        * @returns {Object}
        */
        deserialize: hasJSON ? JSON.parse : Sys.Serialization.JavaScriptSerializer.deserialize,

        /**
        * Creates simple object with properties in form "xxx" instead of get_xxx() methods
        * @method
        * @param {Object} object
        * @returns {Object}
        */
        dump: dump,

        sdump: function (o) { return this.serialize(this.dump(o)); },

        /**
        * Transform coordinates to screen coordinates
        * @param {Object} config Point in the current CRS coordinates
        * @param {Number} config.x X coordinate in the current CRS coordinates
        * @param {Number} config.y Y coordinate in the current CRS coordinates
        * @param {String} [config.mapStateId] map state id
        * @return {Object} point with screen coordinates
        * @return {Number} return.x X coordinate in the screen coordinates
        * @return {Number} return.y Y coordinate in the screen coordinates
        */
        getInScreenCrs: getXYinScreenResolution,

        /**
        * Transform coordinates to coordinates expressend in the current CRS
        * @param {Object} config Point in the screen coordinates
        * @param {Number} config.x X coordinate in the screen coordinates
        * @param {Number} config.y Y coordinate in the screen coordinates
        * @param {String} [config.mapStateId] map state id
        * @return {Object} point with screen coordinates
        * @return {Number} return.x X coordinate in the current CRS
        * @return {Number} return.y Y coordinate in the current CRS
        */
        getInMapCrs: getXYinMapResolution,

        /**
        * Creates new Globally Unique Identifier
        * @param {String} [dataType] Data type of the identifier. Supported values are:
        * 'System.Byte', 'System.Decimal', 'System.Double', 'System.Int16', 'System.Int32',
        * 'System.Int64', 'System.Single', 'System.UInt16', 'System.UInt32', 'System.UInt64'
        * @return {String} guid Globally Unique Identifier
        */
        newGuid: function(dataType) {
            return getPortalObj(P_SUPPORT).newGuid(dataType);
        },

        /**
        * Converts array of {@link Feature} to GeoJSON FeatureCollection
        * @param {Object} config
        * @param {Feature[]} config.features
        * @param {String} [config.featureClassId]
        * @param {Function} callback Callback is executed on the resulting FeatureCollection
        * @param {Function} errback Error callback
        * @method toFeatureCollection
        * @return {void}
        */
        toFeatureCollection: function(config, callback, errback) {
            findFeatures({
                featureIds: config.features.map(function(proxy) { return proxy.get_id(); }),
                featureClassId: config.featureClassId || config.features[0].get_featureClassId()
            }, function(portalFeatures) {
                var ret = {
                    "type": "FeatureCollection",
                    "features": portalFeatures.map(function(pf) {
                        return getPortalObj(P_GEOJSON).getFeature(pf);
                    })
                };
                fire(F_SUCCESS, callback, ret);
            }, errback);
        }
    };

    // TODO: mapStateId as constructor parameter

    /**
    * Managing services
    * @class $GP.services
    * @singleton
    */
    gp.services = {
        /**
        * Registers and initializes the map service
        * @method add
        * @param {Object} config Configuration options
        * @param {String} config.definitionName Definition Name of the service (WFS, WMS, ...)
        * @param {String} config.url URL of the service
        * @param {Function} [callback] callback executed if operation succeeds
        * @param {Object} callback.result Result object
        * @param {Boolean} callback.result.success Always true
        * @param {String} callback.result.msId Map Service ID
        * @param {String} [callback.result.message] additional information
        * @param {Function} [errback] callback executed if operation fails
        * @param {Object} errback.result Result object
        * @param {Boolean} errback.result.success Always false
        * @param {String} errback.result.msId ID of map service that failed to be registered
        * @param {String} [errback.result.message] additional information
        * @return {void}
        */
        add: function (config, callback, errback) {
            var that = this;
            var definitionName = config.definitionName,
                url = config.url;

            // find whether map service with given URL is already registered
            var msId = getPortalObj(P_MAPSERVICE_MANAGER).findMapServiceByUrl(url);
            if (typeof msId !== T_UNDEFINED) {
                fire(F_SUCCESS, callback, {
                    success: true,
                    msId: msId,
                    mapServiceId: msId,
                    message: "Map service already registered"
                });
                return this;
            }
            msId = config.id || gp.utils.newGuid();

            var configInfo = config2dict(config);
            function _mapServiceInitialized(eventName, eventArgs, sender) {
                if (sender.get_id() !== msId) return;
                if (eventName === E_MAPSERVICE_INITIALIZED) {
                    getPortalObj(P_LOG).writeInfo("map service initialized");
                    fire(F_SUCCESS, callback, {
                        success: true,
                        msId: msId,
                        mapServiceId: msId,
                        message: "Map service successfully registered"
                    });

                }
                if (eventName === E_MAPSERVICE_INIT_FAILED) {
                    getPortalObj(P_LOG).writeInfo("map service initialization failed");
                    fire(F_FAILURE, errback, {
                        success: false,
                        msId: msId,
                        mapServiceId: msId,
                        message: "Map service initialization failed"
                    });
                }
                // this.fire("afterinitialize");
                getPortalObj(P_EVENT).unregister(E_MAPSERVICE_INITIALIZED, _mapServiceInitialized, that);
                getPortalObj(P_EVENT).unregister(E_MAPSERVICE_INIT_FAILED, _mapServiceInitialized, that);
            }
            // this.fire("beforeregister");

            getPortalObj(P_EVENT).register(E_MAPSERVICE_INITIALIZED, _mapServiceInitialized, this);
            getPortalObj(P_EVENT).register(E_MAPSERVICE_INIT_FAILED, _mapServiceInitialized, this);

            // register map service
            getPortalObj(P_MAPSERVICE_MANAGER).registerMapService({
                id: msId,
                config: configInfo,
                definition: {
                    name: definitionName
                }
            });
            // this.fire("afterregister");
            var ms = getPortalObj(P_MAPSERVICE_MANAGER).findMapService(msId);
            // this.fire("beforeinitialize")
            ms.initialize();
            return this;
        },

        /**
        * Finds map service object
        * @method find
        * @param {Object} config Configuration options
        * @param {String} [config.mapServiceId] Service Id
        * @param {String} [config.url] URL (One of URL or mapServiceId should be provided)
        * @param {Function} [config.predicate] predicate to test against services
        * @param {Function} [callback] function that will be executed on results object
        * @param {Object} callback.result list of map service objects
        * @param {Boolean} callback.result.success Always success
        * @param {MapService[]} callback.result.services list of map service objects
        * @param {String[]} callback.result.ids list of IDs of map service objects
        * @param {MapService} callback.result.service returned when there is just a single map service object
        * @param {String} callback.result.mapServiceId returned when there is just a single map service object
        * @param {Function} [errback] function executed on failure or when the result list is empty
        * @param {Object} errback.result Failure information
        * @param {Boolean} errback.result.success Always false
        * @return {void/MapService[]} function returns list of services only if config.async is set
        */
        // TODO: convenience predicates
        find: function (config, callback, errback) {
            var ret = [];
            if (config.mapServiceId || config.url || config.definitionName) {
                var ms = getPortalObj(P_MAPSERVICE_MANAGER).findMapService(config.mapServiceId ||
                    getPortalObj(P_MAPSERVICE_MANAGER).findMapServiceByUrl(config.url)) ||
                    getPortalObj(P_MAPSERVICE_MANAGER).findMapServicesByDefinitionName(config.definitionName);
                if (Array.isArray(ms))
                    ms = ms.filter(function(item) {return item.get_name() === config.name})[0];
                if (ms)
                    ret.push(new MapService({ portalMapService: ms }));
            }
            if (config.predicate) {
                var services = getPortalObj(P_MAPSERVICE_MANAGER).get_mapServices() || [];
                for (var i = 0, l = services.length; i < l; i++)
                    if (!config.predicate(services[i]))
                        ret.push(new MapService({ portalMapService: services[i] }));
            }
            if (!config.successOnEmpty && ret.length < 1) {
                fire(F_FAILURE, errback, {
                    success: false
                });
            } else {
                fire(F_SUCCESS, callback, {
                    success: true,
                    services: ret,
                    ids: ret.map(function(s) { return s.get_id(); }),
                    service: ret.length === 1 ? ret[0] : undefined,
                    mapServiceId: ret.length === 1 ? ret[0].get_id() : undefined
                });
            }
            if (config.async)
                return this;
            return ret;
        }
    };

    /**
    * Managing legend
    * @class $GP.legend
    * @singleton
    */
    gp.legend = {
        // display layers from the existing map service
        _displayLayers: function (config, callback) {
            var ids = findLegendItemDefinitions({
                transformer: function (lid) { return lid.get_id(); },
                names: config.names,
                ids: config.ids,
                mapServiceId: config.mapServiceId,
                allowedTypes: config.allowedTypes
            });
            //TODO: WTF
            var cp = getMapState(config).get_legend().get_flatLegend().length;
            var priorities = {};
            for (var j = ids.length - 1; j >= 0; j--)
                priorities[ids[j]] = cp++;

            var displayStyles = null;
            if (typeof config.userStyleCallback === "function") {
                //TODO: this array should have the same length as ids
                displayStyles = [[{
                    userStyleCallback: function (internalFeature) {
                        var publicFeature = new Feature({
                            portalFeature: internalFeature,
                            mapStateId: getMapState(config).get_id()
                        });
                        var publicStyleConfig = config.userStyleCallback(publicFeature);
                        return getPortalStyle(publicStyleConfig);
                    }
                }]];
            }
            var scope = this;
            function onNewLegendItemAdded(eventName, eventArgs/*, sender*/) {
                if (eventArgs.mapLayerConfigs && eventArgs.mapLayerConfigs.length !== 1)
                    return;
                var mapLayerConfigId = eventArgs.mapLayerConfigs[0].get_id();
                function onMapLayerRendered(eventName2, eventArgs2, sender2) {
                    if (mapLayerConfigId !== sender2.get_config().get_id())
                        return;
                    fire(F_SUCCESS, callback, { success: true, ids: ids });
                    getPortalObj(P_EVENT).unregister(E_MAPLAYER_RENDERED, onMapLayerRendered, scope);
                }
                getPortalObj(P_EVENT).unregister(E_LEGENDITEM_ADDED, onNewLegendItemAdded, scope);
                getPortalObj(P_EVENT).register(E_MAPLAYER_RENDERED, onMapLayerRendered, scope);
            }
            if (config.successAfterRender)
                getPortalObj(P_EVENT).register(E_LEGENDITEM_ADDED, onNewLegendItemAdded, scope);
            // TODO: this method is totally wrong
            getMapState(config).addLegendItemByDefinitionId([config.mapServiceId], [ids], config.name ? [config.name] : null, null, displayStyles, [priorities]);
            if (!config.successAfterRender)
                fire(F_SUCCESS, callback, { success: true, ids: ids });
        },

        _addToMapLayer: function (config, callback, errback) {
            var mapServiceId = config.mapServiceId,
                ids = config.ids,
                names = config.names,
                parentLayerName = config.parentLayerName,
                parentLayerId = config.parentLayerId,
                mapState = getMapState(config),
                mapService = getPortalObj(P_MAPSERVICE_MANAGER).findMapService(mapServiceId);
            if (!mapState)
                return fire(F_FAILURE, errback, { message: "Cannot find mapState" });
            if (!mapService)
                return fire(F_FAILURE, errback, { message: "Cannot find mapService" });
            var msDef = mapService.get_definition(),
                mapLayer = findMapLayer({
                    mapStateId: mapState.get_id(),
                    mapLayerName: parentLayerName,
                    mapLayerId: parentLayerId,
                    mapServiceId: mapServiceId
                });
            if (!mapLayer)
                return fire(F_FAILURE, errback, { message: "Cannot find parent map layer" });
            var mapLayerConfig = mapLayer.get_config(),
                firstLegendItemPriority = mapLayerConfig.get_firstLegendItemPriority(),
                isInLegend = !!mapState.get_legend().get_flatLegend()[firstLegendItemPriority];
            if (msDef.onlyOneItemPerLayer && !isInLegend)
                return fire(F_FAILURE, errback, { message: "Cannot add layer" });
            var lids = findLegendItemDefinitions({
                transformer: function (lid) { return lid; },
                names: names,
                ids: ids,
                mapServiceId: mapServiceId,
                allowedTypes: config.allowedTypes
            });
            if (!lids || !lids.length)
                return fire(F_FAILURE, errback, { message: "No legend items found" });

            mapState.addToMapLayer(lids, mapLayer);
            fire(F_SUCCESS, callback, {
                ids: ids,
                mapStateId: mapState.get_id(),
                parentMapLayerId: mapLayerConfig.get_id()
            });
            return void (0);
        },

        _addDynamic: function(config, callback, errback) {
            var mapServiceId = config.mapServiceId,
                mapService = getPortalObj(P_MAPSERVICE_MANAGER).findMapService(mapServiceId),
                definition = mapService.get_definition(),
                definitionName = definition.name,
                legendItemDefinitionIds = config.ids;
            if (definitionName !== "WMS")
                return fire(F_FAILURE, errback, { message: "Dynamic layers are supported only for WMS" });
            var existingLegendItemDefinitions = mapService.get_legendItemDefinitions(),
                lookup = {};
            existingLegendItemDefinitions.forEach(function(lid) {
                lookup[lid.get_id()] = true;
            });
            var dynamicLayerIds = legendItemDefinitionIds.filter(function(lidid) {
                return !lookup[lidid];
            });
            mapService.createOuterLegendItemDefinitions(dynamicLayerIds, {
                //TODO: handle parameters after supplementing core method
                handler: function(/*actionId, args*/) {
                    return fire(F_SUCCESS, callback, { success: true, dynamicLayerIds: dynamicLayerIds });
                }
            });
            return void(0);
        },

        /**
        * Adds new legend items to the map
        * @method add
        * @param {Object} config Configuration options
        * @param {String[]} [config.names] names
        * @param {String[]} [config.ids] ids
        * @param {String} [config.name] name of the grouping legend item
        * @param {String} [config.url] URL
        * @param {String} [config.definitionName] definition name
        * @param {String} [config.mapServiceId] service id
        * @param {Boolean} [config.topmostParent] Use the topmost layer of the service identified
        * by config.mapServiceId as a parent for all added layers
        * @param {String} [config.parentLayerName] Use parent layer of the service identified by
        * config.mapServiceId and matching layer name
        * @param {String} [config.parentLayerId] Use parent layer of the service identified by
        * config.mapServiceId and matching layer id
        * @param {Boolean} [config.dynamic] Supported only in WMS for now. Load layer that is not present
        * in GetCapabilities document using non-standard GetLayer method. Works only with config.ids
        * @param {Function} [config.predicate] predicate
        * @param {Function} [callback] callback executed if operation succeeds
        * @param {Object} callback.result Result object
        * @param {Boolean} callback.result.success Always true
        * @param {String[]} callback.result.ids Legend Item IDs
        * @param {Function} [errback] callback executed if operation fails
        */
        // TODO: sane approach for APOLLO services with several endpoints
        // TODO: handle layers not present in capabilities (APOLLO)
        // TODO: handle situation when type of registered svc and provided in cfg do not match
        // TODO: handle fancy options passed while registering map service
        // TODO: handle uninitialized map service
        // TODO: define criteria for success and failure
        add: function (config, callback, errback) {
            var mapServiceId = config.mapServiceId,
                url = config.url,
                definitionName = config.definitionName,
                that = this;
            // detect whether map service is already present
            if (!mapServiceId && config.url) {
                mapServiceId = getPortalObj(P_MAPSERVICE_MANAGER).findMapServiceByUrl(url);
            }
            var mapService = getPortalObj(P_MAPSERVICE_MANAGER).findMapService(mapServiceId);
            // if mapServiceId is not provided, add map service by URL
            var dl = isAnySet(config.parentLayerId, config.parentLayerName, config.topmostParent) ? this._addToMapLayer : this._displayLayers;
            if (config.dynamic) {
                var origdl = dl;
                dl = function(config2, callback2, errback2) {
                    that._addDynamic(config2, function() {
                        origdl(config2, callback2, errback2);
                    }, errback2);
                };
            }
            if (mapService) {
                config.mapServiceId = mapServiceId;
                dl(config, callback);
            } else if (url && definitionName) {
                var serviceCfg = apply({}, config, {}, function (cfg, p) {
                    return typeof cfg[p] !== T_FUNCTION;
                });
                gp.services.add(serviceCfg, function (result) {
                    config.mapServiceId = result.msId;
                    dl(config, callback, errback);
                });
            } else fire(F_FAILURE, errback, { success: false });
        },

        /**
        * Finds legend items
        * @method find
        * @param {Object} config If none of prediate, leaf, root, id and name properties are defined,
        * then all legend items are returned
        * @param {Boolean} [config.successOnEmpty] compatibility flag for returning success on empty result list
        * @param {Boolean} [config.leaf] find only leafs in the legend item tree
        * @param {Boolean} [config.root] find only top level items
        * @param {String} [config.id] Find item with a given definition ID
        * @param {String} [config.id] Find item with a given definition ID
        * @param {Number} [config.legendItemId] numeric legend item ID
        * @param {String} [config.name] Find item with a given display name
        * @param {Function} [callback] Callback on success
        * @param {Object} callback.result Result object
        * @param {Boolean} callback.result.success Always true
        * @param {LegendItem[]} callback.result.legendItems list of legend items
        * @param {Function} [errback] Errback on failure
        * @param {Object} errback.result Failure object
        * @param {Boolean} errback.result.success Always false
        * @return {void}
        */
        // TODO: watch out for hierarchical services
        find: function (config, callback, errback) {
            if (typeof config === T_FUNCTION) {
                callback = config;
                config = {};
            }
            config = config || {};
            var ret = [];
            var predicate;
            if (config.predicate)
                predicate = config.predicate;
            else if (config.leaf || config.root === false)
                predicate = function (o) { return !!o._parent; };
            else if (config.root || config.leaf === false)
                predicate = function (o) { return !o._parent; };
            else if (config.id)
                predicate = function (o) { return o.get_definition().get_id() === config.id; };
            else if (config.legendItemId)
                predicate = function (o) { return o.get_id() === config.legendItemId; };
            else if (config.name)
                predicate = function (o) { return o.get_definition().get_name() === config.name; };
            else
                predicate = alwaysTrue;
            var legend = getMapState(config).get_legend();
            var items = rangerWalker({
                childrenGetter: "get_legendItems",
                items: legend.get_legendItems(),
                predicate: predicate
            });
            for (var i = 0, l = items.length; i < l; i++)
                ret.push(new LegendItem({ portalLegendItem: items[i], mapStateId: config.mapStateId }));
            if (!config.successOnEmpty && ret.length < 1)
                fire(F_FAILURE, errback, { success: false });
            else
                fire(F_SUCCESS, callback, { success: true, legendItems: ret });
        }
    };

    /**
    * User workspace
    * @class Workspace
    */
    function Workspace(portalWorkspace) {
        this._ = {
            portalWorkspace: portalWorkspace
        };
        this.id = portalWorkspace.id;
        this.isPublic = portalWorkspace.isPublic;
        this.name = portalWorkspace.name;
        this.date = portalWorkspace.date;
        this.maps = portalWorkspace.maps.map(function(m) { return new Map(m); });
    }

    Workspace.prototype = {
        /**
        * Displays the workspace
        * @param {Object} [config] if config is not passed, the first param is callback
        * @param {String} [config.mapStateId] mapStateId
        * @param {Function} [callback] callback
        * @param {Object} callback.result callback result
        * @param {Workspace} callback.result.workspace callback result
        * @returns {void}
        */
        display: function(config, callback) {
            if (typeof config === T_FUNCTION) {
                callback = config;
                config = {};
            }
            config = config || {};
            var workspace = this,
                mapStateId = getMapState(config).get_id();
            gp.user._getMapStorageManager().displayWorkspace(this.id, mapStateId, function () {
                fire(F_SUCCESS, callback, { workspace: workspace });
            }, workspace);
        },

        /**
        * Removes the workspace
        * @method remove
        */
        remove: function(callback) {
            gp.user._getMapStorageManager().removeWorkspace(this.id, function() {
                getPortalObj(P_EVENT).notify(E_USERMAPLIST_CHANGED, {}, this);
                fire(F_SUCCESS, callback, { success: true });
            });
        },

        /**
        * Sets workspace's name
        * @method set_name
        */
        set_name: function(name, callback) {
            gp.user._getMapStorageManager().setWorkspaceName(this.id, name, function() {
                this.name = name;
                getPortalObj(P_EVENT).notify(E_USERMAPLIST_CHANGED, {}, this);
                fire(F_SUCCESS, callback, { success: true, map: this, workspace: this });
            });
        },

        /**
        * Sets workspace's isPublic flag
        * @method set_isPublic
        */
        set_isPublic: function(isPublic, callback) {
            gp.user._getMapStorageManager().setWorkspacePublic(this.id, isPublic, function() {
                this.isPublic = isPublic;
                getPortalObj(P_EVENT).notify(E_USERMAPLIST_CHANGED, {}, this);
                fire(F_SUCCESS, callback, { success: true, map: this, workspace: this });
            });
        }
    };

    /**
    * User map
    * @class Map
    */
    function Map(portalMap) {
        this._ = {
            portalMap: portalMap
        };
        this.id = portalMap.id;
        this.isPublic = portalMap.isPublic;
        this.name = portalMap.name;
        this.date = portalMap.date;
    }

    Map.prototype = {
        /**
        * Displays the map
        * @param {Object} [config] if config is not passed, the first param is callback
        * @param {String} [config.mapStateId] mapStateId
        * @param {Function} [callback] callback
        * @param {Object} callback.result callback result
        * @param {Map} callback.result.map callback result
        * @returns {void}
        */
        display: function (config, callback) {
            if (typeof config === T_FUNCTION) {
                callback = config;
                config = {};
            }
            config = config || {};
            var map = this,
                mapStateId = getMapState(config).get_id();
            gp.user._getMapStorageManager().displayMap(this.id, mapStateId, function () {
                fire(F_SUCCESS, callback, { map: map });
            }, map);
        },

        /**
        * Removes the map
        * @method remove
        */
        remove: function(callback) {
            gp.user._getMapStorageManager().removeMap(this.id, function() {
                getPortalObj(P_EVENT).notify(E_USERMAPLIST_CHANGED, {}, this);
                fire(F_SUCCESS, callback, { success: true });
            });
        },

        /**
        * Sets map's name
        * @method set_name
        */
        set_name: function(name, callback) {
            gp.user._getMapStorageManager().setMapName(this.id, name, function() {
                this.name = name;
                getPortalObj(P_EVENT).notify(E_USERMAPLIST_CHANGED, {}, this);
                fire(F_SUCCESS, callback, { success: true, map: this });
            });
        },

        /**
        * Sets map's isPublic flag
        * @method set_isPublic
        */
        set_isPublic: function(isPublic, callback) {
            gp.user._getMapStorageManager().setMapPublic(this.id, isPublic, function() {
                this.isPublic = isPublic;
                getPortalObj(P_EVENT).notify(E_USERMAPLIST_CHANGED, {}, this);
                fire(F_SUCCESS, callback, { success: true, map: this });
            });
        }
    };

    /**
    * Managing users - login, logout etc
    * @class $GP.user
    * @singleton
    */
    gp.user = {
        _getMapStorageManager: function () {
            return getPortalObj(P_PLATFORM).MapStorage.MapStorageManager;
        },

        /**
        * Attempts to log in user with given credentials
        * @method login
        * @param {Object} config Configuration options
        * @param {String} config.username Username
        * @param {String} config.password Username
        * @param {Function} callback Callback executed after receiving server response
        * @param {Object} callback.result Result object
        * @param {String} callback.result.username Username
        * @param {Object} callback.result.result Additional info
        * @return {void}
        */
        login: function (config, callback) {
            manageUserProfile("logIn", config.username, config.password, callback);
        },

        /**
        * Returns current user id (or null)
        * @method getCurrent
        * @return {String} current user id
        */
        getCurrent: function () {
            return getPortalObj(P_USER_MANAGER).getActiveUser();
        },

        /**
        * Attempts to log in user with given credentials
        * @method logout
        * @param {Function} callback Callback executed after receiving server response
        * @param {Object} callback.result Result object
        * @param {String} callback.result.username Username
        * @param {Object} callback.result.result Additional info
        * @return {void}
        */
        logout: function (callback) {
            manageUserProfile("logOut", callback);
        },

        /**
        * Managing user workspaces (anonymous by default)
        * @class $GP.user.workspaces
        * @singleton
        */
        workspaces: {
            /**
            * Gets all user's workspaces. If predicate is not defined, all workspaces are returned
            *
            *     $GP.user.workspaces.find(function (ret) {// ret.workspaces...});
            *
            *
            *     $GP.user.workspaces.find({
            *         predicate: function (ws) {return /^T/.test(ws.name)}},
            *         function (ret) {// ret.workspaces...});
            *
            * @method find
            * @param {Function/Object} config search options
            * @param {Function} [config.predicate] filter for searching workspaces function (workspace) {return {Boolean}}
            * @param {Function} callback executed on workspace collection
            * @param {Object} callback.result Result object
            * @param {Workspace[]} callback.result.workspaces Workspaces list
            * @return {void}
            */
            find: function (config, callback) {
                if (typeof config === T_FUNCTION) {
                    callback = config;
                    config = {};
                }
                config = config || {};
                var findBy = makeFindByPredicate({ key: "id", value: config.id }, {key: "name", value: config.name});
                var predicate = config.predicate || ((isSet(config.id) || isSet(config.name)) ? findBy : alwaysTrue);
                gp.user._getMapStorageManager().getContent(function (result) {
                    var ret = [], ws = result.workspaces || [];
                    for (var i = 0, l = ws.length; i < l; i++) {
                        if (predicate(ws[i]))
                            ret.push(new Workspace(ws[i]));
                    }
                    fire(F_SUCCESS, callback, { workspaces: ret });
                });
            },

            /**
            * Adds workspace from current view
            * @method add
            * @param {Object} config Configuration
            * @param {String} config.name Name of the workspace
            * @param {String} [config.mapStateId] mapStateId ("map" by default)
            * @param {Boolean} [config.isPublic] whether to make the workspace public
            * @param {Boolean} [config.includeCredentials] whether to include services’ credentials
            * @param {Boolean} [config.includeSelection] whether to include current selection
            * @param {Function} callback Callback executed after creating a new workspace
            * @param {Workspace} callback.workspace added workspace
            * @return {void}
            */
            add: function (config, callback) {
                var saveWorkspaceConfig = apply({}, config, {
                    mapStateId: getMapState(config).get_id(),
                    handler: function(result) {
                        getPortalObj(P_EVENT).notify(E_USERMAPLIST_CHANGED, {}, this);
                        var workspace = new Workspace(result.workspace);
                        if (isSet(config.isPublic)) {
                            workspace.set_isPublic(config.isPublic, function(result) {
                                fire(F_SUCCESS, callback, result.workspace);
                            });
                        } else {
                            fire(F_SUCCESS, callback, workspace);
                        }
                    },
                    scope: this
                });
                gp.user._getMapStorageManager().saveWorkspace(saveWorkspaceConfig);
            },

            /**
            * Removes workspaces with the given criteria
            * @param {Object} config
            * @param {String} [config.id]
            * @param {String} [config.name]
            * @param {Function} [config.predicate] filter for searching maps function (map) {return {Boolean}}
            * @param {Function} config.callback success callback
            * @param {Object} config.callback.ret returned object
            * @param {String[]} config.callback.ret.ids IDs of the deleted workspaces
            * @param {Function} config.errback failure callback
            * @return {void}
            */
            remove: function (config, callback, errback) {
                this.find(config, function (ret) {
                    var toRemove = ret.workspaces;
                    if (!Array.isArray(toRemove) || toRemove.length === 0) {
                        fire(F_FAILURE, errback, { message: "No workspaces found" });
                        return;
                    }
                    var ids = toRemove.map(function(ws) { return ws.id; }),
                        nextCallback = function () {
                            var ws = toRemove.shift();
                            if (!ws) {
                                fire(F_SUCCESS, callback, { ids: ids });
                            } else {
                                ws.remove(nextCallback);
                            }
                        };
                    nextCallback();
                }, errback);
            },

            /**
            * Current workspace
            * @class $GP.user.workspaces.current
            * @singleton
            */
            current: {
                /**
                * Clears current workspace
                * @method clear
                */
                clear: function(config, callback) {
                    config = config || {};
                    var m = getMapState(config);
                    m.clearMap();
                    getPortalObj(P_MAPSERVICE_MANAGER).removeAllMapServices(function() {
                        //var v = m.get_variants();
                        //m.removeAllMapStateVariants();
                        getPortalObj(P_EVENT).notify("mapStateVariantListChanged", { mapStateId: m.get_id() }, this);
                        fire(F_SUCCESS, callback, {success: true});
                    });
                }
            }
        },

        /**
        * Managing user maps (anonymous by default)
        * @class $GP.user.maps
        * @singleton
        */
        maps: {
           /**
            * Gets all user's maps. If predicate is not defined, all maps are returned
            *
            *     $GP.user.maps.find(function (ret) {// ret.workspaces...});
            *
            *
            *     $GP.user.maps.find({
            *         predicate: function (ws) {return /^T/.test(ws.name)}},
            *         function (ret) {// ret.maps...});
            *
            * @method find
            * @param {Function/Object} config search options
            * @param {Function} [config.predicate] filter for searching maps function (workspace) {return {Boolean}}
            * @param {Function} callback executed on maps collection
            * @param {Object} callback.result Result object
            * @param {Map[]} callback.result.maps Maps list
            * @return {void}
            */
            find: function (config, callback) {
                if (typeof config === T_FUNCTION) {
                    callback = config;
                    config = {};
                }
                config = config || {};
                var findBy = makeFindByPredicate({ key: "id", value: config.id }, { key: "name", value: config.name });
                var predicate = config.predicate || ((isSet(config.id) || isSet(config.name)) ? findBy : alwaysTrue);
                gp.user._getMapStorageManager().getContent(function (result) {
                    var ret = [], ws = result.maps || [];
                    for (var i = 0, l = ws.length; i < l; i++) {
                        if (predicate(ws[i]))
                            ret.push(new Map(ws[i]));
                    }
                    fire(F_SUCCESS, callback, { maps: ret });
                });
            },

            /**
            * Adds map from current view
            * @method add
            * @param {Object} config Configuration
            * @param {String} config.workspace id of the workspace
            * @param {String} config.name Name of the workspace
            * @param {String} config.isPublic whether to make the map public
            * @param {Function} callback Callback executed after creating a new workspace
            * @param {Map} callback.map added map
            * @return {void}
            */
            add: function (config, callback) {
                // TODO: logic of saveMap is strange if it goes about choosing map name so we manually update the map name
                gp.user._getMapStorageManager().saveMap("map", config.workspace || null, config.name, function (result) {
                    if (result && result.map && result.map.id)
                        gp.user._getMapStorageManager().setMapName(result.map.id, config.name);
                    var ret = new Map(result.map);
                    if (isSet(config.isPublic)) {
                        ret.set_isPublic(config.isPublic, function(ret2) {
                            fire(F_SUCCESS, callback, ret2.map);
                        });
                    } else {
                        fire(F_SUCCESS, callback, ret);
                    }
                    getPortalObj(P_EVENT).notify(E_USERMAPLIST_CHANGED, {}, this);
                }, this);
            },

            /**
            * Removes maps with the given criteria
            * @param {Object} config
            * @param {String} [config.id]
            * @param {String} [config.name]
            * @param {Function} [config.predicate] filter for searching maps function (map) {return {Boolean}}
            * @param {Function} config.callback success callback
            * @param {Object} config.callback.ret returned object
            * @param {String[]} config.callback.ret.ids IDs of the deleted maps
            * @param {Function} config.errback failure callback
            * @return {void}
            */
            remove: function (config, callback, errback) {
                this.find(config, function (ret) {
                    var toRemove = ret.maps;
                    if (!Array.isArray(toRemove) || toRemove.length === 0) {
                        fire(F_FAILURE, errback, { message: "No maps found" });
                        return;
                    }
                    var ids = toRemove.map(function(ws) { return ws.id; }),
                        nextCallback = function () {
                            var ws = toRemove.shift();
                            if (!ws) {
                                fire(F_SUCCESS, callback, { ids: ids });
                            } else {
                                ws.remove(nextCallback);
                            }
                        };
                    nextCallback();
                }, errback);
            }
        },

        apollo: {
            getCurrent: function() {
                var service = getPortalObj(P_MAPSERVICE_MANAGER).findMapServicesByDefinitionName("Apollo")[0];
                return service && service.get_userName();
            }
        }
    };



    /**
    * Events container
    * @class $GP.events
    * @singleton
    */
    gp.events = {
        /**
        * Fired when map range changes
        * @event mapMoved
        * @param {function(): void/Object} config function that is going to be executed when the event is fired or handler object
        * @param {function(): void} [config.handler] Explicit version of passing the handler
        * @param {String} [config.token] Option to pass token explicitly not to use a generated one
        */
        mapMoved: new EventListener({
            eventName: E_MAPRANGE_CHANGED
        }),

        /**
        * Fired when new legend item is added
        * @event legendItemAdded
        * @param {function(): void/Object} config function that is going to be executed when the event is fired or handler object
        * @param {function(legendItem: LegendItem): void} [config.handler] Explicit version of passing the handler
        * @param {LegendItem} [config.handler.legendItem] LegendItem that has been added
        * @param {String} [config.token] Option to pass token explicitly not to use a generated one
        */
        legendItemAdded: new EventListener({
            eventName: E_LEGENDITEM_ADDED,
            decorator: function(config) {
                var callback = config.handler;
                return function (eventName, eventArgs/*, sender*/) {
                    eventArgs.mapLayerConfigs.forEach(function (mapLayerConfig) {
                        mapLayerConfig.forEachLegendItem(function (item) {
                            gp.legend.find({ legendItemId: item.get_id() }, function (ret) {
                                fireEventHandler("legendItemAdded", callback, ret.legendItems[0]);
                            });
                        }, this);
                    });
                };
            }
        }),

        /**
        * Fired when legend item is removed
        * @event legendItemRemoved
        * @param {Function} handler function that is going to be executed when the event is fired
        */
        legendItemRemoved: new EventListener({
            eventName: E_LEGENDITEM_REMOVED,
            decorator: function (config) {
                var callback = config.handler;
                return function (eventName, eventArgs/*, sender*/) {
                    var legendItemIds = eventArgs.removedLegendItemsDefinitionId;
                    legendItemIds.forEach(function (id) {
                        fireEventHandler("legendItemRemoved", callback, id);
                    });
                };
            }
        }),

        /**
        * Fired when legend item (map layer) starts rendering
        * @event legendItemLoadingStarted
        * @param {Function} handler function that is going to be executed when the event is fired
        */
        //TODO: find actual map layer
        legendItemLoadingStarted: new EventListener({
            eventName: E_MAPLAYER_RENDERING,
            decorator: function (config) {
                var callback = config.handler;
                return function (eventName, eventArgs/*, sender*/) {
                    var mapLayerConfigId = eventArgs.mapLayerConfigId;
                    fireEventHandler("legendItemLoadingStarted", callback, { mapLayerConfigId: mapLayerConfigId });
                };
            }
        }),

        /**
        * Fired when legend item (map layer) stops rendering
        * @event legendItemLoadingFinished
        * @param {Function} handler function that is going to be executed when the event is fired
        */
        //TODO: find actual map layer
        legendItemLoadingFinished: new EventListener({
            eventName: E_MAPLAYER_RENDERED,
            decorator: function (config) {
                var callback = config.handler;
                return function (eventName, eventArgs/*, sender*/) {
                    var mapLayerConfigId = eventArgs.mapLayerConfigId;
                    fireEventHandler("legendItemLoadingFinished", callback, { mapLayerConfigId: mapLayerConfigId });
                };
            }
        }),

        /**
        * Fired when legend item visibility is modified
        * @event legendItemVisibilityChanged
        * @param {Function} handler function that is going to be executed when the event is fired
        */
        legendItemVisibilityChanged: new EventListener({
            eventName: E_LEGENDITEM_VISIBILITY_CHANGED,
            decorator: function (config) {
                var callback = config.handler;
                return function (eventName, eventArgs/*, sender*/) {
                    var legendItemIds = eventArgs.legendItems.map(function (x) { return x.get_id(); });
                    legendItemIds.forEach(function (legendItemId) {
                        gp.legend.find({ legendItemId: legendItemId }, function (ret) {
                            fireEventHandler("legendItemVisibilityChanged", callback, ret.legendItems[0]);
                        });
                    });
                };
            }
        }),

        /**
        * Fired when selection set of vector features is modified
        * @event selectedFeaturesChanged
        * @param {Function} handler function that is going to be executed when the event is fired
        */
        selectedFeaturesChanged: new EventListener({
            eventName: E_SELECTEDFEATURES_CHANGED,
            decorator: function(config) {
                var callback = config.handler;
                return function (eventName, eventArgs /*, sender*/) {
                    var ret = {},
                        allSelectedFeatures = getPortalObj(P_SELECTEDFEATURES).getAllSelectedFeatures();
                    if (eventArgs && eventArgs.legendItemDefinitions) {
                        ret.featureClassIds = eventArgs.legendItemDefinitions
                            .map(function (lid) { return lid.get_id(); });
                    }
                    /*jshint forin:false */
                    ret.featureStubs = transformSelectedFeaturesSet(allSelectedFeatures);
                    fireEventHandler("selectedFeaturesChanged", callback, ret);
                };
            }
        }),

        /**
        * Fired when feature info operation is invoked.
        * It is an instance of the private type {@link EventListener}.
        * @event featureInfoRequested
        *
        * 1) The simplest case in which we override default feature info behavior
        * by providing a handler that is invoked after data is requested from
        * the server:
        *     var handler = function (result) {
        *         // do something with feature info data from the server
        *         // for example:
        *         $GP.ui.info($GP.utils.serialize(result));
        *     }
        *     var token = $GP.events.featureInfoRequested.register(handler);
        *     // some sophisticated logic here ;-)
        *     // $GP.events.featureInfoRequested.unregister(token);
        * By default, when the simple function is passed as the first parameter
        * "preventDefaults" is set to true, so the handler overwrites the default
        * featureInfo behavior. Please mind that for unregistering the handler you
        * need the token that was obtained during handler registration
        * Note that the code above may be written very expressively:
        *     var token = $GP.events.featureInfoRequested.register(function (result) {
        *         $GP.ui.info($GP.utils.serialize(result));
        *     });
        *     // some sophisticated logic here ;-)
        *     // $GP.events.featureInfoRequested.unregister(token);
        *
        * 2) It is possible to define more advanced logic of the custom featureInfo. In
        * the following example custom featureInfo is executed only when geographic
        * coordinates of the selected point indicate that it is not in Poland:
        *
        *     var token = $GP.events.featureInfoRequested.register({
        *        handler: function (result) {
        *            $GP.ui.info($GP.utils.serialize(result))
        *        },
        *        predicate: function (args) {
        *            var point = {
        *                x: args.x,
        *                y: args.y
        *            },
        *                gpoint = $GP.utils.getInMapCrs(point);
        *            if (gpoint.x < 24 && 14 < gpoint.x && gpoint.y < 55 && 49 < gpoint.y) {
        *                return false
        *            }
        *            return true;
        *        }
        *     });
        *     // some sophisticated logic here ;-)
        *     // $GP.events.featureInfoRequested.unregister(token);
        *
        * 3) If default response from the server is not enough, it is possible
        * to redirect request to a custom HTTP handler:
        *
        *     var token = $GP.events.featureInfoRequested.register({
        *        handler: function (result) {
        *            $GP.ui.info($GP.utils.serialize(result))
        *        },
        *        httpHandler: "MyCustomFeatureInfoHandler.WebClient.ashx",
        *        transformargs: function (args) {
        *            args.foo = 42;
        *            return args;
        *        }
        *     });
        * where MyCustomFeatureInfoHandler is name of the CLR type that
        * is marked with WebClientHandlerAttribute.
        *
        * Parameters that can be passed to $GP.events.featureInfoRequested.register:
        * @param {Object} config Configuration options
        * @param {Function} config.handler callback function that takes
        * feature info results obtained from the server as its first
        * parameter. For example:
        *     function (result) {
        *         $GP.ui.info($GP.utils.serialize());
        *     }
        *
        * @param {Function} [config.transformargs] function that can modify
        * object used in featureInfo retrieval
        * @param {Function} [config.requestcompleted] function that can control
        * display of featureInfo after retrieving the data. If this function returns
        * false, then [config.fallback] is used for displaying the data. If it returns
        * true, then callback is called. Callback can render custom feature info
        * control. By default the [config.fallback] is bound to displaying standard 
        * featureInfo control.
        * @param {Function} [config.predicate] Function that can prevent sending
        * custom featureInfo request when it returns false. [config.fallback] is used
        * in that condition. By default [config.fallback] executes standard featureInfo
        * behavior.
        * @param {Function} [config.fallback] Fallback for the callback. See
        * [config.requestcompleted] and [config.predicate] for details.
        * @param {Function} [config.httphandler] By default requests for
        * feature info are send to "api/stateful/featureInfo" endpoint.
        * It is possible to create your custom http handler marked with
        * that attribute and pass its name here to provide custom handling.
        */
        featureInfoRequested: new EventListener({
            eventName: E_SHOW_FEATUREINFO,
            decorator: createFeatureInfoHandler,
            // Default handlers are defined by reference to the function and reference to the scope
            // in case of the "showFeatureInfo" control, default handlers are _showFeatureInfo
            // methods from default FeatureInfoControl and from FeatureInfoLightControl.
            // Scope object is found by scanning objects that are instances of these controls.
            defaultHandlers: [{
                get_handler: function() {
                    return getPortalObj(GP_INTERNAL).featureInfoController._checkSessionBeforeFeatureInfo;
                },
                get_scope: function() {
                    return getPortalObj(GP_INTERNAL).featureInfoController;
                }
            }]
        }),
        /*
        * Fired when feature info for all layers is invoked.
        * Fires only when portal is in multi layer feature info mode
        * ("displayInfoForAllLayers" should be turned on in web.config)
        * It is an instance of the private type {@link EventListener}.
        * @event featureInfoForAllLayersRequested
        */
        featureInfoForAllLayersRequested: new EventListener({
            eventName: E_SHOW_FEATUREINFO_ALL_LAYERS,
            decorator: createFeatureInfoForAllLayersHandler,
            // Default handlers are defined by reference to the function and reference to the scope
            // in case of the "showFeatureInfo" control, default handlers are _showFeatureInfo
            // methods from default FeatureInfoControl and from FeatureInfoLightControl.
            // Scope object is found by scanning objects that are instances of these controls.
            defaultHandlers: [{
                get_handler: function() {
                    return getPortalObj(GP_INTERNAL).featureInfoController._checkSessionBeforeFeatureInfo;
                },
                get_scope: function() {
                    return getPortalObj(GP_INTERNAL).featureInfoController;
                }
            }]
        })
    };

    /**
    * Map control operations
    * @class $GP.map
    * @singleton
    */
    gp.map = {
        /**
        * Gives id of current map variant
        * @method getCurrentVariant
        * @param {Object} [config]
        * @param {String} [config.mapStateId] mapStateId ("map" by default)
        * @param {Function} callback
        * @param [String] callback.variantId ID of the current map variant
        * @return {void}
        */
        getCurrentVariant: function(config, callback) {
            if (typeof config === T_FUNCTION && !isSet(callback))
                callback = config;
            if (!isSet(config) || typeof config !== T_OBJECT)
                config = {};
            var mapState = getMapState(config),
                variantId = mapState.get_currentVariantId();
            fire(F_SUCCESS, callback, { variantId: variantId });
        },

        /**
        * Sets current map variant
        * @method setCurrentVariant
        * @param {Object} config
        * @param {String} config.variantId ID of the desired map variant
        * (map variant ids can be fetched using $GP.map.getVariantIds)
        * @param {Boolean} [config.keepMapRange] Doesn't change the map range if true
        * @param {String} [config.mapStateId] mapStateId ("map" by default)
        * @param {Function} callback
        * @param [String] callback.variantId ID of the current map variant
        * @param [String] callback.mapStateId mapStateId
        * @param {Function} errback Fired when arguments are invalid
        * @return {void}
        */
        setCurrentVariant: function (config, callback, errback) {
            config = config || {};
            var variantId = config.variantId,
                setNewMapRange = !config.keepMapRange,
                mapState = getMapState(config);
            if (!isSet(variantId))
                return fire(F_FAILURE, errback, { message: "No such a variant" });
            function onVariantChanged(eventName, eventArgs) {
                fire(F_SUCCESS, callback, { variantId: eventArgs.mapStateVariantId, mapStateId: eventArgs.mapStateId});
                getPortalObj(P_EVENT).unregister(E_VARIANT_CHANGED, onVariantChanged, null);
            }
            getPortalObj(P_EVENT).register(E_VARIANT_CHANGED, onVariantChanged, null);
            mapState.setVariant(variantId, true, setNewMapRange);
            return void(0);
        },

        /**
        * Gives ids of map variants of the current map
        * @method getVariants
        * @param {Object} [config]
        * @param {String} [config.mapStateId] mapStateId ("map" by default)
        * @param {Function} callback
        * @param [String] callback.variantIds Variant IDs
        * @return {void}
        */
        getVariants: function (config, callback) {
            if (typeof config === T_FUNCTION && !isSet(callback))
                callback = config;
            if (!isSet(config) || typeof config !== T_OBJECT)
                config = {};
            var mapState = getMapState(config),
                variantIds = mapState.get_variants()
                .filter(function (x) { return x.id !== "__default_"; })
                .map(function (x) { return x.id; });
            fire(F_SUCCESS, callback, { variantIds: variantIds });
        },

        /**
        * Returns (in a callback) identifier of the current map mode ["WCMyvrMapControl","WCMapControl"]
        * @method getMode
        * @param {Object/Function} config. If config is a function, then it is treated as a callback
        * @param {String} [config.mapStateId] Map State ID
        * @param {Function} callback Callback
        * @param {String} callback.id ID of the map control mode
        * @return {void}
        */
        getMode: function (config, callback) {
            if (typeof config === T_FUNCTION && !isSet(callback))
                callback = config;
            var mapState = getMapState(config),
                mapControl = mapState.get_mapControl(),
                definitionName = mapControl.get_definitionName();
            return fire(F_SUCCESS, callback, { id: definitionName });
        },

        /**
        * Change map mode (2d/3d)
        * @method setMode
        * @param {Object} config
        * @param {String} config.id definition name the map control ["WCMyvrMapControl","WCMapControl"]
        * @return
        */
        setMode: function (config, callback, errback) {
            config = config || {};
            var mapState = getMapState(config),
                mc = mapState.get_mapControl(),
                dn = mc.get_definitionName(),
                e = getPortalObj(P_EVENT);
            function onMapControlChanged(eventName, eventArgs /*, sender*/) {
                if (mapState.get_id() !== eventArgs.mapStateId) return;
                fire(F_SUCCESS, callback, { success: true, id: config.id });
                e.unregister("mapControlChanged", onMapControlChanged, null);
            }
            if (["WCMyvrMapControl", "WCMapControl"].indexOf(config.id) < 0) {
                return fire(F_FAILURE, errback, { success: false });
            }
            if (config.id === dn)
                return fire(F_SUCCESS, callback, { success: true });
            e.register("mapControlChanged", onMapControlChanged, null);
            e.notify("switch3d2d", { id: config.id });
            return null;
        },

        /**
        * Transform
        * @method transform
        * @param {Object} config Configuration parameters
        * @param {Number} [config.offsetX]
        * @param {Number} [config.offsetY]
        * @param {Number} [config.x]
        * @param {Number} [config.y]
        * @param {Number} [config.minX]
        * @param {Number} [config.minY]
        * @param {Number} [config.maxX]
        * @param {Number} [config.maxY]
        * @param {Number} [config.scaleDenominator]
        * @param {Number} [config.zoomFactor]
        * @param {String} [config.mapStateId]
        * @param {Function} callback Callback exectuted on success
        * @param {Object} callback.result Result object
        * @param {Boolean} callback.result.success Always "True"
        * @param {Function} errback Callback executed on failure
        * @param {Object} errback.result Result object
        * @param {Boolean} errback.result.success Always "False"
        * @param {String} errback.result.message Message about errback
        */
        transform: function(config, callback, errback) {
            config = config || {};
            var mapState = getMapState(config),
                currentMapRange = mapState.get_mapRange().serialize(),
                vec, point, bbox, scaleDenominator = config.scaleDenominator, options = config.options;
            if (isAnySet(config.offsetX, config.offsetY)) {
                vec = new (getPortalObj(P_SIZE))(isSet(config.offsetX) ? config.offsetX : 0, isSet(config.offsetY) ? config.offsetY : 0);
            }
            if (isEverySet(config.minX, config.minY, config.maxX, config.maxY)) {
                bbox = new (getPortalObj(P_MAPRANGE))([config.minX, config.minY, config.maxX, config.maxY]);
            }
            if (isAnySet(config.x, config.y)) {
                point = {
                    x: isSet(config.x) ? config.x : (currentMapRange[2] - currentMapRange[0])/2,
                    y: isSet(config.y) ? config.y : ((currentMapRange[3] - currentMapRange[1])/2)
                };
            }
            if (!isAnySet(scaleDenominator, bbox, point, vec, config.zoomFactor)) {
                fire(F_FAILURE, errback, { success: false, message: "Invalid parameters" });
                return;
            }
            if (isSet(scaleDenominator)) {
                var min = mapState.get_minScaleDenominator(),
                    max = mapState.get_maxScaleDenominator();
                if (min)
                    scaleDenominator = Math.max(scaleDenominator, min);
                if (max)
                    scaleDenominator = Math.min(scaleDenominator, max);
            }
            if (isSet(bbox))
                mapState.set_mapRange(bbox, options);
            if (isSet(point))
                mapState.centerToPoint(point.x, point.y);
            if (isSet(vec)) {
                if (config.duration) {
                    var count = config.duration/100, stepX = vec.width/count, stepY = vec.height/count,
                    t = setInterval(function() {
                        if (--count) {
                            gp.map.transform({ offsetX: stepX, offsetY: stepY });
                        } else clearTimeout(t);
                    }, 100);
                } else {
                    mapState.get_mapRange().movePx(vec, mapState.get_mapControl().get_mapSize());
                    getPortalObj(P_EVENT).notify(E_MAPRANGE_CHANGED, { mapStateId: mapState.get_id() }, this);
                }
            }
            if (isSet(scaleDenominator)) {
                mapState.get_mapControl().set_scaleDenominator(scaleDenominator, options);
                getPortalObj(P_EVENT).notify(E_SCALE_CHANGED, { scaleDenominator: scaleDenominator, mapStateId: mapState.get_id() }, this);
            }
            if (isSet(config.zoomFactor))
                mapState.zoom(config.zoomFactor);
            fire(F_SUCCESS, callback, { success: true });
        },

        /**
        * Pans the map
        * @method pan
        * @param {Object/Array} config
        * @param {Number} [config.x] x
        * @param {Number} [config.y] y
        * @param {String} [config.mapStateId] map state id
        * @param {Function} [callback] callback executed if operation succeeds
        * @param {Object} callback.result Result object
        * @param {Boolean} callback.result.success Always "true"
        * @param {Function} [errback] callback executed if operation fails
        * @param {Object} errback.result Result object
        * @param {Boolean} errback.result.success Always "false".
        * @param {String} errback.result.message Message what is wrong.
        * See {@link $GP.map#transform}
        */
        pan: function (config, callback, errback) {
            var cfg = typeof config === T_OBJECT ? config : {};
            if (Array.isArray(config)) {
                cfg.offsetX = config[0];
                cfg.offsetY = config[1];
            }
            else if (isEverySet(cfg.x, cfg.x)) {
                delete config.x;
                delete config.y;
                cfg.offsetX = config.x;
                cfg.offsetY = config.y;
            }
            this.transform(cfg, callback, errback);
        },

        /**
        * Zooms the map according to the passed parameters. If no parameters
        * are passed, then result of this method is setting map mode to "zoom
        * by rectangle"
        * @method zoom
        * @param {Number[]/Number/Object} config bbox/zoomfactor/config
        * @param {Number[]} [config.bbox] BBOX
        * @param {Number} [config.zoomFactor] zoom factor
        * @param {Number} [config.scaleDenominator] zoom scale denominator
        * @param {String} [config.mapStateId] map state id
        * @param {Number} [config.x] Point x
        * @param {Number} [config.y] Point y
        * @param {Function} [callback] callback executed if operation succeeds
        * @param {Object} callback.result Result object
        * @param {Boolean} callback.result.success Always "true"
        * @param {Function} [errback] callback executed if operation fails
        * @param {Object} errback.result Result object
        * @param {Boolean} errback.result.success Always "false"
        * @param {String} errback.result.message Message what is wrong.
        * See {@link $GP.map#transform}
        */
        zoom: function (config, callback, errback) {
            var cfg = typeof config === T_OBJECT ? config : {};
            if (typeof config === T_NUMBER) {
                cfg.zoomFactor = config;
            }
            else if (Array.isArray(config)) {
                cfg.minX = config[0];
                cfg.minY = config[1];
                cfg.maxX = config[2];
                cfg.maxY = config[3];
            } else if (isSet(config) && Array.isArray(config.bbox)) {
                cfg.minX = config.bbox[0];
                cfg.minY = config.bbox[1];
                cfg.maxX = config.bbox[2];
                cfg.maxY = config.bbox[3];
            }
            if (!isAnySet(cfg.zoomFactor, cfg.bbox, cfg.x, cfg.scaleDenominator)) {
                var mapState = getMapState(config),
                    onMapRangeChanged = function(eventName, eventArgs) {
                        fire(F_SUCCESS, callback, { mapStateId: eventArgs.mapStateId });
                        getPortalObj(P_EVENT).unregister("mapRangeChanged", onMapRangeChanged, null);
                    };
                getPortalObj(P_EVENT).register("mapRangeChanged", onMapRangeChanged, null);
                getPortalObj(P_EVENT).notify("zoomRect", { mapStateId: mapState.get_id() }, null);
            }
            this.transform(cfg, callback, errback);
        },

        /**
        * Returns information about the map
        * @method info
        * @param {Object} [config]
        * @param {String} [config.mapStateId] map state id
        * @param {Function} [callback] Callback function
        * @param {Number[]} callback.bbox Bounding box of the map range in [minx, miny, maxx, maxy] order
        * @param {Number} callback.center Center of the map
        * @param {Number} callback.center.x Easting coordinate of the map central point expressed in current CRS
        * @param {Number} callback.center.y Northing coordinate of the map central point expressed in current CRS
        * @param {Number} callback.scaleDenominator Scale denominator
        * @param {Number} callback.crs Current CRS
        * @return {Object} return Returning object. Deprecated. Consider using callback instead.
        * @return {Number[]} return.bbox Bounding box of the map range in [minx, miny, maxx, maxy] order
        * @return {Number} return.center Center of the map
        * @return {Number} return.center.x Easting coordinate of the map central point expressed in current CRS
        * @return {Number} return.center.y Northing coordinate of the map central point expressed in current CRS
        * @return {Number} return.scaleDenominator Scale denominator
        * @return {Number} return.crs Current CRS
        */
        //TODO: verify coordinates order
        info: function (config, callback) {
            config = config || {};
            var mapState = getMapState(config),
                mc = mapState.get_mapControl(),
                mr = mapState.get_mapRange(),
                bl = mr.getBottomLeft(),
                ur = mr.getUpperRight(),
                ce = mr.getCenter(),
                bbox = [bl.x, bl.y, ur.x, ur.y];

            var ret = {
                bbox: bbox,
                center: { x: ce.x, y: ce.y },
                scaleDenominator: mc.get_scaleDenominator(),
                crs: gp.crs.getCurrent()
            };
            fire(F_SUCCESS, callback, ret);
            return ret;
        },

        /**
        * Invokes feature info operation. It works in 3 basic modes:
        *
        * 1) Geographic point is provided through the user input
        *     $GP.map.featureInfo();
        * If point (x and y or screenX and screenY properties)
        * is not provided, then map control
        * switches to feature info mode - mouse cursor is changed to cross
        * and map control is waiting for the coordinates provided by the user
        * click
        *
        * 2) Geographic point is provided programmatically
        *     $GP.map.featureInfo({x: 21, y: 51});
        *     $GP.map.featureInfo({screenX: 300, screenY: 400});
        *
        * 3) Feature ID is provided programmatically
        *     $GP.map.featureInfo({
        *         featureId: "USA2_STATES.22",
        *         legendItemDefinitionId: "{http://www.intergraph.com/geomedia/gml}USA2_STATES",
        *         url: "http://adt3/WFST_SP1/service.svc/get"
        *     });
        *
        * It is possible to provide a custom callback for the feature info operation
        * invoked with this method - that custom callback may be invoked either
        * parallelly to the default Portal's feature info handler:
        *
        *     $GP.map.featureInfo({x: 0, y: 0}, function (result) {
        *         $GP.ui.info("Feature info request completed!");
        *     });
        *
        * or it can replace it (that happens when config.preventDefaults
        * property is set):
        *
        *     $GP.map.featureInfo({
        *         preventDefaults: true,
        *     }, function finish(response) {
        *         $GP.ui.info($GP.utils.serialize(response.results));
        *     });
        *
        * @method featureInfo
        * @param {Object} [config] configuration properties
        * @param {Number} [config.x] X value in the current CRS
        * @param {Number} [config.y] Y value in the current CRS
        * @param {Number} [config.screenX] X value in the screen coordinates
        * (number pixels in the horizontal axis counted from the top left corner)
        * @param {Number} [config.screenX] Y value in the screen coordinates
        * (number pixels in the vertical axis counted from the top left corner)
        * @param {String} [config.featureId] Feature ID - legendItemDefinitionId and
        * either url of mapServiceId must be provided too to operate in that mode
        * @param {String} [config.legendItemDefinitionId] Legend Item Definition ID - featureId and
        * either url of mapServiceId must be provided too to operate in that mode
        * @param {String} [config.mapServiceId] Map Service Id
        * @param {String} [config.url] Map Service URL
        * @param {Boolean} [config.queryAllLayers] indicates wether feature info should query all possible layers
        * ("displayInfoForAllLayers" should be turned on in web.config)
        * @param {Boolean} [config.queryAllVectorLayer] indicates if feature info should query all vector layers
        * ("displayInfoForAllLayers" should be turned on in web.config)
        * @param {Boolean} [config.preventDefaults] Prevent default feature info handler
        * @param {String} [config.mapStateId] map state id
        * @param {Function} [callback] callback invoked on feature info request. It
        * is possible to locally overwrite default behavior of feature info control
        * using callback and config.preventDefaults
        * @param {Function} [errback] callback executed if operation fails
            * @return {void}
        */
        //TODO: handle beforerequest, afterrequest, requestcompleted
        //TODO: handle transformquery, transformargs
        featureInfo: function(config, callback, errback) {
            config = config || {};
            var mapState = getMapState(config),
                mc = mapState.get_mapControl(),
                screenX = config.screenX,
                screenY = config.screenY,
                defaultCallback,
                me = this,
                ficscope = getPortalObj(GP_INTERNAL).featureInfoController;
            // if screen coords are not passed, try to compute them using CRS coords
            if ((typeof screenX === T_UNDEFINED || typeof screenY === T_UNDEFINED) &&
                (typeof config.x !== T_UNDEFINED && typeof config.y !== T_UNDEFINED)) {
                var c = getXYinScreenResolution(config);
                screenX = c.x;
                screenY = c.y;
            }
            // prevent invoking default feature info behavior
            // WARNING: we are touching private portal guts here
            if (config.preventDefaults) {
                var handlers = getPortalObj(P_EVENT)._events.showFeatureInfo;
                for (var i = 0, l = handlers.length; i < l; i++) {
                    if (handlers[i].scope && handlers[i].scope === ficscope) {
                        defaultCallback = handlers[i];
                        getPortalObj(P_EVENT).unregister(E_SHOW_FEATUREINFO, handlers[i].handler, handlers[i].scope);
                        break;
                    }
                }
                getPortalObj(GP_INTERNAL).featureInfoHelper.preventDefaults = true;
            }
            var handler = createFeatureInfoHandler({
                handler: function(result) {
                    var failed;

                    try {
                        if (result.error)
                            failed = true;
                        else fire(F_SUCCESS, callback, {
								success: true,
								result: result
							});
                    } catch (e) {
                        failed = true;
                    }

                    if (failed) {
                        fire(F_FAILURE, errback, {
                            success: false,
                            result: result
                        });
                    }

                    getPortalObj(P_EVENT).unregister(E_FEATUREINFO_ALL_FINISHED, handler, me);
                    getPortalObj(P_EVENT).unregister(E_SHOW_FEATUREINFO, handler, me);
                    if (defaultCallback)
                        getPortalObj(P_EVENT).register(E_SHOW_FEATUREINFO, defaultCallback.handler, defaultCallback.scope);
                }
            });
            var multiLayersHandler = function(event, result) {
                var failed;
                try {
                    if (result.error)
                        failed = true;
                    else
                        fire(F_SUCCESS, callback, {
                            success: true,
                            result: result
                        });
                } catch (e) {
                    failed = true;
                }

                if (failed) {
                    fire(F_FAILURE, errback, {
                        success: false,
                        result: result
                    });
                }
                getPortalObj(P_EVENT).unregister(E_FEATUREINFO_ALL_FINISHED, multiLayersHandler, me);
            };

            if (config.queryAllLayers || config.queryAllVectorLayers) {
                getPortalObj(P_EVENT).register(E_FEATUREINFO_ALL_FINISHED, multiLayersHandler, me);
            } else {
                getPortalObj(P_EVENT).register(E_SHOW_FEATUREINFO, handler, me);
            }
            if (config.queryAllVectorLayers)
                getPortalObj(GP_INTERNAL).featureInfoHelper.onlyVectorLayers = true;

            if (config.featureId && config.legendItemDefinitionId && (config.mapServiceId || config.url)) {
                var ms = gp.services.find({ url: config.url, mapServiceId: config.mapServiceId })[0],
                    lid = ms && ms._.ms.findLegendItemDefinition(config.legendItemDefinitionId);
                if (!lid) {
                    fire(F_FAILURE, errback, {
                        success: false,
                        msg: "Legend item definition not found"
                    });
                } else {
                    getPortalObj(P_EVENT).notify(E_SHOW_FEATUREINFO, {
                        x: screenX,
                        y: screenY,
                        featureId: config.featureId,
                        legendItemDefinition: lid
                    }, me);
                }
            } else if (typeof screenX !== T_UNDEFINED && typeof screenY !== T_UNDEFINED) {
                // programatically invoke feature info with the given coordinates
                if (config.queryAllLayers || config.queryAllVectorLayers) {
                    getPortalObj(GP_INTERNAL).featureInfoHelper.notifyFeatureInfoForAllLayers({
                        screenX: screenX,
                        screenY: screenY,
                        onlyVectorLayers: config.queryAllVectorLayers
                    });
                } else {
                    mc.featureInfo({
                        x: screenX,
                        y: screenY
                    });
                }
            } else {
                // set map control to waiting for the user click in feature info context
                getPortalObj(P_EVENT).notify("featureInfo", {
                    mapStateId: mapState.get_id()
                }, me);
            }
        },

        /**
        * Reloads all the layers
        * @method refresh
        * @param {Object} config
        * @param {String} [config.mapStateId] map state id
        * @param {Function} callback callback executed after all layers are rendered
        * @param {Object} callback.result Result object
        * @param {Boolean} callback.result.success Always "true"
        * @param {Number} callback.result.numberOfRendered Shows the number of rendered layers.
        * @param {Function} errback error callback

        */
        refresh: function (config, callback, errback) {
            var ev = getPortalObj(P_EVENT),
                mapState = getMapState(config),
                numOfLayers = mapState.get_mapControl().get_mapLayers().length,
                numOfRendered = 0,
                scope = this;
            function count(eventName, eventArgs/*, sender*/) {
                if (eventArgs.mapStateId !== mapState.get_id())
                    return;
                numOfRendered++;
                if (numOfRendered === numOfLayers) {
                    ev.unregister(E_MAPLAYER_RENDERED, count, scope);
                    fire(F_SUCCESS, callback, { success: true, numberOfRendered: numOfRendered });
                }
            }
            try {
                ev.register(E_MAPLAYER_RENDERED, count, scope);
                mapState.get_mapControl()._resetLayers();
            } catch (e) {
                ev.unregister(E_MAPLAYER_RENDERED, count, scope);
                fire(F_FAILURE, errback, { success: false });
            }
        }
    };
    /**
    * Centers the map
    * @param {Object} config
    * @param {Number} config.x
    * @param {Number} config.y
    * @param {Function} callback
    * @param {Object} callback.result Result object
    * @param {Boolean} callback.result.success Always "true"
    * @param {Function} errback
    * @param {Object} errback.result Result object
    * @param {Boolean} errback.result.success Always "false"
    * @param {String} errback.result.message Message what is wrong.
    * @method center
    * See {@link $GP.map#transform}
    */
    gp.map.center = gp.map.transform;

    /**
    * #Drawing, Redlining#
    * $GP.map.draw is a container for specific drawing functions. But it
    * is also a "shortcut" method that tries to guess how to dispatch the
    * passed parameters and serves as a convenient general access point
    * for drawing operations.
    *
    * Please note that Redlining and Drawing is supported only on the 2D
    * map control.
    *
    * ##Point##
    * Draw a point using GeoJSON API:
    *
    *     $GP.map.draw({
    *         "type": "Point",
    *         "coordinates": [49, 69],
    *         "crsId": "EPSG:4326",
    *         "rotation": 0
    *     }, function (r) {
    *         console.log(r.feature.get_geoJSON());
    *     });
    *
    * Invoke drawing a point:
    *
    *     $GP.map.draw({"type": "Point"},
    *         function (r) {
    *             console.log(r.feature.get_geoJSON());
    *     });
    * or
    *
    *     $GP.map.draw.point();
    *
    * ##MultiPolygon
    * The following example draws multipolygon using
    * the GeoJSON API and then centers the map:
    *
    *     $GP.map.draw({
    *         "type": "MultiPolygon",
    *         "coordinates": [
    *             [
    *                 [
    *                     [102.0, 2.0],
    *                     [103.0, 2.0],
    *                     [103.0, 3.0],
    *                     [102.0, 3.0],
    *                     [102.0, 2.0]
    *                 ]
    *             ],
    *             [
    *                 [
    *                     [100.0, 0.0],
    *                     [101.0, 0.0],
    *                     [101.0, 1.0],
    *                     [100.0, 1.0],
    *                     [100.0, 0.0]
    *                 ],
    *                 [
    *                     [100.2, 0.2],
    *                     [100.8, 0.2],
    *                     [100.8, 0.8],
    *                     [100.2, 0.8],
    *                     [100.2, 0.2]
    *                 ]
    *             ]
    *         ]
    *     },
    *     function (result) {
    *         $GP.map.zoom({
    *             x: 102,
    *             y: 2
    *         });
    *         console.log(result);
    *         console.log($GP.utils.serialize(result.features[0].get_geoJSON()))
    *     });
    *
    * ##GeometryCollection
    *
    *     $GP.map.draw({
    *         "type": "GeometryCollection",
    *         "geometries": [{
    *             "type": "Point",
    *             "coordinates": [100.0, 0.0]
    *         }, {
    *             "type": "LineString",
    *             "coordinates": [
    *                 [101.0, 0.0],
    *                 [102.0, 1.0]
    *             ]
    *         }]
    *     },
    *     function (result) {
    *         $GP.map.zoom({
    *             x: 102,
    *             y: 2
    *         });
    *         console.log(result);
    *         console.log($GP.utils.serialize(result.features[0].get_geoJSON()))
    *     });
    *
    * ##Style
    * You can use one of the styles provided by portal:
    *
    *     $GP.map.draw({
    *         "type": "Feature",
    *         "geometry": {
    *             "type": "Polygon",
    *             "coordinates": [
    *                 [
    *                     [100.0, 0.0],
    *                     [101.0, 0.0],
    *                     [101.0, 1.0],
    *                     [100.0, 1.0],
    *                     [100.0, 0.0]
    *                 ]
    *             ]
    *         },
    *         style: "highlight"
    *     })
    *
    * or try to roll your own, for example by copying it from the GPW:
    *
    *     $GP.map.draw({
    *         "type": "Feature",
    *         "geometry": {
    *             "type": "Polygon",
    *             "coordinates": [
    *                 [
    *                     [100.0, 0.0],
    *                     [101.0, 0.0],
    *                     [101.0, 1.0],
    *                     [100.0, 1.0],
    *                     [100.0, 0.0]
    *                 ]
    *             ]
    *         },
    *         style: {
    *             "bold": false,
    *             "color": null,
    *             "horizontalAlignment": 0,
    *             "imageHeight": 0,
    *             "imageUrl": null,
    *             "imageWidth": 0,
    *             "italic": false,
    *             "name": "Compound style",
    *             "rotation": 0,
    *             "rule": null,
    *             "size": 0,
    *             "styleCollectionType": 0,
    *             "styles": [{
    *                 "bold": false,
    *                 "color": null,
    *                 "horizontalAlignment": 0,
    *                 "imageHeight": 0,
    *                 "imageUrl": null,
    *                 "imageWidth": 0,
    *                 "italic": false,
    *                 "name": "Area styles",
    *                 "rotation": 0,
    *                 "rule": null,
    *                 "size": 0,
    *                 "styleCollectionType": 4,
    *                 "styles": [{
    *                     "bold": false,
    *                     "color": null,
    *                     "horizontalAlignment": 0,
    *                     "imageHeight": 0,
    *                     "imageUrl": null,
    *                     "imageWidth": 0,
    *                     "italic": false,
    *                     "name": "Area style",
    *                     "rotation": 0,
    *                     "rule": null,
    *                     "size": 0,
    *                     "styleCollectionType": 0,
    *                     "styles": [{
    *                         "bold": false,
    *                         "color": null,
    *                         "horizontalAlignment": 0,
    *                         "imageHeight": 0,
    *                         "imageUrl": null,
    *                         "imageWidth": 0,
    *                         "italic": false,
    *                         "name": "Boundary styles",
    *                         "rotation": 0,
    *                         "rule": null,
    *                         "size": 0,
    *                         "styleCollectionType": 2,
    *                         "styles": [{
    *                             "bold": false,
    *                             "color": "#FF9900",
    *                             "horizontalAlignment": 0,
    *                             "imageHeight": 0,
    *                             "imageUrl": null,
    *                             "imageWidth": 0,
    *                             "italic": false,
    *                             "name": "Simple line style",
    *                             "rotation": 0,
    *                             "rule": null,
    *                             "size": 0,
    *                             "styleCollectionType": 0,
    *                             "styles": [],
    *                             "subtype": 0,
    *                             "translucency": 0.4,
    *                             "type": 2,
    *                             "underline": false,
    *                             "verticalAlignment": 0,
    *                             "visible": true,
    *                             "width": 4
    *                         }],
    *                         "subtype": 0,
    *                         "translucency": 0,
    *                         "type": 0,
    *                         "underline": false,
    *                         "verticalAlignment": 0,
    *                         "visible": false,
    *                         "width": 0
    *                     }, {
    *                         "bold": false,
    *                         "color": null,
    *                         "horizontalAlignment": 0,
    *                         "imageHeight": 0,
    *                         "imageUrl": null,
    *                         "imageWidth": 0,
    *                         "italic": false,
    *                         "name": "Fill styles",
    *                         "rotation": 0,
    *                         "rule": null,
    *                         "size": 0,
    *                         "styleCollectionType": 3,
    *                         "styles": [{
    *                             "bold": false,
    *                             "color": "#99CC00",
    *                             "horizontalAlignment": 0,
    *                             "imageHeight": 1,
    *                             "imageUrl": null,
    *                             "imageWidth": 1,
    *                             "italic": false,
    *                             "name": "Simple fill style",
    *                             "rotation": 0,
    *                             "rule": null,
    *                             "size": 0,
    *                             "styleCollectionType": 0,
    *                             "styles": [],
    *                             "subtype": 0,
    *                             "translucency": 0.33,
    *                             "type": 3,
    *                             "underline": false,
    *                             "verticalAlignment": 0,
    *                             "visible": true,
    *                             "width": 0
    *                         }],
    *                         "subtype": 0,
    *                         "translucency": 0,
    *                         "type": 0,
    *                         "underline": false,
    *                         "verticalAlignment": 0,
    *                         "visible": false,
    *                         "width": 0
    *                     }],
    *                     "subtype": 0,
    *                     "translucency": 0,
    *                     "type": 4,
    *                     "underline": false,
    *                     "verticalAlignment": 0,
    *                     "visible": false,
    *                     "width": 0
    *                 }],
    *                 "subtype": 0,
    *                 "translucency": 0,
    *                 "type": 0,
    *                 "underline": false,
    *                 "verticalAlignment": 0,
    *                 "visible": false,
    *                 "width": 0
    *             }, {
    *                 "bold": false,
    *                 "color": null,
    *                 "horizontalAlignment": 0,
    *                 "imageHeight": 0,
    *                 "imageUrl": null,
    *                 "imageWidth": 0,
    *                 "italic": false,
    *                 "name": "Linear styles",
    *                 "rotation": 0,
    *                 "rule": null,
    *                 "size": 0,
    *                 "styleCollectionType": 2,
    *                 "styles": [{
    *                     "bold": false,
    *                     "color": "#000000",
    *                     "horizontalAlignment": 0,
    *                     "imageHeight": 0,
    *                     "imageUrl": null,
    *                     "imageWidth": 0,
    *                     "italic": false,
    *                     "name": "Simple line style",
    *                     "rotation": 0,
    *                     "rule": null,
    *                     "size": 0,
    *                     "styleCollectionType": 0,
    *                     "styles": [],
    *                     "subtype": 0,
    *                     "translucency": 0,
    *                     "type": 2,
    *                     "underline": false,
    *                     "verticalAlignment": 0,
    *                     "visible": true,
    *                     "width": 1
    *                 }],
    *                 "subtype": 0,
    *                 "translucency": 0,
    *                 "type": 0,
    *                 "underline": false,
    *                 "verticalAlignment": 0,
    *                 "visible": false,
    *                 "width": 0
    *             }, {
    *                 "bold": false,
    *                 "color": null,
    *                 "horizontalAlignment": 0,
    *                 "imageHeight": 0,
    *                 "imageUrl": null,
    *                 "imageWidth": 0,
    *                 "italic": false,
    *                 "name": "Point styles",
    *                 "rotation": 0,
    *                 "rule": null,
    *                 "size": 0,
    *                 "styleCollectionType": 1,
    *                 "styles": [{
    *                     "bold": false,
    *                     "color": "#000000",
    *                     "horizontalAlignment": 0,
    *                     "imageHeight": 1,
    *                     "imageUrl": null,
    *                     "imageWidth": 1,
    *                     "italic": false,
    *                     "name": "Simple point style",
    *                     "rotation": 0,
    *                     "rule": null,
    *                     "size": 3,
    *                     "styleCollectionType": 0,
    *                     "styles": [],
    *                     "subtype": 0,
    *                     "translucency": 0,
    *                     "type": 1,
    *                     "underline": false,
    *                     "verticalAlignment": 0,
    *                     "visible": true,
    *                     "width": 0
    *                 }],
    *                 "subtype": 0,
    *                 "translucency": 0,
    *                 "type": 0,
    *                 "underline": false,
    *                 "verticalAlignment": 0,
    *                 "visible": false,
    *                 "width": 0
    *             }, {
    *                 "bold": false,
    *                 "color": null,
    *                 "horizontalAlignment": 0,
    *                 "imageHeight": 0,
    *                 "imageUrl": null,
    *                 "imageWidth": 0,
    *                 "italic": false,
    *                 "name": "Text styles",
    *                 "rotation": 0,
    *                 "rule": null,
    *                 "size": 0,
    *                 "styleCollectionType": 6,
    *                 "styles": [{
    *                     "bold": false,
    *                     "color": "#000000",
    *                     "horizontalAlignment": 1,
    *                     "imageHeight": 0,
    *                     "imageUrl": null,
    *                     "imageWidth": 0,
    *                     "italic": false,
    *                     "name": "Text style",
    *                     "rotation": 0,
    *                     "rule": null,
    *                     "size": 10,
    *                     "styleCollectionType": 0,
    *                     "styles": [],
    *                     "subtype": 0,
    *                     "translucency": 0,
    *                     "type": 6,
    *                     "underline": false,
    *                     "verticalAlignment": 1,
    *                     "visible": true,
    *                     "width": 0
    *                 }],
    *                 "subtype": 0,
    *                 "translucency": 0,
    *                 "type": 0,
    *                 "underline": false,
    *                 "verticalAlignment": 0,
    *                 "visible": false,
    *                 "width": 0
    *             }],
    *             "subtype": 0,
    *             "translucency": 0,
    *             "type": 5,
    *             "underline": false,
    *             "verticalAlignment": 0,
    *             "visible": false,
    *             "width": 0
    *         }
    *     })
    *
    * ##Circles##
    *     $GP.map.draw.circle();
    *
    * Please mind that circles are not included in GeoJSON specification and
    * feature.get_geoJSON() for that particular case is not a standard GeoJSON.
    * ##Arcs##
    *     $GP.map.draw.arc();
    *
    * Please mind that circles are not included in GeoJSON specification and
    * feature.get_geoJSON() for that particular case is not a standard GeoJSON.
    * ##Rectangles##
    *     $GP.map.draw.rectangle();
    *
    * ##Hacking##
    * Disk. The following example takes advantage of the custom extension that
    * Geospatial Portal uses with GeoJSON that enables handling circular
    * and arc geometries. It draws a disk with the center in point [19, 51]
    * and its bounding circle touching point [14, 53]. Fourth coordinate is
    * used to mark whether point is a starting point of an arc and fifth is
    * used to mark whether point is center of the circle/disk. Please mind that it is not
    * standard GeoJSON!
    *
    *     $GP.map.draw({
    *         "type": "Feature",
    *         "geometry": {
    *             "type": "Polygon",
    *             "coordinates": [
    *                 [
    *                     [19, 51, 0, 0, 1],
    *                     [14, 53],
    *                     [19, 51, 0, 0, 1]
    *                 ]
    *             ],
    *             "crsId": "EPSG:4326"
    *         },
    *         "properties": {}
    *     });
    *
    * Please take care that in this particular case the way that circular
    * geometries are handled in GeoJSON may change in the future, especially
    * if this topic is taken into the scope of GeoJSON specification. Now it
    * is out of the scope.
    *
    * @class $GP.map.draw
    * @singleton
    */
    // TODO: Decide on default layer name
    // TODO: think about method queue chaining because of user input mode
    gp.map.draw = function(config, callback, errback) {
        /**
        * Default layer name
        * @property {String} defaultLayerName
        */
        this.defaultLayerName = "Bubek";
        if (!config.coordinates && config.type === "Point")
            return gp.map.draw.point.call(gp.map.draw, config, callback, errback);
        else if (!config.coordinates && config.type === "LineString")
            return gp.map.draw.path.call(gp.map.draw, config, callback, errback);
        else if (!config.coordinates && config.type === "Polygon")
            return gp.map.draw.polygon.call(gp.map.draw, config, callback, errback);
        else if (config.type)
            return gp.map.draw.geojson.call(gp.map.draw, config, callback, errback);
        return this;
    };

    gp.map.draw._perform = function(action, config) {
        var r = getPortalObj(P_REDLINING),
            mapState = getMapState(config),
            mapControl = mapState.get_mapControl(),
            layerName = config.layerName || this.defaultLayerName,
            showMeasure = config.showMeasure || false,
            layer = r.getNamedRedliningLayer(layerName, mapControl, showMeasure);
        action.call(this, r, layer);
    };

    gp.map.draw._afterPerform = function(config, callback) {
        return function(result) {
            var portalFeature = result,
                portalFeatures,
                ret = { success: true },
                isArray = Array.isArray(portalFeature);
            portalFeatures = !isArray ? [portalFeature] : portalFeature;
            ret.features = portalFeatures.map(function(pf) {
                return new Feature({
                    portalFeature: pf,
                    mapStateId: config.mapStateId
                });
            });
            if (!isArray)
                ret.feature = ret.features[0];
            fire(F_SUCCESS, callback, ret);
        };
    };

    /**
    * Draws GeoJSON objects on the map. Handles geometry types, Feature and FeatureCollection.
    * See [GeoJSON](http://www.geojson.org/geojson-spec.html) for information concerning GeoJSON
    * @method geojson
    * @param {Object} config GeoJSON object to be drawn
    * @param {Object/String} [config.style] style name or stub
    * @param {Object/String} [config.defaultStyleName] style name
    * @param {Function} [callback] callback executed if operation succeeds
    * @param {Array} callback.array
    * @param {Function} [errback] callback executed if operation fails
    */
    gp.map.draw.geojson = function(config, callback, errback) {
        config = config || {};
        config.defaultStyleName = config.defaultStyleName || "redlining";
        var style = getPortalStyle(config);
        if (config.type === "FeatureCollection") {
            this._perform(function(redlining, layer) {
                redlining.drawFeatureClassStub(layer, this._afterPerform(config, callback, errback), this, style, getPortalObj(P_GEOJSON).read(config));
            }, config, callback, errback);
        }
        else {
            this._perform(function(redlining, layer) {
                redlining.drawFeatureStub(layer, this._afterPerform(config, callback, errback), this, style, getPortalObj(P_GEOJSON).readFeatureStub(config));
            }, config, callback, errback);
        }
        return this;
    };

    /**
    * Draw points. If coordinates (x && y || points) are not provided, method enters redlining mode
    * @method point
    * @param {Object} config Configuration options
    * @param {Number} [config.x] X coordinate
    * @param {Number} [config.y] Y coordinate
    * @param {Array} [config.points] Points
    * @param {String} [config.layerName] name of the layer
    * @param {Number} [config.showMeasure] show measure
    * @param {String} [config.mapStateId] map state id
    * @param {Object/String} [config.style] style name or stub
    * @param {Object/String} [config.defaultStyleName] style name
    * @param {Function} [callback] callback executed if operation succeeds
    * @param {Object} callback.result Result object
    * @param {Boolean} callback.result.success Always "true"
    * @param {Array} callback.result.features Array containing created features.
    * @param {Feature} callback.result.feature 
    * @param {Function} [errback] callback executed if operation fails
    * @param {Object} errback.result Result object
    */
    // TODO: validate parameters
    // TODO: clarify callbacks
    // TODO: swapped coordinates
    gp.map.draw.point = function(config, callback, errback) {
        config = config || {};
        config.defaultStyleName = config.defaultStyleName || "redlining";
        var point = (config.x && config.y) ? { x: config.x, y: config.y } : undefined,
            points = config.points || [point],
            style = getPortalStyle(config),
            operator = function(pointe) {
                return function(redlining, layer) {
                    redlining.drawPoint(layer, this._afterPerform(config, callback, errback), this, style, pointe);
                };
            };
        for (var i = 0, l = points.length; i < l; i++)
            this._perform(operator(points[i]), config, callback, errback);
        return this;
    };

    /**
    * Draws a line chain. If coordinates are not provided, method enters redlining mode
    * @method path
    * @param {Object} config Configuration options
    * @param {Array} [config.points] Points
    * @param {String} [config.layerName] name of the layer
    * @param {Number} [config.showMeasure] show measure
    * @param {String} [config.mapStateId] map state id
    * @param {Object/String} [config.style] style name or stub
    * @param {Object/String} [config.defaultStyleName] style name
    * @param {Function} [callback] callback executed if operation succeeds
    * @param {Function} [errback] callback executed if operation fails
    */
    gp.map.draw.path = function(config, callback, errback) {
        config = config || {};
        config.defaultStyleName = config.defaultStyleName || "redlining";
        var t = this,
            style = getPortalStyle(config);
        t._perform(function(redlining, layer) {
            redlining.drawPolyline(layer, t._afterPerform(config, callback, errback), t, style, config.points, config.geometryType);
        }, config, callback, errback);
        return t;
    };

    /**
    * Draw a polygon. If coordinates (points) are not provided, method enters redlining mode
    * @method polygon
    * @param {Object} config Configuration options
    * @param {Array} [config.points] Points
    * @param {String} [config.layerName] name of the layer
    * @param {Number} [config.showMeasure] show measure
    * @param {String} [config.mapStateId] map state id
    * @param {Object/String} [config.style] style name or stub
    * @param {Object/String} [config.defaultStyleName] style name
    * @param {Function} [callback] callback executed if operation succeeds
    * @param {Function} [errback] callback executed if operation fails
    */
    // TODO: handle bounding geometry
    gp.map.draw.polygon = function(config, callback, errback) {
        config = config || {};
        config.defaultStyleName = config.defaultStyleName || "redlining";
        var bounds,
            style = getPortalStyle(config);
        this._perform(function(redlining, layer) {
            redlining.drawPolygon(layer, this._afterPerform(config, callback, errback), this, style, config.points, config.geometryType, bounds);
        }, config, callback, errback);
        return this;
    };

    /**
    * Draw rectangle
    * @method rectangle
    * @param {Object} config Configuration options
    * @param {Array} [config.points] Points
    * @param {String} [config.layerName] name of the layer
    * @param {Number} [config.showMeasure] show measure
    * @param {String} [config.mapStateId] map state id
    * @param {Object/String} [config.style] style name or stub
    * @param {Object/String} [config.defaultStyleName] style name
    * @param {Function} [callback] callback executed if operation succeeds
    * @param {Function} [errback] callback executed if operation fails
    */
    gp.map.draw.rectangle = function(config, callback, errback) {
        return this.polygon(apply({}, config, {geometryType: 2}), callback, errback);
    };

    /**
    * Draw circle
    * @method circle
    * @param {Object} config Configuration options
    * @param {Array} [config.points] Points
    * @param {String} [config.layerName] name of the layer
    * @param {Number} [config.showMeasure] show measure
    * @param {String} [config.mapStateId] map state id
    * @param {Object/String} [config.style] style name or stub
    * @param {Object/String} [config.defaultStyleName] style name
    * @param {Function} [callback] callback executed if operation succeeds
    * @param {Function} [errback] callback executed if operation fails
    */
    gp.map.draw.circle = function(config, callback, errback) {
        return this.polygon(apply({}, config, {geometryType: 10}), callback, errback);
    };

    /**
    * Draw arc
    * @method arc
    * @param {Object} config Configuration options
    * @param {Array} [config.points] Points
    * @param {String} [config.layerName] name of the layer
    * @param {Number} [config.showMeasure] show measure
    * @param {String} [config.mapStateId] map state id
    * @param {Object/String} [config.style] style name or stub
    * @param {Object/String} [config.defaultStyleName] style name
    * @param {Function} [callback] callback executed if operation succeeds
    * @param {Function} [errback] callback executed if operation fails
    */
    gp.map.draw.arc = function (config, callback, errback) {
        return this.polygon(apply({}, config, { geometryType: 9 }), callback, errback);
    };

    /**
    * Clears drawing layer
    * @method clear
    */
    gp.map.draw.clear = function(config, callback) {
        config = config || {};
        var r = getPortalObj(P_REDLINING),
            mapState = getMapState(config),
            mapControl = mapState.get_mapControl(),
            layerName = config.layerName || this.defaultLayerName,
            showMeasure = config.showMeasure || false,
            layer = r.getNamedRedliningLayer(layerName, mapControl, showMeasure);
        r.eraseFeatures(layer);
        fire(F_SUCCESS, callback, { success: true });
    };

    /**
    * Sets visibility of the drawing layer
    * @method setVisibility
    * @param {Object} config
    * @param {Boolean} config.visibility Visiblity of the redlining layer
    * @param {Function} callback
    */
    gp.map.draw.setVisibility = function(config, callback) {
        config = config || {};
        var r = getPortalObj(P_REDLINING),
            mapState = getMapState(config),
            mapControl = mapState.get_mapControl(),
            layerName = config.layerName || this.defaultLayerName,
            showMeasure = config.showMeasure || false,
            layer = r.getNamedRedliningLayer(layerName, mapControl, showMeasure);
        layer.set_visibility(!!config.visibility);
        fire(F_SUCCESS, callback, { success: true });
    };

    function getPoint(g) {
        var b = g.get_bounds(),
            x = b._bottomLeft_X + (b._upperRight_X - b._bottomLeft_X) / 2,
            y = b._bottomLeft_Y + (b._upperRight_Y - b._bottomLeft_Y) / 2;
        return new (getPortalObj(P_POINT))(x, y);
    }

    /**
    * Pin wrapper. Objects of this class shouldn't be manually crated
    * @param {Object} config Configuration
    * @param {Object} config.pinLayer pin layer reference
    * @param {Object} config.featureClass feature class
    * @param {Object} config.geojson GeoJSON
    * @param {String} config.mapStateId mapStateId
    * @class Pin
    */
    function Pin(config) {
        this._ = {
            c: config
        };

        var fc = config.featureClass,
            gj = config.geojson,
            fs = getPortalObj(P_GEOJSON).readFeatureStub(gj),
            actions = config.actions || [],
            g = fs.attributes.filter(function(a) { return a.Key === fs.geometryFieldsNames[0]; })[0];
        if (isSet(g) && !getPortalObj(P_POINT).isInstanceOfType(g.Value)) {
            g.Value = getPoint(g.Value);
        }
        if (!isSet(g)) {
            return;
        }
        this._.portalFeature = fc.importFeature(fs);
        // TODO: this is because of MyvrMapControl dependendy...
        this._.portalFeature.jsonRef = gj.properties  || {};
        this.over = new EventListener({ eventName: "pinOver" });
        this.out = new EventListener({ eventName: "pinOut" });
        this.clicked = new EventListener({ eventName: "pinClicked" });
        /* jshint forin: false */
        for (var actionName in actions) {
            if (!hasOwnProperty.call(actions, actionName)) continue;
            this[actionName].register(this._getHandler(actionName));
        }
    }

    Pin.prototype = {
        _getHandler: function (actionName) {
            var t = this,
                c = t._.c;
            return function (eventName, eventArgs) {
                if (!eventArgs || eventArgs.feature !== t._.portalFeature)
                    return;
                c.actions[actionName].call(t, eventArgs.DOMElement);
            };
        },

        /**
        * Removes this pin from the map and its feature from the feature class
        * @method remove
        * @return void
        */
        remove: function () {
            this.over.suppress();
            this.out.suppress();
            this.clicked.suppress();
            var t = this,
                c = t._.c,
                fcid = c.featureClass.get_id(),
                features = c.pinLayer._featureClassCollection[fcid].get_features() || {};
            for (var fid in features)
                if (hasOwnProperty.call(features, fid) && features[fid] === t._.portalFeature) {
                    delete features[fid];
                    break;
                }
            c.pinLayer.refresh(fcid);
        },

        /**
        * Centers the map on the object
        * @method zoom
        * @param {Object} config
        * @param {Function} callback
        * @return void
        */
        zoom: function(config, callback) {
            var g = this._.portalFeature.get_geometry(),
                cfg = apply({}, config, {x: g.x, y: g.y});
            gp.map.zoom(cfg, callback);
        },

        /**
        * Returns Feature object
        * @method getFeature
        * @return {@link Feature} feature object
        */
        getFeature: function() {
            return new Feature({ portalFeature: this._.portalFeature });
        }
    };

    /**
    * #Pins
    * Pins can be added to the map by passing GeoJSON data including FeatureCollections,
    * Features and all geometry types. When geometry is not a point, then point is taken
    * from the crossing of diagonals of the bounding geometry.
    *
    * Pins can have custom actions on mouseover ("over"), mouseout ("out") and mouseclick
    * ("clicked") events. Actions may be common for all feature collection or different
    * for every pin. These actions are expected to be functions that take HTML element
    * as their parameter and have "this" bound to the Pin object, for example:
    *
    *     function (element) {
    *         element.className = "wc_map_layer_red_pin";
    *         alert(this.getFeature().get_geoJSON().properties.name);
    *     }
    *
    * It is possible to modify default CSS class name when adding pins to the map by using
    * className parameter.
    *
    * Please note that support for pins in the 3D map control is limited. Neither changing
    * class names nor assigning actions on "over" and "out" are supported.
    *
    * ##Adding pins:
    * ###[Simple point]
    *
    *     $GP.map.pin.add({
    *         geojson: {
    *             "type": "Point",
    *             "coordinates": [-5, 51.5]
    *         }
    *     });
    *
    *
    * ###[Feature with attributes]
    *
    *     $GP.map.pin.add({
    *         geojson: {
    *             "type": "Feature",
    *             "geometry": {
    *                 "type": "Point",
    *                 "coordinates": [0, 51.5]
    *             },
    *             "properties": {
    *                 "name": "London"
    *             }
    *         }
    *     });
    *
    * ###[Feature Collection]
    *
    *     $GP.map.pin.add({
    *         geojson: {
    *             "type": "FeatureCollection",
    *             "features": [{
    *                 "type": "Feature",
    *                 "geometry": {
    *                     "type": "Point",
    *                     "coordinates": [13.5, 52.5]
    *                 },
    *                 "properties": {
    *                     "name": "Berlin"
    *                 }
    *             }, {
    *                 "type": "Feature",
    *                 "geometry": {
    *                     "type": "Point",
    *                     "coordinates": [19.5, 51.75]
    *                 },
    *                 "properties": {
    *                     "name": "Lodz"
    *                 }
    *             }, {
    *                 "type": "Feature",
    *                 "geometry": {
    *                     "type": "Point",
    *                     "coordinates": [24, 57]
    *                 },
    *                 "properties": {
    *                     "name": "Riga"
    *                 }
    *             }]
    *         },
    *         actions: {
    *             clicked: function () {
    *             },
    *             over: function (element) {
    *                 element.className = "wc_map_layer_red_pin";
    *             },
    *             out: function (element) {
    *                 element.className = "wc_map_layer_pin";
    *             }
    *         }
    *     });
    *
    * ##[Removing pins]
    *
    *     $GP.map.pin.clear({});
    *
    * @class $GP.map.pin
    * @singleton
    */
    gp.map.pin = {
        /**
        * Default properties
        */
        defaults: {
            featureClassName: "pins",
            featureClassId: "pins",
            geometryFieldName: "geometry",
            className: "wc_map_layer_pin"
        },

        _ensureFeatureClass: function(config, mapControlName) {
            config = apply({}, config, this.defaults);
            this._featureClasses = this._featureClasses || {};
            this._featureClasses[mapControlName] = this._featureClasses[mapControlName] || {};
            this._featureDatasets = this._featureDatasets || {};
            this._featureDatasets[mapControlName] = this._featureDatasets[mapControlName] || new (getPortalObj(P_FEATURE_DATASET))();

            var fcid = config.featureClassId,
                fd = this._featureDatasets[mapControlName],
                fc = this._featureClasses[mapControlName][fcid] = this._featureClasses[mapControlName][fcid] || fd.createFeatureClass({
                    id: fcid,
                    name: config.featureClassName,
                    geometryFieldName: config.geometryFieldName,
                    fields: [{
                        name: config.geometryFieldName,
                        geometryType: 1 //Intergraph.WebSolutions.Core.WebClient.Platform.Common.GeometryType.Point
                    }]
                });
            return fc;
        },

        _ensurePinLayer: function(config) {
            // Pin layers are separate for each map control
            var mapState = getMapState(config),
                mapControl = mapState.get_mapControl(),
                mapControlName = mapControl.get_definitionName(),
                pinLayer;
            if (!this._pinLayers)
                this._pinLayers = {};
            var featureClass = this._ensureFeatureClass(config, mapControlName);
            pinLayer = this._pinLayers[mapControlName];
            if (!pinLayer){
                pinLayer = this._pinLayers[mapControlName] = mapControl.getCommonPinLayer();
            }
            pinLayer.addFeatureClass(featureClass);
            pinLayer.set_visibility(true);
            return pinLayer;
        },

        /**
        * Adding pins to the map
        * Handles GeoJSON data including FeatureCollections, Features and all geometry types. When geometry
        * is not a point, then point is taken from the crossing of diagonals of the bounding geometry.
        * @method add
        * @param {Object} config Configuration options. Either geojson or x and y or points must be provided
        * @param {GeoJSON} [config.geojson] GeoJSON data
        * @param {Object} [config.actions] Events on the pin
        * @param {Function} [config.actions.over] What happens on the "pin mouse over"
        * @param {Function} [config.actions.out] What happens on the "pin mouse out"
        * @param {Function} [config.actions.clicked] What happens on the "pin mouse clicked"
        * @param {String} [config.className] CSS class name of the pins
        * @param {Number} [config.x] X coordinate
        * @param {Number} [config.y] Y coordinate
        * @param {String} [config.featureClassId] Feature Class ID
        * @param {String} [config.featureClassName] Feature Class Name
        * @param {String} [config.geometryFieldName] Geometry Field Name
        */
        // TODO: current Portal has an issue with mouse events on pins
        add: function(config, callback) {
            config = apply({}, config, this.defaults);
            var mapState = getMapState(config),
                mapControl = mapState.get_mapControl(),
                mapControlName = mapControl.get_definitionName(),
                layer = this._ensurePinLayer(config),
                fc = this._featureClasses[mapControlName][config.featureClassId],
                geojson = config.geojson,
                actions = config.actions,
                className = config.className;
            if (!geojson && typeof config.x === T_NUMBER && typeof config.y === T_NUMBER)
                geojson = {type: "Point", coordinates: [config.x, config.y]};
            if (geojson.type === "FeatureCollection") {
                var features = geojson.features || [], lastIndex = features.length - 1;
                for (var i = 0, l = features.length; i < l; i++) {
                    var cfg = apply({}, config);
                    cfg.geojson = features[i];
                    cfg.skipfire = true;
                    if (i === lastIndex) {
                        cfg.skipfire = false;
                        cfg._collection = true;
                    }
                    gp.map.pin.add(cfg, callback);
                }
                return;
            }
            var pin = new Pin({
                featureClass: fc,
                geojson: geojson,
                actions: actions,
                mapStateId: config.mapStateId,
                pinLayer: this._pinLayer
            });
            if (!config.skipfire) {
                layer._pinCls = className;
                layer.refresh(config.featureClassId);
                fire(F_SUCCESS, callback, {
                    success: true,
                    pin: pin
                });
            }
        },

        /**
        * Removing all pins
        * @method clear
        * @param {Object} [config] Configuration options
        * @param {String} [config.featureClassId] Feature Class ID
        */
        clear: function(config, callback) {
            config = apply({}, config || {}, this.defaults);
            var mapState = getMapState(config),
                mapControl = mapState.get_mapControl(),
                mapControlName = mapControl.get_definitionName(),
                fid = config.featureClassId,
                layer = this._ensurePinLayer(config),
                fc = this._featureClasses[mapControlName][fid];
            if (isSet(fid) && layer.removeFeatureClass) {
                layer.removeFeatureClass(fid);
            } else if (layer.removeAllFeatureClasses) {
                layer.removeAllFeatureClasses();
            }
            fc.clearFeatures();
            layer.refresh(fid);
            fire(F_SUCCESS, callback, {
                success: true
            });
        },

        /**
        * Sets visibility of the pin layer
        * @method setVisibility
        * @param {Object} config Configuration options
        * @param {Boolean} config.visibility Visibility
        */
        setVisibility: function(config, callback) {
            config = apply({}, config || {}, this.defaults);
            var layer = this._ensurePinLayer(config);
            layer.set_visibility(config.visibility);
            fire(F_SUCCESS, callback, {
                success: true
            });
        }
    };

    /**
    * Manages coordinate reference system
    * @class $GP.crs
    * @singleton
    */
    // TODO: add helpers to gp.mapControl
    gp.crs = {
        _find: function (predicate, data) {
            var ret = [];
            if (Array.isArray(data))
                for (var i = 0, l = data.length; i < l; i++)
                    ret = ret.concat(this._find(predicate, data[i]));
            else if (Array.isArray(data.children))
                ret = ret.concat(this._find(predicate, data.children));
            else if (data && data.children === null)
                if (predicate(data))
                    ret.push(data);
            return ret;
        },

        _findAll: function (predicate, callback) {
            var that = this;
            var request = getPortalObj(P_WEB_REQUEST).create({
                name: "CrsTree",
                query: {
                    action: "getTree"
                },
                includeCRS: false,
                callback: function (result) {
                    //TODO: check executor etc
                    //TODO: handle errors
                    var obj = result.get_object();
                    var ret = that._find(predicate, obj);
                    fire(F_SUCCESS, callback, {
                        success: true,
                        crs: ret
                    });
                },
                scope: this
            });
            request.invoke();
        },

        /**
        * Finds CRS
        * @method find
        * @param {String/RegExp/Object} config
        * @param {String} [config.value]
        * @param {String} [config.regex]
        * @param {Function} [config.predicate]
        * @param {Function} callback
        */
        find: function (config, callback) {
            var code, regex, predicate;
            if (typeof config === T_STRING)
                code = config;
            else if (typeof config === T_FUNCTION)
                predicate = config;
            else if (config instanceof RegExp)
                regex = config;
            else if (config.code)
                code = config.code;
            else if (config.regex)
                regex = config.regex;
            else if (config.predicate)
                predicate = config.predicate;
            if (regex)
                predicate = function (o) {
                    return o.value.match(regex) || o.text.match(regex);
                };
            else if (code)
                predicate = function (o) {
                    return o.value === code;
                };
            if (!predicate)
                predicate = alwaysTrue;
            this._findAll(predicate, callback);
        },

        /**
        * Sets current map CRS
        * @method setCurrent
        * @param {Function} [config] Config
        * @param {Function} [callback] callback executed if operation succeeds
        * @param {Object} callback.result Result object
        * @param {Boolean} callback.result.success Always "true"
        * @param {String/Number} callback.result.crsId Name of coordinate system which has been set.
        * @param {Function} [errback] callback executed if operation fails
        * @param {Object} errback.result Result object
        * @param {Boolean} errback.result.success Always "false"
        * @param {String} errback.result.crsId Name of wrong crs
        */
        setCurrent: function (config, callback, errback) {
            // TODO: pass other options (only sane options...)
            // TODO: this is sloopy
            var mapStates = getPortalObj(P_MAPSTATE_MANAGER).get_mapStates();
            var corrections = {};
            for (var mapStateId in mapStates)
                if (hasOwnProperty.call(mapStates, mapStateId))
                    corrections[mapStateId] = true;
            var options = { correctOnlyHeightAspectRatio: corrections };
            var code;
            if (typeof config === T_STRING)
                code = config;
            else if (config)
                code = config.code;
            if (code === this.getCurrent())
                fire(F_SUCCESS, callback, { success: true, crsId: code });
            if (!code)
                fire(F_FAILURE, errback, { success: false, crsId: code});
            getPortalObj(P_CRS).setCurrent(code, options, function (crsChanged) {
                if (crsChanged) {
                    getPortalObj(P_EVENT).notify(E_CANCEL_MAP_OPERATION, {}, this);
                    getPortalObj(P_EVENT).notify(E_CRS_CHANGED, null, this);
                    fire(F_SUCCESS, callback, { success: true, crsId: code });
                } else {
                    fire(F_FAILURE, errback, { success: false, crsId: code});
                }
            }, this);
        },

        /**
        * Returns current CRS
        * @method getCurrent
        * @return {String}
        */
        getCurrent: function () {
            return getPortalObj(P_CRS).getCurrent().get_id();
        },

        /**
        * Adds CRS to the map
        * @method register
        * @param {Object/String} config Configuration options
        * @param {String} [config.code] EPSG code
        * @param {String} [config.regex] Regex for matching EPSG codes and names
        * @param {Function} [config.predicate] Function for manually finding matching CRS
        * @param {Function} [callback] Callback fired after CRS has been registered or in case of failure
        * @return
        */
        register: function (config, callback) {
            var that = this, code;
            if (typeof config === T_STRING)
                code = config;
            else if (config && config.code)
                code = config.code;
            if (code && code in this.getRegistered()) {
                fire(F_SUCCESS, callback, { success: true, msg: "Already registered", crsIds: [code] });
                return;
            }
            this.find(config, function (result) {
                if (!result.success)
                    return;
                var ids = [];
                var crs = result.crs || [];
                for (var i = 0, l = crs.length; i < l; i++) {
                    that._register(crs[i]);
                    ids.push(crs[i].value);
                }
                fire(F_SUCCESS, callback, { success: true, crsIds: ids });
            });
        },

        _register: function (obj) {
            var axes = obj.axisPrimary === "east" ? [2, 1] : [1, 2];
            var crsStub = {
                id: obj.value,
                isGeographic: obj.isGeographic,
                axesDirections: axes,
                projAttributes: obj.attributes,
                unit: obj.unit,
                unitValue: obj.unitValue
            };

            getPortalObj(P_CRS).registerCRS(crsStub);
            updateFitAllRanges(obj);
        },

        /**
        * Returns registered CRS
        * @method getRegistered
        * @return {String[]}
        */
        getRegistered: function () {
            var ret = [], d = getPortalObj(P_CRS)._crsDict;
            for (var pName in d)
                if (hasOwnProperty.call(d, pName))
                    ret.push(pName);
            return ret;
        },

        /**
        * Transform coordinates
        * @method transform
        * @param {Object} config Configuration
        * @param {String} [config.sourceCrsId] Source CRS identifier. If not provided, current map CRS identifier will be used
        * @param {String} [config.targetCrsId] Destination CRS identifier. If not provided, current map CRS identifier will be used
        * @param {Array} config.points
        * @param {Function} [callback] callback executed if operation succeeds
        * @param {Object} callback.result Result object
        * @param {Boolean} callback.result.success Always "true" 
        * @param {Function} [errback] callback executed if operation fails
        * @param {Object} errback.result Result object
        * @param {Boolean} errback.result.success Always "false"
        * @param {String} errback.result.msg Reason of error, in example: "Points for transformation are not provided"
        * @return
        */
        transform: function (config, callback, errback) {
            config = config || {};
            var crsm = getPortalObj(P_CRS),
                sourceCrsId = crsm.getReprCode(config.sourceCrsId || this.getCurrent()),
                targetCrsId = crsm.getReprCode(config.targetCrsId),
                points = config.points,
                scope = this,
                msg,
                options = {};
            if (!points)
                msg = "Points for transformation are not provided";
            if (msg)
                fire(F_FAILURE, errback, { success: false, msg: msg});
            else
                crsm.transformPoints(sourceCrsId, targetCrsId, points, options, function (transformedPoints) {
                    if (transformedPoints)
                        fire(F_SUCCESS, callback, { success: true, points: transformedPoints });
                    else
                        fire(F_FAILURE, errback, { success: false, points: null, msg: "transformation failed" });
                }, scope);
            return scope;
        },

        /** Returns true if crs codes represent the same or equivalent CRS
        * @method equal
        * @param {String} crsCode1 first CRS code
        * @param {String} ctsCode2 second CRS code
        * @return {Boolean}
        */
        equal: function(crsCode1, crsCode2) {
            var crsm = getPortalObj(P_CRS),
                repr1 = crsm.getReprCode(crsCode1),
                repr2 = crsm.getReprCode(crsCode2);
            return repr1 === repr2;
        }
    };

    /**
    * #User Interface
    * @class $GP.ui
    * @singleton
    */
    gp.ui = {

        infoDefaults: {
            overflow: true,
            showCounter: true,
            timeout: 10000,
            showTitle: true,
            type: "info"
        },

        /**
        * Displays UI message in portal
        * @method info
        * @param {Object/String} config1 configuration options or message
        * @param {Object} [config2] params used when config1 is {String}
        * @param {String} [config1.message] Message
        * @param {String} [config1.type] Type - "info", "warning", "error"
        * @param {Boolean} [config1.overflow] overflow
        * @param {Boolean} [config1.showTitle] show title
        * @param {Boolean} [config1.showCounter] show counter
        * @param {Boolean} [config1.title] title
        * @param {Boolean} [config1.timeout] timeout
        * @param {String} [config2.type] Type - "info", "warning", "error"
        * @param {Boolean} [config2.overflow] overflow
        * @param {Boolean} [config2.showTitle] show title
        * @param {Boolean} [config2.showCounter] show counter
        * @param {Boolean} [config2.title] title
        * @param {Boolean} [config2.timeout] timeout
        * @return {void}
        */
        info: function (config1, config2) {
            var justTitle = typeof config1 === T_STRING,
                cfg = apply({}, justTitle ? config2 : config1, this.infoDefaults),
                u = getPortalObj(P_UTIL),
                type = cfg.type || "info",
                methodName = "show" + type.charAt(0).toUpperCase() + type.slice(1),
                message = justTitle ? config1 : cfg.message;
            u[methodName](message, cfg);
        },

        /**
        * Internal web browser
        * @class $GP.ui.browser
        * @singleton
        */
        browser: {
            /**
            * Returns handle to Ext object
            * @method get_handle
            * @return {Object} Ext handle
            */
            get_handle: function () {
                return getComponent(/WebBrowser1$/).get_extComponent();
            },

            /**
            * Opens internal web browser with tab
            * @method show
            * @param {Object} config configuration
            * @param {String} config.title tab title
            * @param {String} [config.link] URL. One of link/url and html must be provided
            * @param {String} [config.url] URL. One of link/url and html must be provided
            * @param {String} [config.html] Raw HTML to display. One of link/url and html must be provided
            * @param {Boolean} [config.showAddressBar]
            * @param {Function} [callback] Function executed after the browser is shown
            **/
            show: function (config, callback) {
                var me = this, handle = me.get_handle();

                function cb () {
                    fire(F_SUCCESS, callback, [handle, config]);
                    handle.un(E_SHOW, cb, me);
                }

                handle.on(E_SHOW, cb, me);
                getPortalObj(P_EVENT).notify(E_SHOW_WEBBROWSER, config, me);
            },

            /**
            * Hides internal web browser
            * @method show
            * @param {Object} config configuration
            * @param {String} [config.title] tab title. If not present whole browser will get hidden
            * @param {Function} [callback] Function executed after the browser hides itself
            **/
            hide: function (config, callback) {
                config = config || {};
                var me = this, handle = me.get_handle();

                function cb () {
                    fire(F_SUCCESS, callback, [handle, config]);
                    handle.un(E_HIDE, cb, me);
                }

                handle.on(E_HIDE, cb, me);
                getPortalObj(P_EVENT).notify(E_HIDE_WEBBROWSER, config, me);
            }
        },

         /**
        * SearchResultPanel
        * @class $GP.ui.searchResultPanel
        * @singleton
        */
        searchResultPanel: {

            /**
            * Returns handle to Ext object
            * @method get_handle
            * @return {Object} Ext handle
            */
            get_handle: function () {
                return getComponent(/_SearchResultPanel1$/);
            },

            /**
            * Displays catalog search results using searchResultPanel.
            *
            * Typical usage:
            *     $GP.ui.searchResultPanel.displayResult({
            *         searchType: "apollo",
            *         keywords: "Cherokee"
            *     });
            *
            * @method displayResult
            * @param {Object} params Search query
            */
            displayResult: function (params) {
                var apollo = getPortalObj(P_APOLLO);
                this.get_handle().displaySearch(params, apollo.getApolloFieldDefinitions());
            }
        },

        /**
        * Sidebar
        * @class $GP.ui.sidebar
        * @singleton
        */
        sidebar: {

            /**
            * Returns handle to Ext object
            * @method get_handle
            * @return {Object} Ext handle
            */
            get_handle: function () {
                var c = getComponent(/_InnerSidebar$/) || getComponent(/_Sidebar$/);
                return c && c.get_extComponent();
            },

            /**
            * Adds items to the sidebar.
            *
            * Typical usage:
            *     $GP.ui.sidebar.add({
            *         xtype: "panel",
            *         layout: "fit",
            *         title: "New Sidebar Panel",
            *         items: {
            *             xtype: "label",
            *             text: "Hello World"
            *         }
            *     });
            *
            * @method add
            * @param {Object} config Ext Panel
            */
            add: function (config) {
                this.get_handle().add(config);
                this.get_handle().doLayout();
            }
        },

        /**
        * Toolbar
        * @class $GP.ui.toolbar
        * @singleton
        */
        toolbar: {
            /**
            * Returns handle to Ext object
            * @method get_handle
            * @return {Object} Ext handle
            */
            // Provides reference to the toolbar object
            get_handle: function () {
                return getToolbar().get_extComponent();
            },

            /**
            * Adds items to the toolbar.
            *
            * Typical usage:
            *     $GP.ui.toolbar.add({
            *         categoryIndex: 0,
            *         xtype: "tbbutton",
            *         text: "Hello World!",
            *         handler: function (b) {
            *             Ext.Msg.alert("Title", "Hello World!");
            *         }
            *     });
            *
            * @method add
            * @param {Object} config Ext item
            * @param {Number} config.categoryIndex which tab
            */
            add: function (config) {
                var categoryIndex = config.categoryIndex || 0;
                var firstItem = this.get_handle().items.items[0],
                    tt = firstItem.items ? firstItem.items.items[categoryIndex].topToolbar : firstItem.topToolbar,
                    t = this;
                if (Array.isArray(tt))
                    tt.push(config);
                else
                    tt.add(config);
                return t;
            }
        },

        /**
        * DataView. DataWindow or docked DataPanel
        * @class $GP.ui.dataView
        * @singleton
        */
        dataView: {
            /**
            * Provides internal reference to the datawindow control
            * @method get_handle
            * @param {Object} config Configuration parameters
            * @param {String} [config.dataWindowId] Data Window Id if it is other than default "DataWindow"
            * @return {Object} Reference to ExtJS control object
            */
            get_handle: function(config) {
                config = config || {};
                return getDataWindow(config.dataWindowId);
            },

            /**
            * Shows data view control. Also opens new tab with feature class
            * @method show
            * @param {Object} config Configuration parameters
            * @param {String} config.mapServiceId service ID
            * @param {String} config.featureClassId feature class ID
            * @param {String} [config.dataWindowId] Data Window Id if it is other than default "DataWindow"
            * @param {Object} [config.options] reserved
            * @return {void}
            */
            show: function(config) {
                var handle = this.get_handle(config);
                if (!handle) return;
                handle.set_hidden(false);
                config = config || {};
                var mapServiceId = config.mapServiceId,
                    featureClassId = config.featureClassId,
                    service = getPortalObj(P_MAPSERVICE_MANAGER).findMapService(mapServiceId),
                    lid = service.findLegendItemDefinition(featureClassId),
                    options = config.options;
                handle.selectAndAdd([lid], options);
            },

            /**
            * Hides data view control
            * @method hide
            * @param {Object} config Configuration parameters
            * @param {String} [config.dataWindowId] Data Window Id if it is other than default "DataWindow"
            * @return {void}
            */
            hide: function(config) {
                var handle = this.get_handle(config);
                if (!handle) return;
                handle.set_hidden(true);
            },

            _getPluginContainer: function () {
                if (!this._pluginContainer) {
                    this._pluginContainerName = "__apiDataViewPlugins";
                    Type.registerNamespace(this._pluginContainerName);
                    /*jshint -W054 */
                    this._pluginContainer = new Function("return " + this._pluginContainerName)();
                }
                return this._pluginContainer;
            },

            // Hijack getRowActionButtons methods created outside API in order to be able to hide default tools
            // This method is necessary because there is another way of adding row action buttons with .NET API
            // 0 - BaseTools
            // 1 - MapTools (no row actions)
            _ensurePluginsHijacked: function () {
                var dm = getPortalObj(P_DATAVIEW_MANAGER),
                    actionsFilter = this._actionsFilter,
                    actionsFilterScope = this,
                    overwrite = function (plugin) {
                        var orig = plugin.getRowActionButtons;
                        if (!orig) return;
                        // add a filter to the collection so that particular tools
                        // coming from other plugins can be hidden
                        plugin.getRowActionButtons = function(properties, scope) {
                            var ret = orig.call(this, properties, scope);
                            return ret.filter(actionsFilter, actionsFilterScope);
                        };
                    };
                // TODO: refactor to use public setter after changes in Portal Core
                if (!this.__hijackFlag) {
                    for (var i = 0, l = dm._plugins.length; i < l; i++) {
                        // if plugin has _actionsFilter property, it has been created with API
                        // and doesn't need to be overridden
                        if (dm._plugins[i]._actionsFilter) continue;
                        overwrite(dm._plugins[i]);
                    }
                    this.__hijackFlag = true;
                }
            },

            /**
            * Registers new row action
            * @method registerRowAction
            * @param {Object[]|Object} config Configuration options. If config is an Array, it is possible to add multiple
            * row actions in a single call just by passing an array of objects described as config below.
            * @param {String} config.id id of the action. By default this id would expect css class with
            * the same name (icon definition) but it is possible to use inline style
            * @param {String} config.text tooltip
            * @param {String} config.style CSS style of the tool icon. For example "background: url(http://example.net/my/image.png);"
            * @param {Function} config.predicate if the predicate returns false action is not accessible
            * @param {Object} config.predicate.properties Bunch of properties
            * @param {String} config.predicate.properties.mapServiceId Service ID
            * @param {Boolean} config.predicate.properties.clipboard Clipboard present
            * @param {Boolean} config.predicate.properties.fromClipboard action performed on clipboard
            * @param {Boolean} config.predicate.properties.canDelete data source can delete
            * @param {Function} config.handler Action handler
            * @param {Object} config.handler.context Data context
            * @param {String} config.handler.context.featureId FeatureID
            * @param {String} config.handler.context.mapServiceId Service ID
            * @param {String} config.handler.context.featureClassId FeatureClass ID
            * @param {String} config.handler.context.id Analysis ID or feature class ID (if not analysis)
            * @param {Object} config.handler.context.data Feature attributes
            * @param {Boolean} config.handler.context.clipboard Clipboard present
            * @param {Boolean} config.handler.context.fromClipboard action performed on clipboard
            * @param {Boolean} config.handler.context.canDelete data source can delete
            * @param {Object} config.handler.event Click event
            * @param {Function} callback Success callback
            * @param {Function} callback Failure callback
            * @return {void}
            */
            registerRowAction: function (descriptors, callback, errback) {
                if (!Array.isArray(descriptors))
                    descriptors = [descriptors];
                this._rowActions = this._rowActions || {};
                for (var i = 0, l = descriptors.length; i < l; i++) {
                    var config = descriptors[i];
                    if (!config.id || !config.text || typeof config.handler !== T_FUNCTION)
                        return fire(F_FAILURE, errback, { success: false, message: "Missing parameters" });
                    if (this._rowActions[config.id])
                        return fire(F_FAILURE, errback, {
                            success: false,
                            message: "Row action with id" + config.id + " is already registered"
                        });
                }
                // create internal plugin in the plugin container
                var container = this._getPluginContainer(),
                    cname = "P" + gp.utils.newGuid().replace(/-/g, ""),
                    qname = [container.getName(), cname].join("."),
                    scope = this;
                container[cname] = function() {};
                container[cname].prototype = new RowActionPlugin(descriptors, this._actionsFilter, this);
                container[cname].registerClass(qname, null, getPortalObj(P_DATAVIEW_IPLUGIN));
                getPortalObj(P_DATAVIEW_MANAGER).registerPlugins([qname]);
                descriptors.forEach(function (d) {
                    this._rowActions[d.id] = cname;
                }, scope);
                return fire(F_SUCCESS, callback, { success: true, _classid: qname });
            },

            /**
            * This method allows to hide row action tools by ID including default tools:
            * - "wc_data_view_properties_link"
            * - "wc_data_view_clipboard_link"
            * - "wc_data_view_fit_link"
            * - "wc_data_view_remove_from_clipboard_link"
            * - "wc_data_view_remove_from_database_link"
            * @method hideRowActions
            * @param {String[]|String} ids IDs of the tools to be hidden
            * @return {void}
            */
            hideRowActions: function (ids, callback, errback) {
                this._processRowActions(ids, callback, errback, true);
            },

            /**
            * Show previously hidden row actions by ID
            * @method unhideRowActions
            * @param {String[]|String} ids IDs of the tools to be shown
            * @return {void}
            */
            unhideRowActions: function (ids, callback, errback) {
                this._processRowActions(ids, callback, errback, false);
            },

            _processRowActions: function(ids, callback, errback, flag) {
                if (!Array.isArray(ids))
                    ids = [ids];
                this._deletedRowActions = this._deletedRowActions || {};
                this._ensurePluginsHijacked();
                for (var i = 0, l = ids.length; i < l; i++) {
                    if (typeof ids[i] !== T_STRING) {
                        fire(F_FAILURE, errback, { message: "Invalid argument: ids" });
                        return;
                    }
                    this._deletedRowActions[ids[i]] = flag;
                }
                fire(F_SUCCESS, callback, { ids: ids });
            },

            _actionsFilter: function (action) {
                return !this._deletedRowActions || !this._deletedRowActions[action.id];
            }
        }
    };

    /**
    * Settings
    * @class $GP.settings
    * @singleton
    */
    gp.settings = {
        /**
        * Available properties
        * @property available
        */
        available: { "showNavigator": true, "showCrosshair": true, "showScale": true, "showCoords": true },

        /**
        * Returns object with settings values
        * @return {Object}
        */
        get: function () {
            var ret = {}, settings = getPortalObj(P_SETTINGS);
            for (var pName in this.available)
                if (this.available[pName])
                    ret[pName] = settings.getValue(pName);
            return ret;
        },

        /**
        * Changes settings
        * @param {Object} config Configuration object with settings
        * @param {Boolean} [config.showNavigator] showNavigator
        * @param {Boolean} [config.showCrosshair] showCrosshair
        * @param {Boolean} [config.showScale] showScale
        * @param {Boolean} [config.showCoords] showCoords
        */
        set: function (config) {
            config = config || {};
            var i = 0, pName, settings = getPortalObj(P_SETTINGS);
            for (pName in config)
                if (this.available[pName]) {
                    settings.setValue(pName, config[pName]);
                    i++;
                }
            if (i > 0)
                getPortalObj(P_EVENT).notify(E_SETTINGS_CHANGED, {}, gp.settings);
        }
    };

    /**
    * #Queries.
    *
    * $GP.queries is a container for executing queries in Geospatial Portal.
    *
    * ##Add WFS query with simple filter
    *
    *     var queryName = "States";
    *
    *     $GP.queries.add({
    *         featureClassId: "{http://www.intergraph.com/geomedia/gml}OM_USA_STATES",
    *         url: "http://demo.hexagongeospatial.com/GWM_WFS_NonTransactional/service.svc/get",
    *         definitionName: "WFS",
    *         queryName: queryName,
    *         addToLegend: true,
    *         filters: [{
    *             operator: "OR",
    *             operands: [{
    *                 operator: "=",
    *                 operands: ["{http://www.intergraph.com/geomedia/gml}STATE_NAME", "Oklahoma"]
    *             }, {
    *                 operator: "=",
    *                 operands: ["{http://www.intergraph.com/geomedia/gml}STATE_NAME", "Arkansas"]
    *             }, {
    *                 operator: "=",
    *                 operands: ["{http://www.intergraph.com/geomedia/gml}STATE_NAME", "Alabama"]
    *             }]
    *         }]
    *     });
    *
    * ##Spatial filter can be easily added to a query.
    * Geometries passed in spatial filter operands have to be formatted in geoJSON.
    *
    *     var queryName = "Query with spatial filter.";
    *
    *     $GP.queries.add({
    *         featureClassId: "{http://www.intergraph.com/geomedia/gml}OM_USA_STATES",
    *         url: "http://demo.hexagongeospatial.com/GWM_WFS_NonTransactional/service.svc/get",
    *         definitionName: "WFS",
    *         queryName: queryName,
    *         addToLegend: true,
    *         filters: [{
    *             type: "spatial",
    *             operator: "Intersects",
    *             complement: false,
    *             operands: [{
    *                 "type": "Polygon",
    *                 "coordinates": [
    *                     [
    *                         [-112, 40],
    *                         [-86, 46],
    *                         [-80, 27],
    *                         [-105, 27],
    *                         [-112, 40]
    *                     ]
    *                 ],
    *                 "crsId": "EPSG:4326"
    *             }]
    *         }]
    *     });
    *
    * ##Query can consist of spatial and atrribute filter.
    *
    *     var queryName = "States";
    *
    *     $GP.queries.add({
    *         featureClassId: "{http://www.intergraph.com/geomedia/gml}OM_USA_STATES",
    *         url: "http://demo.hexagongeospatial.com/GWM_WFS_NonTransactional/service.svc/get",
    *         definitionName: "WFS",
    *         queryName: queryName,
    *         addToLegend: false,
    *         filters: [{
    *             operator: "OR",
    *             operands: [{
    *                 operator: "=",
    *                 operands: [
    *                     "{http://www.intergraph.com/geomedia/gml}STATE_NAME",
    *                     "Oklahoma"
    *                 ]
    *             }, {
    *                 operator: "=",
    *                 operands: [
    *                     "{http://www.intergraph.com/geomedia/gml}STATE_NAME",
    *                     "Arkansas"
    *                 ]
    *             }, {
    *                 operator: "=",
    *                 operands: [
    *                     "{http://www.intergraph.com/geomedia/gml}STATE_NAME",
    *                     "Alabama"
    *                 ]
    *             }]
    *         }, {
    *             type: "spatial",
    *             operator: "Intersects",
    *             complement: false,
    *             operands: [{
    *                 "type": "Polygon",
    *                 "coordinates": [
    *                     [
    *                         [-112, 40],
    *                         [-86, 46],
    *                         [-80, 27],
    *                         [-105, 27],
    *                         [-112, 40]
    *                     ]
    *                 ],
    *                 "crsId": "EPSG:4326"
    *             }]
    *         }]
    *     },
    *     function (result) {
    *         $GP.queries.find({
    *             analysisId: result.analysisId,
    *         }, function (result2) {
    *             result2.analysis.addToLegend({}, function () {
    *                 $GP.legend.find({
    *                     name: queryName
    *                 })[0].fitLayer();
    *             });
    *         });
    *     });
    *
    * ## Combined with drawing geometry
    * In order to allow user to draw geometry, $GP.queries and $GP.map.draw functions can be combined.
    *
    *     function createAnalysis(geometry) {
    *         var queryName = "Query with drawing";
    *         $GP.queries.add({
    *             featureClassId: "{http://www.intergraph.com/geomedia/gml}OM_USA_STATES",
    *             url: "http://demo.hexagongeospatial.com/GWM_WFS_NonTransactional/service.svc/get",
    *             definitionName: "WFS",
    *             queryName: queryName,
    *             addToLegend: true,
    *             filters: [{
    *                 type: "spatial",
    *                 operator: 'Intersects',
    *                 complement: false,
    *                 operands: [geometry]
    *
    *             }]
    *         },
    *         function (result) {
    *             $GP.queries.find({
    *                 analysisId: result.analysisId,
    *              }, function (result2) {
    *                 result2.analysis.getData(function (data) {
    *                     console.log(data);
    *                 });
    *             });
    *         }
    *     });
    *
    *
    *     $GP.map.draw({
    *         "type": "Polygon" //user will be promped to draw geometry (polygon) on map
    *     }, function (r) {
    *         createAnalysis(r.feature.get_geoJSON().geometry);
    *     });
    *
    * @class $GP.queries
    * @singleton
    */
    gp.queries = {
        /**
        * Executes a query. Query is defined by passing featureClassId and filter. It is also possible to pass a style definition.
        * If the `queryName` or `queryId` parameters are passed, then it is possible to update an existing analysis.
        * @param {Object} config Configuration options
        * @param {Boolean} [config.addToLegend=true] add query to the legend or not. It is recommended to add the analysis legend item
        * with a separate addToMap call on the {Analysis} object.
        * @param {String} [config.mapServiceId] map service id. Either mapServiceId
        * or (url and definitionName) must be provided
        * @param {String} [config.queryName] Display name of the analysis legend item. If analysis with this name already exists, it is updated. If name is not passed,
        * but the query is updated by queryId, then the original name is preserved
        * @param {String} [config.queryId] ID of the analysis legend item. If analysis with this id already exists, it is updated.
        * @param {String} [config.url] map service url
        * @param {String} [config.definitionName] map service definition name (for example "WFS")
        * @param {String} [config.featureClassId] feature class ID
        * @param {String} [config.applicationId] Application ID (GWMPS)
        * @param {String} [config.mapStateId] map state ID
        * @param {Object} [config.filter] filter
        * @param {Object} [config.style] style. If style is not passed but there is already an existing legend item for this analysis meant for update,
        * the original style is preserved
        * @param {Function} [callback] callback executed if operation succeeds
        * @param {Object} callback.result Result object
        * @param {Boolean} callback.result.success Always "true"
        * @param {String} callback.result.analysisId Id of added query
        * @param {Boolean} callback.result.updated "true"
        * @param {Function} [errback] callback executed if operation fails
        * @return {void}
        */
        add: function (config, callback, errback) {
            config = config || {};
            var addToLegend = config.addToLegend === false ? false : true,
                analysisManager = getPortalObj(P_ANALYSIS_MANAGER),
                existingAnalysis = analysisManager.findAnalysis(config.queryId) || analysisManager.findAnalysisByName(config.queryName),
                filterLength = config.filters.length;

            if (!config.mapServiceId) {
                var serviceCfg = apply({}, config, {}, function(cfg, p) {
                    return typeof cfg[p] !== T_FUNCTION;
                });
                gp.services.add(serviceCfg, function (result) {
                    var cfg = apply({}, { mapServiceId: result.msId }, config);
                    gp.queries.add(cfg, callback, errback);
                });
                return;
            }

            var mapState = getMapState(config),
                mapStateId = mapState.get_id(),
                queryId = config.queryId || gp.utils.newGuid(),
                queryName = config.queryName,
                analysisStub = {
                    firstLegendItemDefinitionId: config.featureClassId,
                    id: queryId,
                    mapServiceId: config.mapServiceId,
                    name: queryName,
                    geometry: null,
                    parametrizedQueryId: null,
                    firstWhereClause: "",
                    firstWhereAttributes: [],
                    secondBuffer: null,
                    secondLegendItemDefinitionId: null,
                    secondWhereAttributes: [],
                    secondWhereClause: "",
                    spatialOperator: null,
                    spatialOperatorNegation: false,
                    maxFeatures: config.maxFeatures
                },
                options = {
                    callback: function (result) {
                        var isSuccess = result && !result.error;
                        fire(isSuccess ? F_SUCCESS : F_FAILURE, isSuccess ? callback : errback, {
                            success: isSuccess,
                            analysisId: isSuccess ? (result.id || analysisStub.id) : "",
                            updated: result.updated
                        }, result);
                    },
                    doNotAddToLegend: !addToLegend,
                    style: config.style
                };

            if (existingAnalysis && !queryName)
                queryName = analysisStub.name = existingAnalysis.get_name();

            for (var i = 0; i < filterLength ; i++) {
                if (config.filters[i].type === "advanced") {
                    analysisStub.firstWhereClause = config.filters[0].value;
                    analysisStub.firstWhereAttributes = [];
                } else if (config.filters[i].type === "spatial") {
                    var spatialFilter = config.filters[i] || {};
                    analysisStub.spatialOperator = spatialFilter.operator;
                    analysisStub.spatialOperatorNegation = !!spatialFilter.complement;
                    analysisStub.geometry = getPortalObj(P_GEOJSON).read(config.filters[i].operands[0]);
                    if (config.filters[i].operands[0].type === "BoundingBox")
                        analysisStub.geometry.isBBox = true;
                    if (gp.services.find({mapServiceId: config.mapServiceId})[0].get_definitionName() === "WFS")
                        analysisStub.geometry.swapCoordinates();
                } else {
                    analysisStub.firstWhereAttributes = prepareWhereAttributes(config.filters[i]);
                    analysisStub.firstWhereClause = prepareQueryWhereClause(config.filters[i]);
                }
            }

            gp.legend.find({
                mapStateId: mapStateId,
                id: config.queryId,
                name: queryName
            }, function (ret) {
                if (ret.legendItems && ret.legendItems[0]) {
                    var internalLegendItem = ret.legendItems[0]._.li,
                        displayStyle = internalLegendItem.get_displayStyle();
                    options.style = analysisStub.style || displayStyle;
                }
                getPortalObj(P_ANALYSIS_MANAGER).update(mapState, analysisStub, options);
            }, function () {
                getPortalObj(P_ANALYSIS_MANAGER).update(mapState, analysisStub, options);
            });
        },

        /**
         * Finds Analysis
         *
         *   $GP.queries.find({
         *       name: /.*$/
         *   }, function(ret) {
         *       console.log(ret.analyses)
         *   }, function(err) {
         *       console.error(err)
         *   });
         * 
         * @method find
         * @param {Object} config
         * @param {String} [config.id] Analysis ID
         * @param {String} [config.analysisId] Backward compatibility alias for id. If id is passed, it is ignored
         * @param {String/RegEx} [config.name] Analysis name. it can be regex
         * @param {Function} [callback] callback executed if operation succeeds
         * @param {Object} callback.ret returning object
         * @param {Analysis[]} callback.ret.analyses Analyses collection
         * @param {Analysis} callback.ret.analysis first found Analysis (for compatibility)
         * @param {Function} [errback] callback executed if operation fails or doesn't find any analysis
         * @return {void}
         */
        find: function (config, callback, errback) {
            var analysisId = config.id || config.analysisId,
                findBy = makeFindByPredicate({
                    key: "id",
                    value: analysisId
                }, {
                    key: "name",
                    value: config.name
                }),
                predicate = config.predicate || ((isSet(analysisId) || isSet(config.name)) ? findBy : alwaysTrue),
                a = getPortalObj(P_ANALYSIS_MANAGER)._analyses,
                result = Object.keys(a).map(function (key) {
                    return {
                        id: key,
                        name: a[key].get_name()
                    };
                }).filter(predicate).map(function (obj) {
                    return new Analysis({
                        config: {
                            mapStateId: config.mapStateId,
                            analysisId: obj.id
                        },
                        portalAnalysis: a[obj.id]
                    });
                });
            if (result.length > 0) {
                fire(F_SUCCESS, callback, {
                    success: true,
                    analyses: result,
                    analysis: result[0] // compatibility
                });
            } else {
                fire(F_FAILURE, errback, {
                    success: false,
                    msg: "Analysis not found."
                });
            }
        }
    };

    /**
    * Object representing WPS Process
    */
    function Process (config) {
        this._ = {
            config: config
        };
        var cpp = config.portalApolloProcess;
        if (!cpp)
            return;
        this.id = cpp.id;
        this.title = cpp.title;
        this.abs = cpp.abs;
        this.category = cpp.category;
        this.inputs = cpp.inputs || [];
        this.outputs = cpp.outputs|| [];
    }

    Process.prototype = {
        /**
        * Executes $GP.search with appropriate parameters so as to find items that can be input data
        * to this process instance
        * @method findMatchingItem
        * @param {Object} [config] Configuration options
        * @param {Function} [callback] callback executed if operation succeeds
        * @param {Function} [errback] callback executed if operation fails
        * @param {Object} [config.input] Process input for which matching datasets should be found
        * @return {void}
        */
        findMatchingItems: function(config, callback, errback) {
            var that = this,
                apolloMapServiceId = getApolloMapServiceId(),
                message;
            if(!apolloMapServiceId) {
                fire(F_FAILURE, errback, { success: false, message: M_APOLLO_MISSING });
                return;
            }
            if(config.input.type !== "ComplexData") {
                message = "Specified input does not accept complex values";
                fire(F_FAILURE, errback, { success: false, message: message });
                return;
            }
            var cswQuery = decodeURIComponent(config.input.constraint);
            var processesSearchRequest = getPortalObj(P_WEB_REQUEST).create({
                name: "ApolloSearch",
                body: {
                    mapServiceId: apolloMapServiceId,
                    action: "search",
                    profile: "full",
                    orderBy: "name asc",
                    cswQuery: cswQuery,
                    classType: !cswQuery ? "com.erdas.rsp.babel.model.imagery.ImageReference" : null
                },
                callback: getASR(callback, errback, "results", function(ret) {
                    ret.process = that;
                    return ret;
                })
            });
            processesSearchRequest.invoke();
        },

        /**
        * Executes the process
        * @method execute
        * @param {Object} [config] Configuration options
        * @param {Function} [callback] callback executed if operation succeeds
        * @param {Function} [errback] callback executed if operation fails
        * @param {Object} [config.inputValues] Array of input values for the process inputs
        * When inputValues are specified, their number must exactly match the number of the inputs of the process.
        * @return {void}
        */
        execute: function(config, callback, errback) {
            var apolloMapServiceId = getApolloMapServiceId(),
                that = this;
            if(!apolloMapServiceId) {
                fire(F_FAILURE, errback, { success: false, message: M_APOLLO_MISSING });
                return;
            }
            if(this.inputs.length !== config.inputValues.length) {
                fire(F_FAILURE, errback, { success: false, message: M_APOLLO_ARITY });
                return;
            }
            var ac = getPortalObj(P_APOLLO_COMMON),
                processedInputs = [];
            for (var i = 0; i < this.inputs.length; i++) {
                var currentInputValue;
                if(this.inputs[i].type === "ComplexData")
                    currentInputValue = ac.prototype.prepareInputForGeoprocessing([{json: config.inputValues[i].apollo}]);
                else
                    currentInputValue = config.inputValues[i];
                processedInputs.push({
                    dataType: this.inputs[i].type === "ComplexData" ? "LiteralData" : this.inputs[i].type,
                    id: this.inputs[i].name,
                    value: currentInputValue || this.inputs[i].defaultValue,
                    valueType: this.inputs[i].type === "ComplexData" ? "complex" : null
                });
            }
            var processesExecuteRequest = getPortalObj(P_WEB_REQUEST).create({
                name: "ApolloSearch",
                body: {
                    mapServiceId: apolloMapServiceId,
                    action: "executeProcess",
                    procId: this.id,
                    inputs: gp.utils.serialize(processedInputs)
                },
                callback: handleExecutor(callback, errback, function(o) {
                    return o.statusLocation;
                }, function(ret) {
                    ret.process = that;
                    return ret;
                })
            });
            processesExecuteRequest.invoke();
        },

        /**
        * Checks status of the process
        * @method getStatus
        * @param {Object} [config] Configuration options
        * @param {Function} [callback] callback executed if operation succeeds
        * @param {Function} [errback] callback executed if operation fails
        * @param {Object} [config.statusLocation] Location of the process status
        * @return {void}
        */
        getStatus: function(config, callback, errback) {
            var apolloMapServiceId = getApolloMapServiceId();
            if(!apolloMapServiceId) {
                fire(F_FAILURE, errback, { success: false, message: M_APOLLO_MISSING });
                return;
            }
            var statusRequest = getPortalObj(P_WEB_REQUEST).create({
                name: "ApolloSearch",
                body: {
                    mapServiceId: apolloMapServiceId,
                    action: "checkProcess",
                    handles: gp.utils.serialize([config.statusLocation])
                },
                callback: handleExecutor(callback, errback, function(o) {
                    return o.processes;
                })
            });
            statusRequest.invoke();
        },

        /**
        * Get description (details) of a specific process
        * @method describe
        * @param {Function} [callback] callback executed if operation succeeds
        * @param {Function} [errback] callback executed if operation fails
        * @return {void}
        */
        describe: function(callback, errback) {
            var apolloMapServiceId = getApolloMapServiceId();
            if(!apolloMapServiceId) {
                fire(F_FAILURE, errback, { success: false, message: M_APOLLO_MISSING });
                return;
            }
            var processDescriptionRequest = getPortalObj(P_WEB_REQUEST).create({
                name: "ApolloSearch",
                body: {
                    mapServiceId: apolloMapServiceId,
                    action: "describeProcess",
                    procId: this.id
                },
                callback: getProcesses(callback, errback)
            });
            processDescriptionRequest.invoke();
        }
    };

    /**
    * #Processing
    * This is a generic API for processing. Walkthrough:
    *
    * ##[Finding a process]
    *
    *     $GP.processes.find(function (response) {
    *         $GP.ui.info("Found " + $GP.utils.serialize(response.results.length) + " processes.");
    *     });
    *
    * ##[Describing a process]
    *
    *     $GP.processes.find(function (response) {
    *         var process = response.results[3];
    *         process.describe(function (response2) {
    *             $GP.ui.info("Process info: " + $GP.utils.serialize(response2.results));
    *         });
    *     });
    *
    * ##[Finding matching items]
    *
    *     $GP.processes.find(function (response) {
    *         var process = response.results[3];
    *         process.describe(function (response2) {
    *             var process = response2.results[0];
    *             $GP.ui.info("Searching for matching items.");
    *             process.findMatchingItems({
    *                 input: process.inputs[0]
    *             }, function (response3) {
    *                 $GP.ui.info("Found " + $GP.utils.serialize(response3.results.length) + " matching items.");
    *             });
    *         });
    *     });
    *
    * ##[Executing a process and checking its status]
    *
    *     $GP.processes.find(function (response) {
    *         var process = response.results[3];
    *         process.describe(function (response2) {
    *             process = response2.results[0];
    *             $GP.ui.info("Searching for matching items.");
    *             process.findMatchingItems({
    *                 input: process.inputs[0]
    *             }, function (response3) {
    *                 var matchingItem = response3.results[0];
    *                 response3.process.execute({
    *                     inputValues: [matchingItem]
    *                 }, function (response4) {
    *                     response4.process.getStatus({
    *                         statusLocation: response4.results
    *                     }, function (response5) {
    *                         $GP.ui.info($GP.utils.serialize(response5.results[0]));
    *                     });
    *                 });
    *             });
    *         });
    *     });
    *
    * @class $GP.processes
    * @singleton
    */
    gp.processes = {
        /**
        * Finds processes available on the server.
        * @method find
        * @param {Function} [callback] callback executed if operation succeeds
        * @param {Function} [errback] callback executed if operation fails
        * @return {void}
        */
        find: function(callback, errback) {
            var apolloMapServiceId = getApolloMapServiceId();
            if(!apolloMapServiceId) {
                fire(F_FAILURE, errback, { success: false, message: M_APOLLO_MISSING });
                return;
            }
            var processesSearchRequest = getPortalObj(P_WEB_REQUEST).create({
                name: "ApolloSearch",
                body: {
                    mapServiceId: apolloMapServiceId,
                    action: "getWPSCapabilities",
                    refresh: true
                },
                callback: getProcesses(callback, errback)
            });
            processesSearchRequest.invoke();
        },

        /**
        * Get history of executed processes from Apollo server
        * @method history
        * @param {Function} [callback] callback executed if operation succeeds
        * @param {Function} [errback] callback executed if operation fails
        * @return {void}
        */
        history: function(callback, errback) {
            var apolloMapServiceId = getApolloMapServiceId();
            if(!apolloMapServiceId) {
                fire(F_FAILURE, errback, { success: false, message: M_APOLLO_MISSING });
                return;
            }
            var processHistoryRequest = getPortalObj(P_WEB_REQUEST).create({
                name: "ApolloSearch",
                body: {
                    mapServiceId: apolloMapServiceId,
                    action: "getJobs"
                },
                callback: handleExecutor(callback, errback, function(o) {
                    return o.result;
                })
            });
            processHistoryRequest.invoke();
        }
    };

    /**
    * #Exporting data
    *
    * Send ClipZipShip requests to specified email addres.
    *
    * Example:
    *
    *     var data = [
    *         [
    *             [-106.55655827565818,
    *                 31.739841421129324, -106.55655827565818,
    *                 31.736170087085917, -106.5519079192032,
    *                 31.736170087085917, -106.5519079192032,
    *                 31.739841421129324, -106.55655827565818,
    *                 31.739841421129324
    *             ]
    *         ]
    *     ];
    *     $GP.export.clipZipShip({
    *         clipZipShipRequest: {
    *             "_encodingVersion": "2.0",
    *             "numberOfRequests": 1,
    *             "_class": "com.erdas.apollo.api.provisioning.CZSRequestContainer",
    *             "token": "YWRtaW46YXBvbGxvMTIz",
    *             "wcsUrl": "http://demo-apollo.hexagongeospatial.com/erdas-apollo/coverage_public/EAIM",
    *             "ignoreWarnings": true,
    *             "cZSRequestsSet": [{
    *                 "name": "002_110_120830_1724__0_42656_32_0_0",
    *                 "_class": "com.erdas.apollo.api.provisioning.CZSRequest",
    *                 "coverageRequest": null,
    *                 "fileOptions": null,
    *                 "lasOptions": null,
    *                 "requestExceptionError": null,
    *                 "type": "RASTER",
    *                 "imageryOptions": {
    *                     "_class": "com.erdas.apollo.api.provisioning.CZSImageryOptions",
    *                     "outputFormat": "IMG",
    *                     "interpolation": "nearest neighbor",
    *                     "measure": "Pixel",
    *                     "outputSrs": "EPSG:26913",
    *                     "channelAxis": "Band",
    *                     "clipMethod": "custom-broker",
    *                     "channels": ["band1", "band2", "band3", "band4", "band5"],
    *                     "pixelResolutionX": 1622,
    *                     "pixelResolutionY": 1075.1333389135348,
    *                     "extent": {
    *                         "srs": "EPSG:4326",
    *                         "epsgId": 4326,
    *                         "type": "MULTIPOLYGON",
    *                         "cardinality": 2,
    *                         "data": data
    *                     }
    *                 }
    *             }],
    *             "globalOptions": {
    *                 "_class": "com.erdas.apollo.api.provisioning.CZSGlobalOptions",
    *                 "clipMethod": "global-broker",
    *                 "outputSrs": "EPSG:4326",
    *                 "eMail": prompt("Please type in your email address"),
    *                 "extent": {
    *                     "srs": "EPSG:4326",
    *                     "epsgId": 4326,
    *                     "type": "MULTIPOLYGON",
    *                     "cardinality": 2,
    *                     "data": data
    *                 }
    *             }
    *         }
    *     }, function callback(response) {
    *         $GP.ui.info($GP.utils.serialize(response));
    *     });
    *
    * @class $GP.export
    * @singleton
    */
    // Rhino parser in Closure Compiler treats export as a reserved keyword...
    gp["export"] = {
        /**
        * Send ClipZipShip requests to specified email addres.
        * @method clipZipShip
        * @param {Object} config Configuration options
        * @param {Function} [callback] callback executed if operation succeeds
        * @param {Function} [errback] callback executed if operation fails
        * @param {String} config.mail Target email address
        * @param {Object} config.clipZipShipRequest CZS request json
        * @return {void}
        */
        clipZipShip: function(config, callback, errback) {
            config = config || {};
            var apolloMapServiceId = getApolloMapServiceId();
            if (!apolloMapServiceId) {
                fire(F_FAILURE, errback, { success: false, message: M_APOLLO_MISSING });
                return;
            }
            var jsonData = {
                "args": [config.clipZipShipRequest]
            };

            var downloadRequest = getPortalObj(P_WEB_REQUEST).create({
                name: "ApolloSearch",
                query: {
                    mapServiceId: apolloMapServiceId,
                    action: "download"
                },
                body: {
                    jsonData: gp.utils.serialize(jsonData)
                },
                includeCRS: false,
                callback: handleExecutor(callback, errback, function(o) { return o; })
            });
            downloadRequest.invoke();
        }
    };

    function findLegendItemDefinitionsByName(mapService, name) {
        return rangerWalker({
            items: mapService.get_legendItemDefinitions(),
            predicate: function(lid) {
                return lid.get_name() === name;
            },
            childrenGetter: "get_legendItemDefinitions"
        });
    }

    function getLegendItemDefinition(lid, msid) {
        var msm = getPortalObj(P_MAPSERVICE_MANAGER);
        if (msid)
            return msm.findMapService(msid).findLegendItemDefinition(lid);
        else {
            var services = msm.get_mapServices(), o;
            /*jshint forin:false*/
            for (var msId in services) {
                if (hasOwnProperty.call(services, msId) &&
                (o = services[msId].findLegendItemDefinition(lid) ||
                    findLegendItemDefinitionsByName(services[msId], lid)[0]))
                    return o;
            }
        }
        return undefined;
    }

    /**
    * #Selected features.
    *
    * ## Adding features by providing featureId and featureClassId
    *
    *     $GP.selectedFeatures.add({
    *         featureId: "OM_USA_COUNTIES.1683",
    *         featureClassId: "{http://www.intergraph.com/geomedia/gml}OM_USA_COUNTIES"
    *     });
    *
    * ## Adding features through activating selection mode on the map
    *""
    *     $GP.selectedFeatures.add({
    *         type: "Rectangle"
    *     }, function (result) {
    *         console.log(result.featureClassIds); // array of feature class IDs affected with selection
    *         console.log(result.featureIds); // 2-dimensional array of feature IDs. Arrays are grouped by featureClassId
    *         console.log(result.features); // 2-dimensional array of features. Arrays are grouped by featureClassId
    *     });
    *
    * ## Adding feature with a callback
    *
    *     $GP.selectedFeatures.add({
    *         featureId: "OM_USA_COUNTIES.112",
    *         featureClassId: "{http://www.intergraph.com/geomedia/gml}OM_USA_COUNTIES"
    *     }, function (result) {
    *         console.log(result.success, result.featureId, result.featureClassId, result.feature.get_geoJSON());
    *     });
    *
    * ## Removing the feature
    *
    *     $GP.selectedFeatures.clear({
    *         featureId: "OM_USA_COUNTIES.112",
    *         featureClassId: "{http://www.intergraph.com/geomedia/gml}OM_USA_COUNTIES"
    *     }, function (result) {
    *         console.log(result.success, result.featureId, result.featureClassId, result.feature.get_geoJSON());
    *     });
    *
    * ## Removing all the features
    *
    * $GP.selectedFeatures.clear();
    *
    * ## Finding features in selected set
    *
    *     $GP.selectedFeatures.find({
    *         featureClassId: "{http://www.intergraph.com/geomedia/gml}OM_USA_COUNTIES"
    *     }, function (result) {
    *         console.log(result)
    *     })
    *
    * @class $GP.selectedFeatures
    * @singleton
    */
    gp.selectedFeatures = {
        /**
        * Adds features to the selected set
        * @param {Object} config
        * @param {String} [config.featureId] Feature ID
        * @param {String[]} [config.featureIds] Feature IDs
        * @param {String} [config.featureClassId] FeatureClass ID
        * @param {String} [config.mapServiceId] Service ID
        * @param {String} [config.type] Type of the user driven selection mode. Currently
        * supported types are "Point", "LineString", "Polygon" and "Rectangle"
        * @param {Number[]} [config.bbox] bounding box to limit number of downloaded features.
        * It can be used together with resulting bbox of $GP.map.info
        * @param {Function} [callback] callback executed if operation succeeds
        * @param {Function} [errback] callback executed if operation fails
        * @method add
        */
        add: function(config, callback, errback) {
            var featureId = config.featureId,
                featureIds = config.featureIds || (featureId ? [featureId] : null),
                featureClassId = config.featureClassId,
                mapServiceId = config.mapServiceId,
                legendItemDefinition = getLegendItemDefinition(featureClassId, mapServiceId);
            config.featureIds = config.featureIds || featureIds;
            if (!featureIds && !featureClassId && config.type) {
                return this._addByUser(config, callback, errback);
            }
            if (isSet(featureIds) && isSet(featureClassId)) {
                var objects = featureIds.map(function(id) {
                    return {
                        id: id,
                        selected: true
                    };
                });
                getPortalObj(P_SELECTEDFEATURES).setSelection(legendItemDefinition, objects);
                getPortalObj(P_EVENT).notify(E_SELECTEDFEATURES_CHANGED, {}, this);
                return fire(F_SUCCESS, callback, {
                    success: true,
                    featureId: featureId,
                    featureIds: featureIds,
                    featureClsasId: featureClassId, // for backwards compatibility
                    featureClassId: featureClassId,
                    features: featureIds.map(function(id) {
                        return new Feature({ featureId: id, featureClassId: featureClassId });
                    }),
                    feature: isSet(featureId) ? new Feature({ featureId: featureId, featureClassId: featureClassId }) : undefined
                });
            }
            return fire(F_FAILURE, errback, {
                success: false,
                featureClassId: featureClassId,
                featureIds: featureIds
            });
        },

        _addByUser: function (config, callback/*, errback*/) {
            var e = getPortalObj(P_EVENT),
                scope = this,
                selectionEvent = "selectByBbox";
            switch(config.type) {
            case "Point":
                selectionEvent = "selectByPoint";
                break;
            case "LineString":
                selectionEvent = "selectByLine";
                break;
            case "Polygon":
                selectionEvent = "selectByArea";
                break;
            case "Rectangle":
                selectionEvent = "selectByBbox";
                break;
            }
            function reg(eventName, eventArgs, sender) {
                gp.selectedFeatures.find({}, function (ret) {
                    fire(F_SUCCESS, callback, {
                        success: true,
                        featureIds: ret.featureIds,
                        featureClassIds: ret.featureClassIds
                    });
                });
                unreg(eventName, eventArgs, sender);
                e.unregister(E_SELECTEDFEATURES_CHANGED, reg, scope);
                scope._registeredSelectedFeaturesChanged = false;
            }
            function unreg(eventName, eventArgs) {
                if (typeof eventArgs.finishedMapOperation !== T_NUMBER)
                    return;
                e.unregister("cancelMapOperation", unreg, scope);
                //TODO: there is a risk that selectedFeaturesChanged is still registered after cancelling the selection
            }
            if (scope._registeredSelectedFeaturesChanged === true) {
                e.unregister(E_SELECTEDFEATURES_CHANGED, reg, scope);
            }
            e.register(E_SELECTEDFEATURES_CHANGED, reg, scope);
            scope._registeredSelectedFeaturesChanged = true;
            e.register("cancelMapOperation", unreg, scope);
            e.notify(selectionEvent, { mapStateId: getMapState(config).get_id() }, scope);
        },

        /**
        * Finds all features from the given FeatureClass from the selected set
        * @param {Object} config
        * @param {String} [config.featureClassId] FeatureClass ID. If not passed, all selected features from all feature classes
        * will be returned in the callback
        * @param {Number[]} [config.bbox] bounding box to limit number of downloaded features.
        * It can be used together with resulting bbox of $GP.map.info
        * @param {String} [config.mapServiceId] Service ID
        * @param {Function} [callback] callback executed if operation succeeds
        * @param {Function} [errback] callback executed if operation fails
        * @method find
        */
        find: function(config, callback, errback) {
            config = config || {};
            var featureClassId = config.featureClassId,
                allSelected = getPortalObj(P_SELECTEDFEATURES).getAllSelected(),
                allSelectedMerged = Object.keys(allSelected).reduce(function (p, currentKey) {
                    return {
                        featureIds: p.featureIds.concat(allSelected[currentKey].featureIds),
                        legendItemDefinitions: p.legendItemDefinitions.concat(allSelected[currentKey].legendItemDefinitions)
                    };
                }, {featureIds: [], legendItemDefinitions: []}),
                index;
            if (isSet(featureClassId)) {
                for (var i = 0, l = allSelectedMerged.legendItemDefinitions.length; i < l; i++) {
                    if (allSelectedMerged.legendItemDefinitions[i].get_id() === featureClassId) {
                        index = i;
                        break;
                    }
                }
                if (!isSet(index)) {
                    return fire(F_FAILURE, errback, { success: false, message: "No featureClass with that featureClassId" });
                }
            }
            var fromOneFeatureClass = isSet(featureClassId) && isSet(index),
                featureClassIds = allSelectedMerged.legendItemDefinitions.map(function(lid) { return lid.get_id(); }),
                features = allSelectedMerged.featureIds.map(function (subArray, i) {
                    return subArray.map(function(id) {
                        return new Feature({ featureId: id, featureClassId: featureClassIds[i] });
                    });
                });
            return fire(F_SUCCESS, callback, {
                success: true,
                featureIds: fromOneFeatureClass ? allSelectedMerged.featureIds[index] : allSelectedMerged.featureIds,
                featureClassIds: featureClassIds,
                featureClassId: fromOneFeatureClass ? featureClassIds[index] : undefined,
                features: fromOneFeatureClass ? features[index]: features
            });
        },

        /**
        * Removes features from the selected set. If featureId is not passed, then
        * whole selected set is cleared.
        * @param {Object} config
        * @param {String} [config.featureId] Feature ID
        * @param {String} [config.featureClassId] FeatureClass ID
        * @param {String} [config.mapServiceId] Service ID
        * @param {Function} [callback] callback executed if operation succeeds
        * @param {Function} [errback] callback executed if operation fails
        * @method clear
        */
        clear: function(config, callback, errback) {
            config = config || {};
            var featureId = config.featureId,
                featureIds = config.featureIds || (featureId ? [featureId] : null),
                lid = config.featureClassId,
                msid = config.mapServiceId,
                definition = getLegendItemDefinition(lid, msid);
            if (isSet(featureIds) && isSet(lid)) {
                var featuresToUnselect = featureIds.map(function (id) {
                    return {
                        id: id,
                        selected: false
                    };
                });
                getPortalObj(P_SELECTEDFEATURES).setSelection(definition, featuresToUnselect);
                getPortalObj(P_EVENT).notify(E_SELECTEDFEATURES_CHANGED, {}, this);

                fire(F_SUCCESS, callback, {
                    success: true,
                    featureId: featureId,
                    featureIds: featureIds,
                    featureClsasId: lid, // for backwards compatibility
                    featureClassId: lid
                });
            } else if (getPortalObj(P_SELECTEDFEATURES).clear()) {
                getPortalObj(P_EVENT).notify(E_SELECTEDFEATURES_CHANGED, {}, this);
                fire(F_SUCCESS, callback, { success: false });
            } else {
                fire(F_FAILURE, errback, { success: false });
            }
        }
    };

    function liftUserStyleCallback(mapStateId, userStyleCallback) {
        return function(internalFeature) {
            var publicFeature = new Feature({
                portalFeature: internalFeature,
                mapStateId: mapStateId
            });
            var publicStyleConfig = userStyleCallback(publicFeature);
            return getPortalStyle(publicStyleConfig);
        };
    }

    function liftCallback(mapStateId, userStyleCallback) {
        return function (internalFeature, event) {
            var publicFeature = new Feature({
                portalFeature: internalFeature,
                mapStateId: mapStateId
            });
            return userStyleCallback(publicFeature, event);
        };
    }

    /**
    * # Dynamic Styles
    * With the dynamic styles you can define styling for individual features in the
    * feature class. The idea is that you provide a function that returns the JSON
    * style definition having a feature as its parameter.
    *
    * ## Simple Point Style
    * This example defines custom style for features with ID lower than 1500 and uses the
    * default featureClass style for others.
    *
    *     $GP.dynamicStyles.register({
    *         featureClassId: "{http://www.intergraph.com/geomedia/gml}OM_USA_CITIES",
    *         default: function (feature) {
    *             if (feature.get_geoJSON().properties["{http://www.intergraph.com/geomedia/gml}ID"] &lt; 1500)
    *                 return null;
    *             return {
    *                 "style": {
    *                     "color": "#f00",
    *                     "name": "Red dot",
    *                     "size": 5,
    *                     "translucency": 0.2
    *                 },
    *                 defaultStyleName: "none",
    *                 styleType: "Intergraph.WebSolutions.Core.WebClient.Platform.Style.SimplePointStyle"
    *             }
    *         }
    *     }, function () {
    *         $GP.legend.add({
    *             url: "http://demo.hexagongeospatial.com/GWM_WFS_NonTransactional/service.svc/get",
    *             definitionName: "WFS",
    *             ids: ["{http://www.intergraph.com/geomedia/gml}OM_USA_CITIES"]
    *         })
    *     });
    *
    * @class $GP.dynamicStyles
    * @singleton
    */
    gp.dynamicStyles = {

        /**
        * Registers the dynamic style callback to be used with feature classes
        * with provided featureClassId so that individual features can have
        * separate styling.
        * Functions providing styles take feature object as a parameter and
        * need to return a valid style JSON or null. If they return null, it means
        * that feature class style will be used.
        *""
        * @param {Object} config
        * @param {String} config.featureClassId FeatureClass ID
        * @param {Function} [config.default] function providing the default style
        * @param {Function} [config.select] function providing the select style
        * @param {Function} [config.highlight] function providing the highlight style
        * @param {String} [config.mapStateId] Map State ID ("map" by default)
        * @param {Function} [callback] callback executed if operation succeeds
        * @method register
        */
        register: function (config, callback) {
            var cfg = {};
            ["default", "highlight", "select"].forEach(function (styleName) {
                if (typeof config[styleName] === T_FUNCTION)
                    cfg[styleName] = liftUserStyleCallback(getMapState(config).get_id(), config[styleName]);
            });
            getPortalObj(P_DSM).register(config.featureClassId, cfg);
            fire(F_SUCCESS, callback, { success: true });
        },

        /**
        * Unregisters the dynamic style callback
        * @param {Object} config
        * @param {String} config.featureClassId FeatureClass ID
        * @param {String} [config.mapStateId] Map State ID ("map" by default)
        * @param {Function} [callback] callback executed if operation succeeds
        * @method unregister
        */
        unregister: function (config, callback) {
            getPortalObj(P_DSM).unregister(config.featureClassId);
            fire(F_SUCCESS, callback, { success: true });
        }
    };

    /**
    * # Dynamic Feature Events
    * With dynamic feature events it is possible to override default actions for particular features
    * for the following events:
    * * click
    * * dbclick
    * * tooltiptext
    * * hidetooltip
    * * over
    * * out
    *
    * Dynamic feature events are defined for particular feature classes by providing the obligatory
    * featureClassId parameter. Callbacks provided for the feature events have a feature object as
    * their first argument. If the callback method returns true (or anything that evaluates to true)
    * it means that it declares that the handling of the event is finished. If the callback returns
    * null or false (or anything that evaluates to these values), it means that default action should
    * be performed after the callback. An example:
    *
    *     $GP.dynamicFeatureEvents.register({
    *         featureClassId: "{http://www.intergraph.com/geomedia/gml}OM_USA_STATES",
    *         click: function (feature) {
    *             if (feature.get_geoJSON().properties["{http://www.intergraph.com/geomedia/gml}ID"] % 2 === 0) {
    *                 $GP.ui.info("With selection")
    *                 return false;
    *             }
    *             $GP.ui.info("Without selection")
    *             return true;
    *         }
    *     }, function () {
    *         $GP.legend.add({
    *             url: "http://demo.hexagongeospatial.com/GWM_WFS_NonTransactional/service.svc/get",
    *             definitionName: "WFS",
    *             ids: ["{http://www.intergraph.com/geomedia/gml}OM_USA_STATES"]
    *         });
    *     });
    *
    * @class $GP.dynamicFeatureEvents
    * @singleton
    */
    gp.dynamicFeatureEvents = {

        /**
        * Registers dynamic feature event callback
        * @param {Object} config
        * @param {String} config.featureClassId FeatureClass ID
        * @param {Function} [config.click]
        * @param {Function} [config.dbclick]
        * @param {Function} [config.tooltiptext]
        * @param {Function} [config.showtooltip]
        * @param {Function} [config.hidetooltip]
        * @param {Function} [config.over]
        * @param {Function} [config.out]
        * @param {String} [config.mapStateId] Map State ID ("map" by default)
        * @param {Function} [callback] callback executed if operation succeeds
        * @method register
        */
        register: function (config, callback) {
            var cfg = {};
            ["click", "dbclick", "tooltiptext", "showtooltip", "hidetooltip", "over", "out"].forEach(function (eventName) {
                if (typeof config[eventName] === T_FUNCTION)
                    cfg[eventName] = liftCallback(getMapState(config).get_id(), config[eventName]);
            });
            getPortalObj(P_DFEM).register(config.featureClassId, cfg);
            fire(F_SUCCESS, callback, { success: true });
        },

        /**
        * Unregisters the dynamic feature event callback
        * @param {Object} config
        * @param {String} config.featureClassId FeatureClass ID
        * @param {String} [config.mapStateId] Map State ID ("map" by default)
        * @param {Function} [callback] callback executed if operation succeeds
        * @method unregister
        */
        unregister: function (config, callback) {
            getPortalObj(P_DFEM).unregister(config.featureClassId);
            fire(F_SUCCESS, callback, { success: true });
        }
    };

    // Converts GeoJSON feature to internal portal Feature object
    // @param {Object} f - geoJSON feature
    // @param {FeatureClass} - internal portal feature class
    // @param {KeyField} - internal portal keyField
    // @return {Feature} - internal portal feature object
    function feature2feature(f, featureClass, keyField) {
        var featureId = f.id || gp.utils.newGuid(keyField.get_type()),
            attributes = [];
        if (keyField) {
            attributes.push({
                Key: keyField.get_name(),
                Value: featureId
            });
        }
        var properties = f.properties || {};
        for (var pName in properties) {
            if (!Object.hasOwnProperty.call(properties, pName)) continue;
            attributes.push({
                Key: pName,
                Value: properties[pName]
            });
        }
        // fill attributes
        var featureStub = {
            id: featureId,
            attributes: attributes
        };
        var feature = new (getPortalObj(P_FEATURE))(featureClass, featureStub);
        if (typeof f.geometry !== T_UNDEFINED && f.geometry !== null)
            feature.set_geometry(getPortalObj(P_GEOJSON).read(f.geometry));
        return feature;
    }

    //TODO: validate presence of featureClassId parameter and existence of the featureclass
    //checks whether service supports editing - parameters like for $GP.services.find
    //returns service (public) and _service (private) in the callback
    function validateDataEditing(config, callback, errback) {
        gp.services.find(config, function (ret) {
            var svc = ret.services && ret.services[0];
            if (!svc) {
                return fire(F_FAILURE, errback, {
                    success: false,
                    msg: "no such a service"
                });
            }
            var ms = svc._.ms;
            if (ms.get_supportsDataEditing() || ms.get_config().supportsDataEditing) {
                return fire(F_SUCCESS, callback, {
                    success: true,
                    service: svc,
                    _service: ms
                });
            }
            return fire(F_FAILURE, errback, {
                success: false,
                msg: "service does not support data editing"
            });
        });
    }

    // Collect attributes before insertion using FeatureInfoControl
    // @param {Object} config
    // @param {Intergraph.WebSolutions.Core.WebClient.Platform.MapServices.MapService} config.mapService internal mapService object
    // @param {Intergraph.WebSolutions.Core.WebClient.Platform.MapServices.LegendItemDefinition} config.legendItemDefinition inertnal legend item definition
    // @param {GeoJSON} config.feature internal feature with geometry (e.g. after drawing it)
    // @param {Object} config.columnNameMapping mapping of column aliasName <-> name
    // @param {Function} callback
    // @param {GeoJSON} callback.feature GeoJSON.Feature
    // @param {Function} errback TODO
    // @return {void}
    function collectFeatureAttributes(config, callback/*, errback*/) {
        var mapService = config.mapService,
            legendItemDefinition = config.legendItemDefinition,
            toInternalFeature = config.toInternalFeature,
            nextFeature = toInternalFeature(config.feature),
            columnNameMapping = config.columnNameMapping;
        getPortalObj(P_EVENT).notify(E_SHOW_FEATUREINFO, {
            actionName: "InsertFeature",
            legendItemDefinition: legendItemDefinition,
            legendItemDefinitionKey: legendItemDefinition.getKey(),
            wholeFeature: null,
            skipRasterLayers: true,
            mapServiceId: mapService.get_id(),
            featureId: nextFeature && nextFeature.get_id(),
            insertFeatureCallback: function (featureFromPrompt) {
                // BEGIN hack - mapping with aliasName as there are no attribute column ids
                var attributes = featureFromPrompt.get_attributes();
                Object.keys(attributes).forEach(function (aliasName) {
                    if (aliasName === "_KEY_") return;
                    nextFeature.set_attribute(columnNameMapping[aliasName], attributes[aliasName]);
                });
                // END hack
                fire(F_SUCCESS, callback, {
                    feature: getPortalObj(P_GEOJSON).getFeature(nextFeature)
                });
            },
            insertFeatureScope: null
        }, null);
    }

    function makeInsertFeatureCallback(config, callback/*, errback*/) {
        return function() {
            return fire(F_SUCCESS, callback, {
                success: true,
                features: config.features.map(function(f) {
                    var publicFeature = new Feature({
                        portalFeature: f,
                        mapStateId: config.mapStateId
                    });
                    return publicFeature;
                }),
                featureClassId: config.featureClassId
            });
        };
    }

    // Insert or Update features on the MapService (PSS/WFS) using GeoJSON Features
    // If config.promptForAttributes is set, the Feature Info Dialog is used to collect attributes
    // @param {Intergraph.WebSolutions.Core.WebClient.Platform.MapServices.MapService} internal mapService object
    // @param {Object} config
    // @param {Object} config.geojson - Feature or FeatureCollection
    // @param {String} config.featureClassId
    // @param {Boolean} [config.promptForAttributes] display FeatureInfoControl to get attributes before inserting
    // @param {String} [config.mapStateId]
    // @param {Function} callback
    // @param {Function}
    // @return {void}
    function editFeature(mapService, config, callback, errback) {
        var promptForAttributes = config.promptForAttributes,
            geojson = config.geojson,
            geojsonfeatures = geojson.features || [geojson],
            idCount = geojsonfeatures.filter(function(feat) { return !!feat.id; }).length,
            mapStateId = getMapState(config).get_id(),
            featureClassId = config.featureClassId,
            legendItemDefinition = mapService.findLegendItemDefinition(featureClassId),
            beforeInsert = config.beforeInsert || function (obj, cb) { cb(obj); },
            editMethod;

        if (idCount === 0) {
            editMethod = mapService.insertFeatures;
        } else if (idCount === geojsonfeatures.length) {
            editMethod = mapService.updateFeatures;
        } else {
            fire(F_FAILURE, errback, {
                success: false,
                msg: "id should be present either in all the features or not present at all"
            });
            return;
        }

        mapService.ensureColumns([legendItemDefinition], function () {
            var columns = legendItemDefinition.get_columns(),
                columnNameMapping = Array.prototype.reduce.call(columns, function(prev, next) {
                    prev[next.aliasName] = next.name;
                    return prev;
                }, {});
            mapService.getFeatureDataset([legendItemDefinition], function(emptyFeatureDataset) {
                var featureClass = emptyFeatureDataset.get_featureClasses()[featureClassId],
                    keyField = featureClass.get_fieldContainer().getKeyFields()[0],
                    toInternalFeature = function (feature) {
                        return feature2feature(feature, featureClass, keyField);
                    };

                collectFeatures({
                    mapService: mapService,
                    promptForAttributes: promptForAttributes,
                    legendItemDefinition: legendItemDefinition,
                    columnNameMapping: columnNameMapping,
                    featureClassId: featureClassId,
                    toInternalFeature: toInternalFeature,
                    geojson: config.geojson
                }, function(geoJsonFeatures) {
                    processFeatures({
                        mapStateId: mapStateId,
                        mapServiceId: mapService.get_id(),
                        features: geoJsonFeatures,
                        toInternalFeature: toInternalFeature,
                        featureClassId: featureClassId,
                        beforeInsert: beforeInsert
                    }, function (features) {
                        var insertFeatureCallback = makeInsertFeatureCallback({
                            features: features,
                            featureClassId: featureClassId,
                            mapStateId: mapStateId
                        }, callback, errback);
                        editMethod.call(mapService, featureClassId, features, insertFeatureCallback, null);
                    }, errback);
                }, errback);
            });
        });
    }

    // Preprocess GeoJSON features and transform them to internal features that can be used with mapService.insertFeature
    // @param {Object} config
    // @param {String} config.featureClassId
    // @param {String} config.mapServiceId
    // @param {GeoJSON.Feature[]} config.features
    // @param {Function} config.toInternalFeature translator of GeoJSON to internal feature object
    // @param {GeoJSON} config.toInternalFeature.feature GeoJSON feature
    // @param {Function} config.beforeInsert
    // @param {Object} config.beforeInsert.config
    // @param {String} config.beforeInsert.config.featureClassId Feature Class ID
    // @param {String} config.beforeInsert.config.mapServiceId Map Service ID
    // @param {Function} config.beforeInsert.callback
    // @param {Object} config.beforeInsert.callback.result
    // @param {String} config.beforeInsert.callback.result.featureClassId Feature Class ID
    // @param {String} config.beforeInsert.callback.result.mapServiceId Map Service ID
    // @param {Function} config.beforeInsert.errback Error callback
    // @return {void}
    function processFeatures(config, callback, errback) {
        var featureClassId = config.featureClassId,
            mapServiceId = config.mapServiceId,
            toInternalFeature = config.toInternalFeature,
            geoJsonFeatures = config.features,
            beforeInsert = config.beforeInsert;
        beforeInsert({
            features: geoJsonFeatures,
            featureClassId: featureClassId,
            mapServiceId: mapServiceId
        }, function(ret) {
            var portalFeatures = ret.features.map(toInternalFeature);
            fire(F_SUCCESS, callback, portalFeatures);
        }, errback);
    }

    // Feature Info Dialog is displayed for each feature from config.geojson if config.promptForAttributes is set
    // The callback is executed after all features are ready
    // @param {Object} config
    // @param {Intergraph.WebSolutions.Core.WebClient.Platform.MapServices.MapService} config.mapService internal mapService object
    // @param {Boolean} [config.promptForAttributes] display FeatureInfoControl to get attributes before inserting
    // @param {String} config.featureClassId,
    // @param {Object} config.columnNameMapping
    // @param {Object} config.geojson - Feature or FeatureCollection
    // @param {String} config.featureClassId
    // @param {Function} callback
    // @param {GeoJSON.Feature[]} callback.features Internal features
    // @param {Function} errback TODO
    // @return {void}
    function collectFeatures(config, callback/*, errback*/) {
        var mapService = config.mapService,
            promptForAttributes = config.promptForAttributes,
            toInternalFeature = config.toInternalFeature,
            geojson = config.geojson,
            legendItemDefinition = config.legendItemDefinition,
            columnNameMapping = config.columnNameMapping,
            features = geojson.features || [geojson],
            temp,
            collectedFeatures = [],
            executeNextCallback = function () {
                if (temp.length === 0) {
                    fire(F_SUCCESS, callback, collectedFeatures);
                } else {
                    collectFeatureAttributes({
                        feature: temp.shift(),
                        toInternalFeature: toInternalFeature,
                        legendItemDefinition: legendItemDefinition,
                        mapService: mapService,
                        columnNameMapping: columnNameMapping
                    }, function (result) {
                        collectedFeatures.push(result.feature);
                        executeNextCallback();
                    });
                }
            };
        if (promptForAttributes) {
            temp = Array.prototype.slice.call(features);
            return executeNextCallback();
        } else {
            return fire(F_SUCCESS, callback, features);
        }
    }

    // Collects column information from GeoJSON features array
    // To be used with Array.prototype.readuce (featureCollection.features.reduce)
    function accumulateColumns (prev, current) {
        for (var pName in current.properties) {
            if (current.properties.hasOwnProperty(pName) && !prev.hasOwnProperty(pName)) {
                if (!prev.u[pName]) {
                    prev.x.push({
                        aliasName: pName,
                        name: pName,
                        type: "System.String",
                        isKey: false
                    });
                }
                prev.u[pName] = !0;
            }
        }
        return prev;
    }

    // Prepares internal portal FeatureDataset object from collection of simple public JSONs
    // @param {Array} featureCollectionInfo - [{featureClassId: "Test", featureClassName: "Test", geojson: {/*FeatureCollection*/}}]
    // @return {FeatureDataset} internal portal FeatureDataset object
    function prepareFeatureDataset(featureCollectionInfo) {
        var fd = new (getPortalObj(P_FEATURE_DATASET))();
        for (var i = 0, l = featureCollectionInfo.length; i < l; i++) {
            var data = featureCollectionInfo[i];
            var fcs = getPortalObj(P_GEOJSON).readFeatureCollection(data.geojson, "geometry");
            fcs.id = data.featureClassId;
            fcs.name = data.featureClassName || fcs.id;
            var fc = fd.createFeatureClass(fcs);
            var fields = [{
                name: "geometry",
                geometryType: 4,
                type: "Intergraph.WebSolutions.Core.WebClient.MapManager.Common.Geometry"
            }].concat(data.geojson.features.reduce(accumulateColumns, {
                x: [],
                u: {}
            }).x);
            var fieldContainer = new (getPortalObj(P_FIELDCONTAINER))(fields);
            fc._fieldContainer = fieldContainer;
        }
        return fd;
    }

    /**
    * Feature column model
    * @class Attribute
    */
    function Attribute(portalColumn) {
        /**
        * @property {Object} _ Private internals, use at your own risk. Hic sunt leones.
        * @property {Object} _.column internal portal column representation
        */
        this._ = {
            column: portalColumn
        };
    }

    Attribute.prototype = {
        /**
        * @method get_id
        * @return {String}
        */
        get_id: function() { return this._.column.name; },
        /**
        * @method get_name
        * @return {String}
        */
        get_name: function() { return this._.column.aliasName; },
        /**
        * @method get_isKey
        * @return {Boolean}
        */
        get_isKey: function() { return this._.column.isKey; },
        /**
        * @method get_type
        * @return {String}
        */
        get_type: function() { return this._.column.type; }
    };

    // Converts internal column type to external column type
    function column2column(portalColumn) {
        return new Attribute(portalColumn);
    }

    /**
    * # Data editing
    * With $GP.edit it is possible to insert, update, retrieve and delete data from
    * datasources that support data editing (currently it is WFS-T and PSS).
    * Public API data editing is build on the basis of the GeoJSON format.
    * Features are converted to internal portal representations and the portal server
    * takes care of the editing.
    *
    * With data sources that support feature class manipulation (currently only the PSS)
    * it is also possible to define, change and remove feature classes
    *
    * For convenience and for giving more power to the API, it is also possible to
    * import whole featureClasses from GeoJSON feature collections - in that case
    * featureClasses are defined by analyzing parameters in features given in the
    * collection.
    *
    * @class $GP.edit
    * @singleton
    */
    gp.edit = {
        /**
        * Finds map service and returns its feature class IDs in a callback
        * See {@link $GP.services.find} for config properties description
        * @method getFeatureClassIds
        * @param {Object} config
        * @param {String} config.mapServiceId Map Service ID
        * @param {Function} callback Success callback
        * @param {Object} callback.result Result object
        * @param {String[]} callback.result.featureClassIds Feature Class IDs
        * @param {Function} errback Failure callback
        * @return {void}
        */
        getFeatureClassIds: function (config, callback, airbag) {
            gp.services.find(config, function (result) {
                var ms = result.services[0]._.ms,
                    lids = ms.get_legendItemDefinitions(),
                    ret = lids.map(function (x) { return x.get_id(); });
                fire(F_SUCCESS, callback, {
                    success: true,
                    featureClassIds: ret
                });
            }, airbag);
        },

        /**
        * Finds a feature class and returns its attributes in a callback
        * See {@link $GP.services.find} for config properties description
        * @method getAttributeList
        * @param {Object} config
        * @param {String} config.mapServiceId Map Service ID
        * @param {String} config.featureClassId Feature Class ID
        * @param {Function} callback Success callback
        * @param {Object} callback.result Result object
        * @param {String[]} callback.result.attributeList Attribute List
        * @param {Function} errback Failure callback
        * @return {void}
        */
        getAttributeList: function (config, callback, airbag) {
            config = config || {};
            if (!config.featureClassId) {
                return fire(F_FAILURE, airbag, {
                    success: false,
                    msg: "featureClassId not provided"
                });
            }
            gp.services.find(config, function (result) {
                var ms = result.services[0]._.ms,
                    lid = ms.findLegendItemDefinition(config.featureClassId);
                ms.ensureColumns([lid], function () {
                    var columns = lid.get_columns() || [];
                    fire(F_SUCCESS, callback, {
                        attributeList: columns.map(column2column)
                    });
                });
            }, airbag);
        },

        /**
        * @method getAttributeValues
        * @param {Object} config
        * @param {String} config.mapServiceId Map Service ID
        * @param {String} config.featureClassId Feature Class ID
        * @param {String} config.attributeId Attribute ID
        * @param {Number} [config.start] Pagination start. Default = 0
        * @param {Number} config.limit Pagination limit. Default = 20
        * @param {Function} callback Success callback
        * @param {Object} callback.result Result object
        * @param {Object[]} callback.result.values Attribute List
        * @param {Function} errback Failure callback
        * @return {void}
        */
        getAttributeValues: function (config, callback, airbag) {
            config = config || {};
            if ([config.mapServiceId, config.featureClassId, config.attributeId].some(function(x) {
                return typeof x !== "string";
            })) {
                return fire(F_FAILURE, airbag, {
                    success: false,
                    msg: "featureClassId, attributeId and mapServiceId must be provided"
                });
            }
            var request = getPortalObj(P_WEB_REQUEST).create({
                name: "Analyses",
                query: { action: "getvalues" },
                body: {
                    legendItemDefinitionId: config.featureClassId,
                    mapServiceId: config.mapServiceId,
                    attributeName: config.attributeId,
                    start: config.start,
                    limit: config.limit || 20
                },
                includeCRS: false,
                callback: function(executor) {
                    if (!getPortalObj(P_UTIL).checkExecutor(executor, function() {}))
                        return fire(F_FAILURE, airbag, { success: false });
                    var result = executor.get_object();
                    if (result.error) {
                        return fire(F_FAILURE, airbag, { success: false });
                    }
                    return fire(F_SUCCESS, callback, {
                        success: true,
                        values: result.values,
                        total: result.total
                    });
                }
            });
            request.invoke();
            return void(0);
        }
    };

    /**
    * Feature manipulation
    * @class $GP.edit.features
    * @singleton
    */
    gp.edit.features = {
        /**
        * Adds new features to the existing feature class
        * @param {Object} config
        * @param {String} config.featureClassId
        * @param {GeoJSON} config.geojson Feature or FeatureCollection.
        * @param {Boolean} config.promptForAttributes collect attributes using FeatureInfo control
        * @param {Function} config.beforeInsert Function executed just before the insert features request
        * @param {Object} config.beforeInsert.config
        * @param {String} config.beforeInsert.config.featureClassId Feature Class ID
        * @param {String} config.beforeInsert.config.mapServiceId Map Service ID
        * @param {Function} config.beforeInsert.callback
        * @param {Object} config.beforeInsert.callback.result
        * @param {String} config.beforeInsert.callback.result.featureClassId Feature Class ID
        * @param {String} config.beforeInsert.callback.result.mapServiceId Map Service ID
        * @param {Function} config.beforeInsert.errback Error callback
        * @param {Function} callback Success callback
        * @param {Object} callback.result Callback Result
        * @param {Boolean} callback.result.success true
        * @param {String} callback.result.featureClassId FeatureClass ID
        * @param {Feature[]} callback.result.features Added features
        * @param {Function} errback Failure callback
        * @param {Object} errback.result Error callback result
        * @param {Boolean} errback.result.success false
        * @return {void}
        * @method add
        */
        //TODO: validate presence of geojson
        //TODO: validate lack of ids
        add: function (config, callback, errback) {
            validateDataEditing(config, function (ret) {
                editFeature(ret._service, config, callback, errback);
            }, errback);
        },

        /**
        * Finds features by ID (not Queries!)
        * @param {Object} config
        * @param {String} config.featureClassId
        * @param {Array} config.featureIds
        * @param {Function} callback
        * @param {Function} errback
        * @method find
        */
        // TODO: WFS-T geometries are reversed
        find: function (config, callback, errback) {
            var mapStateId = getMapState(config).get_id();
            if (!config.featureClassId || !config.featureIds) {
                return fire(F_FAILURE, errback, {
                    success: false,
                    msg: "featureClassId and featureIds must be provided"
                });
            }
            validateDataEditing(config, function (ret) {
                var legendItemDefinition = ret._service.findLegendItemDefinition(config.featureClassId);
                if (!legendItemDefinition) {
                    fire(F_FAILURE, errback, {
                        success: false,
                        msg: "Feature Class not found"
                    });
                    return;
                }
                ret._service.getFeatureDataset([legendItemDefinition], function (emptyFeatureDataset) {
                    var featureClass = emptyFeatureDataset.get_featureClasses()[config.featureClassId];
                    if (!featureClass.get_geometryFieldName())
                        featureClass._geometryFieldName = "geometry";
                    getPortalObj(P_WEB_REQUEST).create({
                        name: "InsertFeature",
                        query: {
                            action: "retrievefeatures",
                            mapServiceId: ret._service.get_id(),
                            legendItemDefinitionId: config.featureClassId
                        },
                        body: {
                            featureIds: JSON.stringify(config.featureIds)
                        },
                        mapService: ret._service,
                        callback: function(e){
                            var o = e.get_object();
                            if (!o || o.error) {
                                return fire(F_FAILURE, errback, {
                                    success: false,
                                    msg: (o || {}).error || "Unknown error"
                                });
                            }
                            return fire(F_SUCCESS, callback, {
                                success: true,
                                features: o.map(function(item){
                                    var internalFeature = new (getPortalObj(P_FEATURE))(featureClass, item);
                                    if (ret.service.definitionName === "WFS" && getPortalObj(P_CRS).qualifiesForSwapById(getPortalObj(P_CRS).getReprCode(), "WFS", null)) {
                                        item.get_geometry.swapCoordinates();
                                    }
                                    var publicFeature = new Feature({
                                        portalFeature: internalFeature,
                                        mapStateId: mapStateId
                                    });
                                    return publicFeature;
                                }),
                                featureClassId: config.featureClassId
                            });
                        }
                    }).invoke();
                }, null, {empty: true});
            });
        },

        /**
        * Update existing features by ID
        * @param {Object} config
        * @param {String} config.featureClassId
        * @param {GeoJSON} config.geojson Feature or FeatureCollection.
        * Each updated feature should have an additional "id" field:
        * 
        *     {
        *         "type": "Feature",
        *         "id": <Number>
        *         "properties": {...},
        *         "geometry": {...}
        *     }
        *
        * that is used to reference the entity that is being updated.
        * @param {Function} callback Success callback
        * @param {Object} callback.result Callback Result
        * @param {Boolean} callback.result.success true
        * @param {String} callback.result.featureClassId FeatureClass ID
        * @param {Feature[]} callback.result.features Added features
        * @param {Function} errback Failure callback
        * @param {Object} errback.result Error callback result
        * @param {Boolean} errback.result.success false
        * @return {void}
        * @method update
        */
        //TODO: validate presence of geojson
        //TODO: validate presence of ids
        update: function (config, callback, errback) {
            validateDataEditing(config, function (ret) {
                editFeature(ret._service, config, callback, errback);
            }, errback);
        },

        /**
        * Remove existing features by ID
        * @param {Object} config
        * @param {String} config.featureClassId
        * @param {Array} config.featureIds
        * @param {Function} callback
        * @param {Function} errback
        * @method remove
        */
        remove: function (config, callback, errback) {
            validateDataEditing(config, function (ret) {
                var ms = ret._service,
                    lid = ms.findLegendItemDefinition(config.featureClassId);
                ms.removeFeaturesEx([lid], [config.featureIds], function () {
                    getPortalObj(P_EVENT).notify("featuresRemoved", {legendItemDefinitions: [lid]});
                }, null);
            }, errback);
        },

        /**
        * Imports feature collections to the service. Only for PSS now.
        * @param {Object} config
        * @param {String} [config.mapServiceId] either mapServiceId or definitionName&name or url must be present
        * @param {String} [config.url]
        * @param {String} [config.name]
        * @param {String} [config.definitionName]
        * @param {Array} config.featureCollectionsData [{featureClassId: "Test", featureClassName: "Test", geojson: {&lt;FeatureCollection&gt;}}]
        * @param {Function} callback
        * @param {Function} errback
        * @method importFeatureCollections
        */
        importFeatureCollections: function (config, callback, errback) {
            gp.services.find(config, function (ret) {
                var fd = prepareFeatureDataset(config.featureCollectionsData);
                ret.service._.ms.importFeatureDataset(fd, function (lids) {
                    if (lids && lids.length > 0)
                        fire(F_SUCCESS, callback, {
                            success: true,
                            featureClassIds: lids.map(function(lid){return lid.get_id();})
                        });
                    else
                        fire(F_FAILURE, errback, {
                            success: false
                        });
                });
            }, errback);
        },

        /**
        * Exports feature collections from the service in JSON format. Unimplemented!
        * @param {Object} config
        * @param {Function} callback
        * @param {Function} errback
        * @method exportFeatureCollections
        */
        exportFeatureCollections: function (config, callback, errback) {
            gp.services.find(config, function (ret) {
                var ms = ret.service._.ms,
                    featureClassIds = config.featureClassIds,
                    legendItemDefinitions,
                    crsId = gp.crs.getCurrent(),
                    crs = getPortalObj(P_CRS),
                    swapped = ms.get_definition().name === "WFS" && crs.qualifiesForSwapById(crsId, "WFS");
                if (!featureClassIds)
                    legendItemDefinitions = ms.get_legendItemDefinitions().filter(function(x){return x.get_type() === 0;});
                else
                    legendItemDefinitions = config.featureClassIds.map(function (id) {
                        return ms.findLegendItemDefinition(id);
                    });
                ms.getFeatureDataset(legendItemDefinitions, makeDatasetCallback({
                    swapped: swapped,
                    format: "featureCollectionsData"
                }, callback, errback));
            }, errback);
        }
    };

    /**
    * PSS management
    * @class $GP.edit.PSS
    * @singleton
    */
    gp.edit.PSS = {
        /**
        * Adds new PSS
        * @param {Object} config
        * @param {String} config.name
        * @param {Array} config.featureClassDefinitions - like in addFeatureClasses
        * @param {Function} callback
        * @param {Function} errback
        * @method add
        */
        add: function (config, callback, errback) {
            var d = {
                supportsEditing: true,
                supportsArcGeometry: true,
                supportsDataEditing: true,
                dataEditingClientSideOnly: false,
                definitionName: "PersonalStorage",
                url: ""
            },
            cfg = apply({}, config, d),
            that = this;
            gp.services.add(cfg, function (ret) {
                if (config.featureClassDefinitions) {
                    that.addFeatureClasses({
                        mapServiceId: ret.msId,
                        featureClassDefinitions: config.featureClassDefinitions
                    }, function (ret2) {
                        fire(F_SUCCESS, callback, {
                            success: true,
                            mapServiceId: ret.msId,
                            msId: ret.msId,
                            featureClassIds: ret2.featureClassIds
                        });
                    }, errback);
                } else {
                    fire(F_SUCCESS, callback, {
                        success: true,
                        mapServiceId: ret.msId,
                        msId: ret.msId,
                        featureClassIds: []
                    });
                }
            }, errback);
        },

        /**
        * Adds feature classes to the existing PSS
        * @param {Object} config
        * @param {Array} config.featureClassDefinitions - [{featureClassId: &lt;id&gt;,
        * [crs: &lt;crs&gt;], [featureClassName: &lt;featureClassName&gt;],
        * [geometryType: &lt;geometryType&lt;], [fields: [{aliasName: aliasName, name: name, type: type}]]}]
        * @param {Function} callback
        * @param {Function} errback
        * @method addFeatureClasses
        */
        addFeatureClasses: function (config, callback, errback) {
            if (!config.featureClassDefinitions)
                return fire(F_FAILURE, errback, {success: false, msg: "no featureClassDefinitions"});
            var lidstubs = [];
            for (var i = 0, l = config.featureClassDefinitions.length; i < l; i++) {
                var fcd = config.featureClassDefinitions[i],
                id = fcd.featureClassId || createUuid(),
                name = fcd.featureClassName || fcd.featureClassId,
                crs = fcd.crs || gp.crs.getCurrent(),
                geometryType = fcd.geometryType || 4, // Intergraph.WebSolutions.Core.WebClient.Platform.Common.GeometryType.AnySpatial,
                style = fcd.style,
                fields = [{
                    aliasName: "_KEY_",
                    name: "_KEY_",
                    type: "System.String",
                    isKey: true
                }, {
                    name: "geometry",
                    geometryType: geometryType
                }].concat(fcd.fields || []);
                var fc = (new (getPortalObj(P_FIELDCONTAINER))(fields)),
                    lidstub = {
                        id: id,
                        name: name,
                        type: 0, //Intergraph.WebSolutions.Core.WebClient.Platform.MapServices.LegendItemType.Normal
                        validCRS: [crs],
                        columns: fc.serialize(),
                        style: {
                            isVisible: true,
                            isLocatable: true
                        },
                        canModifyData: true,
                        canDeleteData: true,
                        geometryType: geometryType,
                        defaultDisplayStyle: style
                    };
                lidstubs.push(lidstub);
            }
            gp.services.find(config, function (ret) {
                if (!ret.service)
                    return fire(F_FAILURE, errback, {
                        success: false,
                        msg: "No service"
                    });
                var legendItemDefinitions = lidstubs.map(function(lidstub){return new (getPortalObj(P_LID))(lidstub, ret.service._.ms);});
                ret.service._.ms.createLegendItemDefinitions(legendItemDefinitions);
                return fire(F_SUCCESS, callback, {
                    success: true,
                    featureClassIds: lidstubs.map(function(s){return s.id;})
                });
            }, errback);
        },

        /**
        * Removes featureClass from the PSS Unimplemented
        * @param {Object} config
        * @param {Function} callback
        * @param {Function} errback
        * @method add
        */
        removeFeatureClass: function (config, callback, errback) {
            var featureClassId = config.featureClassId;
            if (!featureClassId) {
                fire(F_FAILURE, errback, {
                    success: false,
                    msg: "No featureClassId"
                });
            }
            this.find(config, function(ret) {
                if (!ret.service) {
                    fire(F_FAILURE, errback, {
                        success: false,
                        msg: "No service"
                    });
                    return;
                }
                var portalMapService = ret.service._.ms,
                    lid = portalMapService.findLegendItemDefinition(featureClassId),
                    legendItemDefinitionsRemoved = function(eventName, eventArgs, sender) {
                        if (sender !== portalMapService) return;
                        fire(F_SUCCESS, callback, {
                            success: true,
                            featureClassId: featureClassId,
                            _: {
                                legendItemDefinitions: eventArgs.legendItemDefinitions
                            }
                        });
                        getPortalObj(P_EVENT).unregister("legendItemDefinitionsRemoved", legendItemDefinitionsRemoved, this);
                    };
                if (!lid) {
                    fire(F_FAILURE, errback, {
                        success: false,
                        msg: "Feature Class not found"
                    });
                    return;
                }
                portalMapService.removeLegendItemDefinitions([lid]);
                getPortalObj(P_EVENT).register("legendItemDefinitionsRemoved", legendItemDefinitionsRemoved, this);
            }, errback);
        },

        /**
        * Convenience method for finding PSS service
        * @param {Object} config
        * @param {Function} callback
        * @param {Function} errback
        * @method find
        */
        find: function (config, callback, errback) {
            var cfg = apply({}, config, { definitionName: "PersonalStorage" });
            gp.services.find(cfg, callback, errback);
        },

        /**
        * Removes the PSS
        * @param {Object} config
        * @param {Function} callback
        * @param {Function} errback
        * @method remove
        */
        remove: function (config, callback, errback) {
            this.find(config, function (ret) {
                var svc = ret.service;
                if (svc) {
                    svc.remove(callback, errback);
                } else
                    fire(F_FAILURE, errback, {
                        success: false,
                        msg: "No such a service"
                    });
            }, errback);
        },

        /**
        * Creates new PSS from featureCollections
        * @param {Object} config
        * @param {String} config.name Name of the PSS to be created
        * @param {Array} config.featureCollectionsData [{featureClassId: "Test", featureClassName: "Test", geojson: {&lt;FeatureCollection&gt;}}]
        * @param {Function} callback
        * @param {Function} errback
        * @method createFromFeatureCollections
        */
        createFromFeatureCollections: function (config, callback, errback) {
            this.add({
                name: config.name
            }, function (ret) {
                gp.edit.features.importFeatureCollections({
                    mapServiceId: ret.mapServiceId,
                    featureCollectionsData: config.featureCollectionsData
                }, function (ret2) {
                    gp.legend.add({
                        mapServiceId: ret.mapServiceId,
                        ids: ret2.featureClassIds
                    }, callback, errback);
                }, errback);
            }, errback);
        }
    };

    /**
    * Vendor Specific Parameters Manager
    * @class $GP.vspm
    * @singleton
    *
    * Examples:
    *
    * Add "Hello=World" GET parameter to each WMS GetMap request:
    *
    *     $GP.vspm({
    *         handler: function (context) { return {"Hello": "World"}; },
    *         predicate: function (context) { return context.operation === "GetMap" && context.definitionName === "WMS"; }
    *     },
    *     function (ret) {
    *         console.log(ret.id);
    *     });
    *
    */
    gp.vspm = {
        /**
        * Registers new Vendor Specific Parameter
        * @param {Object} descriptor handler descriptor
        * @param {Function} descriptor.handler function returning dictionary of vendor specific parameters for the given context
        * @param {Object} descriptor.handler.context execution context
        * @param {String} descriptor.handler.context.operation operation - "GetMap", "Transaction" etc
        * @param {String} descriptor.handler.context.definitionName definition name - "WMS", "WFS" etc
        * @param {String} descriptor.handler.context.mapServiceId Map Service ID
        * @param {String} descriptor.handler.context.mapServiceUrl Map Service URL
        * @param {Object} descriptor.handler.context.return Dictionary of Vendor Specific Parameters
        * @param {Function} descriptor.predicate predicate for addressing the handler only for particular contexts
        * @param {Object} descriptor.predicate.context execution context
        * @param {String} descriptor.predicate.context.operation operation - "GetMap", "Transaction" etc
        * @param {String} descriptor.predicate.context.definitionName definition name - "WMS", "WFS" etc
        * @param {String} descriptor.predicate.context.mapServiceId Map Service ID
        * @param {String} descriptor.predicate.context.mapServiceUrl Map Service URL
        * @param {Boolean} descriptor.predicate.context.return returns true if the handler is to be executed for the given context
        * @param {Function} callback callback executed when the operation is successfull
        * @param {Object} callback.ret return value of the callback
        * @param {String} callback.ret.id id of the registered handler
        * @param {Function} errback callback executed when the operation is not successfull
        * @param {Object} errback.ret return value of the callback
        * @param {String} errback.ret.message error message
        * @return {void}
        * @method register
        */
        register: function (descriptor, callback, errback) {
            try {
                if (typeof descriptor.handler !== "function") throw new Error("handler must be a function");

                var id = getPortalObj(P_VSPM).register(descriptor);
                this.ids = this.ids || [];
                this.ids.push(id);
                fire(F_SUCCESS, callback, { id: id });
            } catch (e) {
                fire(F_FAILURE, errback, { message: e });
            }
        },

        /**
        * Unregisters particular VSP handler(s). If executed without id, it unregisters all the handlers
        * @param {String} id ID of the handler to be unregistered
        * @param {Function} callback callback executed when the operation is successfull
        * @param {Object} callback.ret return value of the callback
        * @param {String} callback.ret.ids ids of the unregistered handlers
        * @param {String} callback.ret.id id of the unregistered handler
        * @param {Function} errback callback executed when the operation is not successfull
        * @param {Object} errback.ret return value of the callback
        * @param {String} errback.ret.id id of the the handler that failed to be unregistered
        * @return {void}
        * @method unregister
        */
        unregister: function (id, callback, errback) {
            var idsToUnregister;
            try {
                id = id || this.ids;
                idsToUnregister = Array.isArray(id) ? id : [id];
                var vspm = getPortalObj(P_VSPM);
                var ret = idsToUnregister.map(vspm.unregister, vspm);
                if (ret.some(function (x) { return x !== true; })) throw new Error("Unable to unregister handler");
                this.ids = this.ids.filter(function (x) { return idsToUnregister.indexOf(x) === -1; });
                fire(F_SUCCESS, callback, { ids: idsToUnregister, id: idsToUnregister[0] });
            } catch (e) {
                fire(F_FAILURE, errback, { message: e, id: id });
            }
        },

        /**
        * Returns the VSP for debugging purposes
        * @param {Object} context execution context
        * @param {String} context.operation operation - "GetMap", "Transaction" etc
        * @param {String} handler.context.definitionName definition name - "WMS", "WFS" etc
        * @param {String} context.mapServiceId Map Service ID
        * @param {String} context.mapServiceUrl Map Service URL
        * @return {Object} paremeters for the given execution context 
        */
        getParameters: function (context) {
            return getPortalObj(P_VSPM).getParameters(context);
        }
    };
})(window);