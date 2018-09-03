/// <reference name="MicrosoftAjax.debug.js" />

Sys.Application.add_load(function()
{
    var t, mapStateId = "map", mapState;
    var actions = window.wc_appConf && wc_appConf.tools || ["zoom_in", "zoom_out", "fit_all", "where_am_i", "feature_info"];
    
    function createTool(action)
    {
        var button = document.createElement("button");
        var icon = document.createElement("i");
        button.appendChild(icon);
        
        switch(action) {
            case "zoom_in":
                button.title = t.ZoomIn;
                button.handler = function (e) {
                    mapState.zoom(0.5);
                };
                break;
            
            case "zoom_out":
                button.title = t.ZoomOut;
                button.handler = function (e) {
                    mapState.zoom(2);
                }
                break;
            
            case "fit_all":
                button.title = t.FitAll;
                button.handler = function (e) {
                    mapState.fitAll();
                }
                break;
            
            case "feature_info":
                button.title = t.FeatureInfo;
                button.handler = function (e) {
                    e.target.className += " tool_pressed";
                    e.target.disabled = "disabled";
                    function cleanUp(eventName, eventArgs, sender){
                        e.target.className = e.target.className.replace(/ tool_pressed/, "");
                        e.target.disabled = "";
                        $removeHandler(document.body, "mousedown", cleanUp);                        
                    }
                    $addHandler(document.body, "mousedown", cleanUp);
                    $event.notify("featureInfo", { mapStateId: mapStateId }, e.target);                    
                }
                $event.register("featureInfoBeginRequest", function(eventName, eventArgs, sender) {
                    button.className += " tool_loading";
                }, button);
                $event.register("featureInfoEndRequest", function(eventName, eventArgs, sender) {
                    button.className = button.className.replace(/ tool_loading/, "");
                }, button);
                break;
            
            case "where_am_i":
                button.title = t.GoToMyLocation || "Go to my location";
                button.handler = function (e) {
                    navigator.geolocation.getCurrentPosition(function (position) {
                        function setRange(points) {
                            if (!points) return;
                            mapState.centerToPoint(points[0].x, points[0].y);        
                        }
                        var lat = position.coords.latitude,
                            lon = position.coords.longitude,
                            crsId = $crs.getCurrent().get_id();
                        if (crsId === "EPSG:4326")
                            mapState.centerToPoint(lon, lat);
						else if (crsId === "EPSG:3857") {
							var pt = $crs.convertToMeters(lon, lat);
							mapState.centerToPoint(pt.x, pt.y);
                        } else {
                            $crs.transformPoints("EPSG:4326", crsId, [{x: lon, y: lat}], {}, setRange, this);
                        }
                    }, function (error) {
                        //https://developers.google.com/web/updates/2016/04/geolocation-on-secure-contexts-only
                        if (error.message.includes("Only secure origins are allowed")) {
                            alert(t.LocationUnavailableNotSecured);
                        }
                        else {
                            alert(error.message);
                        }
                    });
                }
                break;
        }    
        
        button.className = "tool tool_" + action;
        button.action = action;
        $addHandler(button, "click", function(e) {
            e.preventDefault();
            if (e.target.tagName === "I")
                e.target = e.target.parentElement;
            var handler = e.target.handler;
            typeof handler === "function" && handler.call(this, e);

        });
        return button;
    }

    function init(eventName)
    {
        if (!mapState)
            mapState = $mapStateManager.findMapState(mapStateId);

        if (eventName == "mapStateVariantChanged")
            $event.unregister("mapStateVariantChanged", init);

        if (!mapState || !mapState.get_isInitialized())
        {
            $event.register("mapStateVariantChanged", init);
            return;
        }
        
        t = Application.Translate;
        
        Sys.Application.remove_load(init);
        var toolbar = $get("tools");
        for(var i=0, l= actions.length; i < l; i++) {
            var btn = createTool(actions[i]);
            toolbar.appendChild(btn);
        }
    }
    return init;
} ());

Sys.Application.add_load(function(){
    var orientationEvent = "onorientationchange" in window ? "orientationchange" : "resize";
    function f(){$event.notify("orientationchanged", {}, window);}
    if (window.addEventListener) 
        window.addEventListener(orientationEvent, f, false);
});