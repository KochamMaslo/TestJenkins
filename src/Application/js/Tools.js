/// <reference name="MicrosoftAjax.debug.js" />

Sys.Application.add_load(function()
{
    var t, mapStateId = "map", mapState;
    var actions2D = ["3d2d", "zoom_in", "zoom_out", "zoom_rect", "fit_all", "feature_info"];
    var actions3D = ["3d2d", "zoom_in", "zoom_out", "reset_north", "fit_all", "feature_info"];

    function createTools()
    {
        var toolbar = $get("navigatorTools");
        if (!toolbar)
            return;
        var actions = actions2D;
        var button;

        for (var i = 0, l = actions.length; i < l; i++)
        {
            button = createTool(actions[i]);
            toolbar.appendChild(button);
        }

    }

    function recreateTools(eventName)
    {
        var toolbar = $get("navigatorTools");
        if (!toolbar)
            return;
        var actions;
        var mcc = mapState.get_mapControlContainer(),
            mapControl = mcc.get_mapControl();
        var mapDefName = mapControl.get_definitionName();

        switch (mapDefName) {
            case "WCMapControl": //"createToolbar2D":
                //TODO $util.isMsEdge() and $util.isIE11() should be used, but it must be tested (size of downloaded scripts)
                var hide3D = mcc.get_enableInEdge() === false && /Edge\/\d+\./i.test(navigator.userAgent) || mcc.get_disableSwitcher() ||
                    !!navigator.userAgent.match(/Trident\/7.0/) && !/x64|x32/ig.test(navigator.userAgent);
                actions = actions2D.slice(hide3D ? 1 : 0);
                break;
            case "WCMyvrMapControl": //"createToolbar3D":
                if (mapControl.isWebGLMode() === true) {
                    var hide2D = mcc.get_disableSwitcher();
                    actions = actions3D.slice(hide2D ? 1 : 0);
                } else {
                    actions = [];
                }
                break;
        }

        for (var i = toolbar.childNodes.length - 1; i >= 0; i--)
            toolbar.removeChild(toolbar.childNodes[i]);
        toolbar.style.width = actions.length * 36 + "px";

        var button;
        for (var i = 0, l = actions.length; i < l; i++) {
            button = createTool(actions[i]);
            toolbar.appendChild(button);
        }
    }

    function createTool(action)
    {
        var text;
        switch (action)
        {
            case "zoom_in":
                text = t.ZoomIn;
                break;
            case "zoom_out":
                text = t.ZoomOut;
                break;
            case "zoom_rect":
                text = t.ZoomRect;
                break;
            case "fit_all":
                text = t.FitAll;
                break;
            case "feature_info":
                text = t.FeatureInfo;
                break;
            case "3d2d":
                text = "3D/2D";
                break;
            case "reset_north":
                text = t.ResetNorth;
                break;
        }
        var button = document.createElement("a");
        button.href = "#";
        button.className = "tool tool_" + action;
        button.action = action;
        button.innerHTML = text;
        button.title = text;
        $addHandler(button, "click", doAction);
        return button;
    }

    function doAction(e)
    {
        var mapControl = mapState.get_mapControlContainer().get_mapControl();
        var mapDefName = mapControl.get_definitionName();

        e.preventDefault();
        var action = e.target.action;
        switch (action)
        {
            case "zoom_in":
                if (mapDefName == "WCMapControl")
                    mapState.zoom(0.5);
                else if (mapControl.myvrZoomIn)
                    mapControl.myvrZoomIn();
                break;
            case "zoom_out":
                if (mapDefName == "WCMapControl")
                    mapState.zoom(2);
                else if (mapControl.myvrZoomOut)
                    mapControl.myvrZoomOut();
                break;
            case "zoom_rect":
                $event.notify("zoomRect", { mapStateId: mapStateId }, e.target);
                break;
            case "fit_all":
                mapState.fitAll();
                break;
            case "feature_info":
                $event.notify("featureInfo", { mapStateId: mapStateId }, e.target);
                break;
            case "3d2d":
                $event.notify("switch3d2d", { id: "WCMyvrMapControl" }, e.target);
                break;
            case "reset_north":
                if (mapDefName == "WCMyvrMapControl")
                    mapControl.resetNorth();
                break;
        }
    }

    function init(eventName)
    {
        if (!mapState)
            mapState = $mapStateManager.findMapState(mapStateId);

        if (eventName == "mapStateVariantChanged")
        {
            $event.unregister("mapStateVariantChanged", init);
        }

        if (!mapState || !mapState.get_isInitialized())
        {
            $event.register("mapStateVariantChanged", init);
            return;
        }
        
        Sys.Application.remove_load(init);

        t = Application.Translate;
        createTools();
        $event.register("createToolbar", recreateTools);
        recreateTools("");
    }

    return init;
} ());