Sys.Application.add_load(function () {
    var msm,
        query,
        translate,
        sidebar,
        util,
        search,
        searchCollapseTool,
        mapControlContainer,
        mouseCaptionId = "mouseCaption",
        isFirefox = navigator.userAgent.toLowerCase().indexOf('firefox') > -1,
        totalWaitingTime = 0,
        waitInterval = 500,
        maxWaitingTime = 10000,
        overlayDiv = document.createElement("div"),
        overlayTransparentDiv = document.createElement("div"),
        textLoading = document.createElement("div"),
        textSuccess = document.createElement("div"),
        textFailure = document.createElement("div"),
        buttonsWrapper = document.createElement("div");


    function ensureExtComponent(id) {
        var component = Ext.ComponentMgr.get(id);
        if (!component)
            Ext.ComponentMgr.onAvailable(id, initAdmin);
        return component;
    }

    function initAdmin() {
        if (!sidebar)
            sidebar = ensureExtComponent(mapInfo.sidebarId);
        if (!sidebar)
            return;
        if (!sidebar.ownerCt) {
            setTimeout(initAdmin, 50);
            return;
        }
        if (!search)
            search = ensureExtComponent(mapInfo.searchId);
        if (!search)
            return;
        if (!search.ownerCt) {
            setTimeout(initAdmin, 50);
            return;
        }
        Sys.Application.remove_load(initAdmin);
        $event.register("mapControlChanged", updateAutoHoverAndCaptions, this);
        $event.register("createCloudApp", openCreateCloudAppWindow, this);
        mapControlContainer = $find(mapInfo.getMapControlContainerId("map"));
        updateAutoHoverAndCaptions();
        setupCollapsePanels();
        
        msm = Intergraph.WebSolutions.Core.WebClient.Platform.MapStorage.MapStorageManager;
        util = Intergraph.WebSolutions.Core.WebClient.Platform.Common.Util;
        translate = Intergraph.WebSolutions.Core.WebClient.Controls.Translate;
        query = getRequestParams();
        if (query.instanceName && query.serviceUrl && query.serviceSource) {
            createOverlay();
            prepareStartingWMPSWorkspace();
        }
    }

    function openCreateCloudAppWindow() {
        var stubWorkspaceName = "Las Vegas";
        util.showInfo("Sending map to the Cloud...");
        msm.sendToCloud(this._mapStateId, stubWorkspaceName, sendToCloudCallback, null, this);

        function sendToCloudCallback(result) {
            if (!result || !result.mapId)
                return;
            util.showInfo("Map sent to the cloud");
            var widthAspect = 0.53125;
            var windowWidth = window.innerWidth * widthAspect;
            var windowOffsetLeft = (window.innerWidth / 2) - windowWidth / 2;
            var windowOffsetTop = 36;
            var defaultWindowHeight = 920;
            var windowHeight = window.innerHeight > defaultWindowHeight + windowOffsetTop ? defaultWindowHeight : window.innerHeight - windowOffsetTop;
            $event.notify("showWebBrowser", {
                mapStateId: "map",
                width: windowWidth,
                height: windowHeight,
                posX: windowOffsetLeft,
                posY: windowOffsetTop,
                title: "Create Application in Cloud",
                hideTabSelector: true,
                link: "http://studio.hexagongeospatial.com//#/wizards/map-viewer/step/2?title=" + encodeURI(stubWorkspaceName) + "&mapId=" + encodeURI(result.mapId)
            }, this);
        }
    }

    function prepareStartingWMPSWorkspace() {
        var def = $GP.internal.$mapServiceDefinitionManager.findMapServiceDefinition("MapPublisher");
        if (totalWaitingTime > maxWaitingTime) {
            finishWithFailure(translate.ServiceInitializationFailure);
        }
        else if (!def) {
            setTimeout(prepareStartingWMPSWorkspace, waitInterval);
            totalWaitingTime += waitInterval;
            return;
        }
        else {
            $event.register("mapServiceInitialized", createWorkspace, this);
            $event.register("mapServiceInitFailed", serviceInitFailure);
            registerWMPSMapService();
        }
    }

    function createOverlay() {
        overlayDiv.className = "portalOverlay";
        overlayTransparentDiv.className = "portalTransparentOverlay";
        textLoading.className = "textWrapper textLoadingVisible";
        textSuccess.className = "textWrapper textSuccessHidden";
        textFailure.className = "textWrapper textFailureHidden";
        textLoading.innerHTML = translate.WorkspaceLoading;
        buttonsWrapper.className = "buttonsWrapperHidden";
        var buttonContinue = document.createElement("div");
        var buttonLeave = document.createElement("div");
        buttonContinue.className = "button";
        buttonLeave.className = "button leave";
        buttonContinue.innerHTML = translate.ContinueUsing;
        buttonLeave.innerHTML = translate.Close;
        buttonContinue.onclick = removeOverlay;
        buttonLeave.onclick = closeWindow;
        buttonsWrapper.appendChild(buttonContinue);
        buttonsWrapper.appendChild(buttonLeave);
        overlayTransparentDiv.appendChild(textLoading);
        overlayTransparentDiv.appendChild(textSuccess);
        overlayTransparentDiv.appendChild(textFailure);
        overlayTransparentDiv.appendChild(buttonsWrapper);
        document.body.appendChild(overlayDiv);
        document.body.appendChild(overlayTransparentDiv);
    }

    function registerWMPSMapService() {
        var configItems = [{
            Key: "applicationId",
            Value: query.serviceSource
        }, {
            Key: "imageFormat",
            Value: 0
        }, {
            Key: "url",
            Value: decodeURIComponent(query.serviceUrl)
        }];
        var new_guid = Intergraph.WebSolutions.Core.WebClient.Platform.ClientScript.Edit.Support.newGuid();
        $mapServiceManager.registerMapService({
            id: new_guid,
            config: configItems,
            definition: {
                name: "MapPublisher"
            },
        });
        var mapService = $mapServiceManager.findMapService(new_guid);
        mapService.initialize();
    }

    function createWorkspace(eventName, eventArgs, mapService) {
        if (mapService.get_name() != query.serviceSource)
            return;
        var mapState = $mapStateManager.findMapState("map");
        if (!mapState) {
            finishWithFailure(translate.WorkspaceCreatingFailure);
            return;
        }        
        mapState.removeAllMapStateVariants();
        var mapStateCurrentVariantId;
        var legendDefinitions = mapService.get_legendDefinitions();
        for (var i = 0; i < legendDefinitions.length; i++) {
            if (i === 0)
                mapStateCurrentVariantId = legendDefinitions[i].get_name();
            var mapStateVariant = {};
            mapStateVariant.id = legendDefinitions[i].get_name();
            mapStateVariant.crsId = $crs.getReprCode();
            mapStateVariant.isDefault = false;
            mapStateVariant.name = legendDefinitions[i].get_name();
            mapStateVariant.mapRange = $crs.resolveValue(legendDefinitions[i].get_boundingBoxes(), $crs.getReprCode());
            mapStateVariant.fitAllRange = legendDefinitions[i].get_boundingBoxes();
            mapStateVariant.fitAllRanges = legendDefinitions[i].get_boundingBoxes();
            $mapStateManager.registerMapStateVariant(mapState.get_id(), mapStateVariant);
            mapState.setVariant(mapStateVariant.id, true, true);
            legendDefinitions[i].addToMapState(mapState, false);
        }
        $event.register("mapStateVariantChanged", mapStateVariantChanged, this);
        mapState.setVariant(mapStateCurrentVariantId, true, true, true);
        $event.notify("mapStateVariantListChanged", { mapStateId: mapState.get_id() }, this);
        $event.unregister("mapServiceInitialized", createWorkspace, this);
    }

    function mapStateVariantChanged(eventName, eventArgs, params) {
        var today = new Date();
        function pad(n) {
            return n < 10 ? '0' + n : n;
        }
        var workspaceName = String.format("WMPS{0}{1}{0}{2}{0}{3}{0}{4}{5}", "_", today.getDay(), today.getMonth(), today.getFullYear(), pad(today.getHours()), pad(today.getMinutes()));
        msm.saveWorkspace({
            mapStateId: "map",
            name: workspaceName,
            handler: workspaceAdded,
            scope: this,
            includeCredentials: true
        });
    }

    function workspaceAdded(result) {
        $event.unregister("mapStateVariantChanged", mapStateVariantChanged, this);
        if (result.error || !result.workspace) {
            finishWithFailure(translate.WorkspaceSavingFailure);
            return;
        }
        msm.setWorkspacePublic(result.workspace.id, true, function() { workspacePublished(result.workspace.id); }, this);
    }
    
    function workspacePublished(workspaceId) {
        var request = $webRequest.create({
            name: "AdminConsole",
            body: {
                action: "setWorkspace",
                instances: Sys.Serialization.JavaScriptSerializer.serialize([query.instanceName]),
                objectToSendID: workspaceId,
                isMap: false,
                isMobile: false
            },
            callback: sendToInstancesCallback,
            scope: this,
            context: { instances: [query.instanceName] }
        });
        request.invoke();
    }
    
    function sendToInstancesCallback(response) {
        if (!response) {
            finishWithFailure(translate.WorkspaceSavingFailure)
            return;
        }
        var result = response.get_object();
        $event.notify("adminWorkspaceCreated", {}, this);
        if (!result.completed)
            finishWithFailure(result.error)
        else
            finishWithSuccess(translate.WorkspaceReady);
    }

    function serviceInitFailure(eventName, eventArgs, mapService) {
        if (mapService && mapService.get_config() && mapService.get_config().url === decodeURIComponent(query.serviceUrl))
            finishWithFailure(translate.ServiceInitializationFailure)
    }

    function finishWithFailure(message) {
        textLoading.className = "textWrapper textLoadingHidden";
        buttonsWrapper.className = "buttonsWrapperVisible";
        textFailure.className = "textWrapper textFailureVisible";
        textFailure.innerHTML = message;
        $event.unregister("mapServiceInitFailed", serviceInitFailure);
    }

    function finishWithSuccess(message) {
        textLoading.className = "textWrapper textLoadingHidden";
        buttonsWrapper.className = "buttonsWrapperVisible";
        textSuccess.className = "textWrapper textFailureVisible";
        textSuccess.innerHTML = message;
        $event.unregister("mapServiceInitFailed", serviceInitFailure);
    }

    function removeOverlay() {
        document.body.removeChild(overlayDiv);
        document.body.removeChild(overlayTransparentDiv);
    }

    function closeWindow() {
        window.open('', '_self', '');
        window.close();
    }

    function getRequestParams() {
        var query_string = {};
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for (var i = 0; i < vars.length; i++) {
            var pair = vars[i].split("=");
            if (!query_string[pair[0]])
                query_string[pair[0]] = pair[1];
        }
        return query_string;
    }

    function setupCollapsePanels() {
        searchCollapseTool = Ext.get("search_collapse_tool");
        searchCollapseTool.removeAllListeners();
        searchCollapseTool.on({
            mouseover: searchCollapseTool_mouseOverOut,
            mouseout: searchCollapseTool_mouseOverOut,
            click: collapseSearch
        });
        search.setVisible(true);
    }

    function updateAutoHoverAndCaptions(eventName, args, mapControlContainer) {
        addAutoHover(sidebar);
        addAutoHover(search);
        addCaptions(sidebar, { orientation: "vertical" });
        addCaptions(search, { orientation: "horizontal" });
    }

    function addCaptions(collapsibleElement, options) {
        var collapsedElement = getCollapsedElement(collapsibleElement);
        if (!collapsedElement)
            return;
        var p = document.createElement("p");
        p.id = mouseCaptionId;
        p.style.fontSize = "14px";
        removeCaptions(collapsibleElement);
        if (options && options.orientation === "horizontal")
            p.style.marginLeft = "43%";
        else if (options && options.orientation === "vertical")
            p.className += "rotatedText";
        if (slidingAnimationsAllowed())
            p.innerHTML = Intergraph.WebSolutions.Core.WebClient.Controls.Translate.MoveMouseToExpand;
        else
            p.innerHTML = Intergraph.WebSolutions.Core.WebClient.Controls.Translate.ClickMouseToExpand;
        collapsedElement.dom.appendChild(p);
    }

    function removeCaptions(collapsibleElement) {
        var collapsedElement = getCollapsedElement(collapsibleElement);
        if (!collapsedElement)
            return;
        var previousP = collapsedElement.dom.querySelector("#" + mouseCaptionId);
        if (previousP)
            collapsedElement.dom.removeChild(previousP);
    }

    function addAutoHover(collapsibleElement) {
        if (!collapsibleElement || !collapsibleElement.region)
            return;
        // Line below is required to overcome width issues if panel should be initially hidden
        // collapsibleElement.collapse();
        var region = collapsibleElement.ownerCt.layout[collapsibleElement.region];
        var handler = function (event, target) {
            if (slidingAnimationsAllowed()) {
                if (!region.isSlid)
                    region.slideOut();
            }
            else if (event.type != "mouseenter")
                collapsibleElement.toggleCollapse(true);
            // Force layout recalculation
            collapsibleElement.doLayout();
        };
        if (region && region.getCollapsedEl()) {
            region.getCollapsedEl().on('mouseenter', handler);
            region.getCollapsedEl().on('click', handler);
        }
        overwriteRegionHideEvents(region);
    }

    function overwriteRegionHideEvents(region) {
        var st = new Ext.util.DelayedTask(region.slideIn, region);
        region.autoHideHd = {
            "mouseout": function (e) {
                if (!enhancedWithinTest(region, e))
                    st.delay(500);
            },
            "mouseover": function (e) {
                st.cancel();
            },
            scope: this
        };
        region.slideInIf = function (e) {
            if (!enhancedWithinTest(region, e))
                region.slideIn();
        }
    }

    // Standard panel test to detect if it should hide on mouseout event
    // is insufficient and has some bugs.
    // This method is the enhancement of the standard test function.
    function enhancedWithinTest(region, event) {
        if (!region || !region.el || !event)
            return;
        var xy = event.getXY(),
        // ExtJs incorrectly reports right of floating window hence offset must be added
            offset = 12,
            top = region.el.getTop(),
            left = region.el.getLeft(),
            bottom = region.el.getBottom(),
            right = region.el.getRight(),
            standardTestResult = event.within(region.el, true);
        if (standardTestResult)
            return true;
        else
            return xy[0] >= left && xy[0] <= right - offset && xy[1] >= top && xy[1] <= bottom;
    }

    function collapseSearch() {
        search.toggleCollapse(false);
    }

    function searchCollapseTool_mouseOverOut(e) {
        var f = e.type == "mouseover" ? searchCollapseTool.addClass : searchCollapseTool.removeClass;
        var c = search.collapsed ? "x-tool-collapse-north-over" : "x-tool-expand-north-over";
        f.call(searchCollapseTool, c);
    }

    function getCollapsedElement(collapsiblePanel) {
        if (!collapsiblePanel || !collapsiblePanel.region)
            return null;
        var region = collapsiblePanel.ownerCt.layout[collapsiblePanel.region];
        return region.getCollapsedEl();
    }

    function slidingAnimationsAllowed() {
        return isFirefox || mapControlContainer.get_mapControl().get_definitionName() != "WCMyvrMapControl";
    }

    return initAdmin;
} ());