/// <reference name="MicrosoftAjax.debug.js" />
/// <reference name="Intergraph.WebSolutions.Core.WebClient.Controls.Map.MapControlContainer.MapControlContainer.debug.js" assembly="Intergraph.WebSolutions.Core.WebClient.Controls"/>

Sys.Application.add_load(function () {
    var mapControlContainer, sidebar, banner, search, dataPanel, pwaPanel, bannerCollapse, searchCollapse, bannerCollapseTool, searchCollapseTool, searchCollapseShim, languageChooser;
    var hmat, vmat;
    var searchStateName = "searchExpanded",
        sideStateName = "sidebarExpanded",
        bannerStateName = "bannerExpanded",
        dataPanelStateName = "datapanelExpanded";

    function ensureExtComponent(id) {
        var component = Ext.ComponentMgr.get(id);
        if (!component)
            Ext.ComponentMgr.onAvailable(id, init);
        return component;
    }

    function init() {
        if (!banner)
            banner = ensureExtComponent(mapInfo.bannerId);
        if (mapInfo.bannerId && !banner)
            return;
        if (!sidebar)
            sidebar = ensureExtComponent(mapInfo.sidebarId);
        if (!sidebar)
            return;

        if (!sidebar.ownerCt) {
            setTimeout(init, 50);
            return;
        }

        Sys.Application.remove_load(init);

        var map = Intergraph.WebSolutions.Core.WebClient.Controls.Map;
        hmat = map.HorizontalMapAnchorType;
        vmat = map.VerticalMapAnchorType;

        mapControlContainer = $find(mapInfo.getMapControlContainerId("map"));

        /* ---------- Sidebar configuration ------------*/
        sidebar.on("expand", sidebarExpanded);
        sidebar.on("beforecollapse", sidebarBeforeCollapsed);
        sidebar.on("collapse", sidebarSizeChanged);
        
        if (sidebar.ownerCt.getLayout() && sidebar.ownerCt.getLayout().west && sidebar.ownerCt.getLayout().west.split && sidebar.ownerCt.getLayout().west.split.dd) {
            var splitDD = sidebar.ownerCt.getLayout().west.split.dd;
            splitDD.onMouseUp = splitDD.onMouseUp.createSequence(sidebarSizeChanged);
        }
        var sideState = getCookie(sideStateName);
        if (sideState === "true")
            sidebar.expand();
        else if (sideState === "false")
            sidebar.collapse();

        /* ---------- Banner configuration ------------*/
        if (banner) {
            banner.on("expand", bannerExpanded);
            banner.on("beforecollapse", beforeBannerCollapsed);

            bannerCollapse = Ext.get("banner_collapse");
            languageChooser = Ext.get("language_chooser");
            bannerCollapseTool = Ext.get("banner_collapse_tool");
            bannerCollapseTool.addClass(banner.collapsed ?
                ["x-tool", "x-tool-expand-north"] : ["x-tool", "x-tool-collapse-north"]);
            bannerCollapseTool.on({
                mouseover: bannerCollapseTool_mouseOverOut,
                mouseout: bannerCollapseTool_mouseOverOut,
                click: collapseBanner
            });

            var bannerState = getCookie(bannerStateName);
            if (bannerState === "true")
                banner.expand();
            else if (bannerState === "false")
                collapseBanner()
        }
        updateCollapseToolsOffset();
        var mapEl = mapControlContainer.get_mapDiv();
        if (mapEl.clientHeight == 0) {
            //workaround for the map div having no height in Opera 10.6
            mapEl.style.setProperty("height", mapEl.parentNode.parentNode.clientHeight + "px");
            setTimeout(function () { mapEl.style.removeProperty("height"); }, 1);
        }

        /* ---------- DataPanel configuration ------------*/
        if (mapInfo.dataPanelId && !dataPanel)
            dataPanel = ensureExtComponent(mapInfo.dataPanelId);
        if (mapInfo.dataPanelId && !!dataPanel) {
            dataPanel.on("expand", dataPanelExpanded);
            dataPanel.on("beforecollapse", beforeDataPanelCollapsed);

            var dataPanelState = getCookie(dataPanelStateName);
            if (dataPanelState === "true")
                dataPanel.expand();
            else if (dataPanelState === "false")
                dataPanel.collapse();
        }

        /* ---------- Search configuration ------------*/
        if (!search)
            search = ensureExtComponent(mapInfo.searchId);
        if (!search)
            return;
        if (!search.ownerCt) {
            setTimeout(init, 50);
            return;
        }

        search.on("expand", searchExpanded);
        search.on("beforecollapse", beforeSearchCollapsed);
        search.on("resize", searchResized);

        searchCollapse = Ext.get("search_collapse");
        searchCollapseShim = Ext.get("search_collapse_shim");
        searchCollapseTool = Ext.get("search_collapse_tool");
        searchCollapseTool.addClass(search.collapsed ?
            ["x-tool", "x-tool-collapse-north"] : ["x-tool", "x-tool-expand-north"]);
        searchCollapseTool.on({
            mouseover: searchCollapseTool_mouseOverOut,
            mouseout: searchCollapseTool_mouseOverOut,
            click: collapseSearch
        });
        
        var searchState = getCookie(searchStateName);
        if (searchState === "true")
            search.expand();
        else if (searchState === "false")
            collapseSearch();
        else
            collapseSearch();
         updateCollapseToolsOffset();
    }

    function dataPanelExpanded(dataPanel) {
        setCookie(dataPanelStateName, true);
    }

    function beforeDataPanelCollapsed(dataPanel) {
        setCookie(dataPanelStateName, false);
    }

    function sidebarExpanded(sidebar) {
        sidebarSizeChanged(sidebar);
        setCookie(sideStateName, true);
    }

    function sidebarBeforeCollapsed(sidebar) {
        sidebarSizeChanged(sidebar);
        setCookie(sideStateName, false);
    }

    function sidebarSizeChanged(sidebar) {
        forceCheckMapSize(true);
        // Force sidebar layout recalculation
        if (sidebar.doLayout)
            sidebar.doLayout();
        updateCollapseToolsOffset();
    }

    function bannerExpanded() {
        bannerCollapseTool.removeClass(["x-tool-expand-north", "x-tool-expand-north-over"]);
        bannerCollapseTool.addClass("x-tool-collapse-north");
        bannerCollapse.setTop("88px");
        if (languageChooser)
            languageChooser.setTop("87px");
        //renderingEl.setTop("115px");
        forceCheckMapSize(false);
        setCookie(bannerStateName, true);
    }

    function searchExpanded() {
        searchCollapseTool.removeClass(["x-tool-collapse-north", "x-tool-collapse-north-over"]);
        searchCollapseTool.addClass("x-tool-expand-north");
        forceCheckMapSize(false);
        setCookie(searchStateName, true);
    }

    function beforeBannerCollapsed() {
        bannerCollapseTool.removeClass(["x-tool-collapse-north", "x-tool-collapse-north-over"]);
        bannerCollapseTool.addClass("x-tool-expand-north");
        bannerCollapse.setTop("3px");
        if (languageChooser)
            languageChooser.setTop("2px");
        //renderingEl.setTop("30px");
        forceCheckMapSize(false);
        setCookie(bannerStateName, false);
    }

    function beforeSearchCollapsed() {
        searchCollapseTool.removeClass(["x-tool-expand-north", "x-tool-expand-north-over"]);
        searchCollapseTool.addClass("x-tool-collapse-north");
        searchCollapse.setBottom("4px");
        searchCollapseShim.setVisible(true);
        forceCheckMapSize(false);
        setCookie(searchStateName, false);
    }

    function collapseBanner() {
        banner.setVisible(banner.collapsed);
        banner.toggleCollapse(false);
    }

    function collapseSearch() {
        search.setVisible(search.collapsed);
        search.toggleCollapse(false);
    }

    function searchResized(searchElement) {
        var region = searchElement.ownerCt.layout[searchElement.region];
        // Do not alter searchCollapseTool if region is only slid
        if(region.isSlid)
            return;
        if (search && search.items && search.items.items && search.items.items[0] && search.items.items[0].items && search.items.items[0].items.items) {
            var height = search.getInnerHeight();
            var tbarHeight = search.items.items[0].items.items[0].tbar.getHeight();
            var hasTabs = search.items.items[0].items.items[0].items.items.length > 0;
            if (height <= 0) {
                searchCollapse.setBottom(4);
                searchCollapseShim.setVisible(true);
            }
            else {
                if (hasTabs) {
                    searchCollapse.setBottom(height - 28);
                }
                else {
                    searchCollapse.setBottom(height - tbarHeight);
                }
                searchCollapseShim.setVisible(false);
            }
        }
    }

    function bannerCollapseTool_mouseOverOut(e) {
        var f = e.type == "mouseover" ? bannerCollapseTool.addClass : bannerCollapseTool.removeClass;
        var c = banner.collapsed ? "x-tool-expand-north-over" : "x-tool-collapse-north-over";
        f.call(bannerCollapseTool, c);
    }

    function searchCollapseTool_mouseOverOut(e) {
        var f = e.type == "mouseover" ? searchCollapseTool.addClass : searchCollapseTool.removeClass;
        var c = search.collapsed ? "x-tool-collapse-north-over" : "x-tool-expand-north-over";
        f.call(searchCollapseTool, c);
    }

    function forceCheckMapSize(horizontal) {
        var anchor = mapControlContainer[horizontal ? "get_horizontalAnchor" : "get_verticalAnchor"]();
        try {
            if (horizontal)
                mapControlContainer.set_horizontalAnchor(hmat.Right);
            else
                mapControlContainer.set_verticalAnchor(vmat.Bottom);
            mapControlContainer.forceCheckMapSize();
        }
        finally {
            mapControlContainer[horizontal ? "set_horizontalAnchor" : "set_verticalAnchor"](anchor);
        }
    }

    function setCookie(key, value) {
        document.cookie = key + "=" + value;
    }

    function getCookie(cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i].trim();
            if (c.indexOf(name) == 0)
                return c.substring(name.length, c.length);
        }
        return "";
    }

    function updateCollapseToolsOffset() {
        if (sidebar && sidebar.region === "east") {
            var collapsedRightOffset = sidebar.ownerCt.layout[sidebar.region].getCollapsedEl().getWidth() + 10 + "px";
            var expandedRightOffset = sidebar.width + 6 + "px"
            if (bannerCollapse) {
                if (sidebar.collapsed)
                    bannerCollapse.setRight(collapsedRightOffset);
                else
                    bannerCollapse.setRight(expandedRightOffset);
            }
            if (searchCollapse) {
                if (sidebar.collapsed) {
                    searchCollapse.setRight(collapsedRightOffset);
                    searchCollapseShim.setRight(collapsedRightOffset);
                }
                else {
                    searchCollapse.setRight(expandedRightOffset);
                    searchCollapseShim.setRight(expandedRightOffset);
                }
            }
        }
    }
    
    return init;
} ());
