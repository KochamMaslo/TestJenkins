// WEBGL MEMORY INITIALIZATION
window.Module = window.Module || {};
window.Module.TOTAL_MEMORY = 400000000;

Sys.Application.add_init(function() {
    var u = Intergraph.WebSolutions.Core.WebClient.Platform.Common.MapPageUtils;
       
    var r = {
        "EPSG:4326": [-10, 35, 60, 70]
    };

    var ad = Intergraph.WebSolutions.Core.WebClient.Platform.Common.AxisDirection;

    u.regCRSs([{ id: "EPSG:4326", isGeographic: true, isDefault: true, axesDirections: [ ad.Up, ad.Right ] }]);
            
    u.regState({
        id: "map",
        mapRange: r,
        configuration: {
            mapControlContainerId: mapInfo.getMapControlContainerId("map")
        }
    });

	if (!mapInfo.getMapControlContainerId("preview"))
		return;
		
    u.regState({
        id: "preview",
        mapRange: r,
        configuration: {
            mapControlContainerId: mapInfo.getMapControlContainerId("preview")
        }}, { processMapRanges: false }
    );
});

// Enable handling large prictograms
Sys.Application.add_init(function () {
    if (!Intergraph.WebSolutions.Core.WebClient.Controls.TreeTools) return;
    Intergraph.WebSolutions.Core.WebClient.Controls.TreeTools.PictogramSettings.iframeWidth = 600;
    Intergraph.WebSolutions.Core.WebClient.Controls.TreeTools.PictogramSettings.iframeHeight = 400;
    Intergraph.WebSolutions.Core.WebClient.Controls.TreeTools.PictogramSettings.iconMaxWidth = 24;
    Intergraph.WebSolutions.Core.WebClient.Controls.TreeTools.PictogramSettings.iconMaxHeight = 24;
    Intergraph.WebSolutions.Core.WebClient.Controls.TreeTools.PictogramSettings.handleLargeIcons = true;
});

//HACK: IE11
//IE11 with zoom passes pixels from mouseClick as float
Sys.Application.add_init(function () {
    if ($common) {
        $common.setLocation = function (element, point) {
            Sys.UI.DomElement.setLocation(element, Math.floor(point.x), Math.floor(point.y));
        }
    }
});

// Add CSRF token to ajax requests
Sys.Application.add_init(function () {
    $log.writeVerbose("Setting up the ajaxSend handler");
    $(document).ajaxSend(function (event, jqxhr, settings) {
        if (settings != null && !!theForm["__wc_csrfToken"]) {
            settings.data += settings.data ? "&" : "";
            settings.data += "__wc_csrfToken=" + encodeURIComponent(theForm["__wc_csrfToken"].value);
        }
    });
});

Sys.Application.add_load(function () {
    function fixExtWindows() {
        if (!Ext || !Ext.WindowMgr)
            return;
        Ext.WindowMgr.each(function(extWindow) {
            if (/^mwnt/.test(extWindow.initialConfig.cls) && !extWindow.el.dom.style.display &&
                //hack! there is something wrong if we set display="none" on preview window
                extWindow.initialConfig.cls != "mwnt-preview-map-window")
                extWindow.el.dom.style.display = "none";
        });
    }

    if (!window.chrome)
        return;
    var readyStateCheckInterval = setInterval(function() {
        if (document.readyState === "complete") {
            clearInterval(readyStateCheckInterval);
            fixExtWindows();
        }
    }, 100);
});

//handle Google Maps API errors
Sys.Application.add_init(function () {
    if (window.google && $event) {
        window.gm_authFailure = function () {
            window.googleMapsApiError = true;
            $event.notify("googleMapsApiError", null, this);
        };
    }
});

//handle problem with Ext.Windows rendered outside of bbox (after browser resize)
Sys.Application.add_init(function() {
    if (!Ext) return;
    var originalOnScroll = window.onscroll;
    //block window scrolling (when Ext.Window is bigger then window bbox)
    window.onscroll = function(ev) {
        if (typeof originalOnScroll === 'function') {
            originalOnScroll(ev);
        }
        window.scrollTo(0, 0);
    }

    Ext.onReady(function() {
        var originalInitComponentMethod = Ext.Window.prototype.initComponent;
        var originalResizerActionMethod = Ext.Window.prototype.resizerAction;
        Ext.override(Ext.Window, {
            //override
            initComponent: function() {
                originalInitComponentMethod.call(this);
                var originalOnResize = window.onresize;
                //try to move all Ext.Windows to be displayed inside the window bbox
                window.onresize = Function.createDelegate(this, function(ev) {
                    try {
                        if (typeof originalOnResize === 'function') {
                            originalOnResize(ev);
                        }
                        if (!this.rendered) return;
                        this.savePositionToRestore(true);
                        var newX = this.firstResizeX,
                            newY = this.firstResizeY,
                            width = this.lastSize.width || this.width,
                            height = this.lastSize.height || this.height;
                        if (this.firstResizeX + width >= window.innerWidth) {
                            newX = window.innerWidth - width - 1;
                            if (newX < 0) newX = 0;
                        }
                        if (this.firstResizeY + height >= window.innerHeight) {
                            newY = window.innerHeight - height - 1;
                            if (newY < 0) newY = 0;
                        }
                        this.setPosition(newX, newY);
                        if (this.hidden) { //SR-5297
                            this.hidden = false;
                            this.hide(false);
                        }
                    } catch(ex) {}
                });
            },

            //override
            resizerAction: function() {
                var retVal = originalResizerActionMethod.call(this);
                this.window.savePositionToRestore();
                return retVal;
            },

            savePositionToRestore: function(onlyUndefined) {
                if (!onlyUndefined || typeof this.firstResizeX === "undefined") this.firstResizeX = this.x;
                if (!onlyUndefined || typeof this.firstResizeY === "undefined") this.firstResizeY = this.y;
            }
        });

        var originalEndDragMethod = Ext.Window.DD.prototype.endDrag;
        Ext.override(Ext.Window.DD, {
			//override
            endDrag: function(e) {
                originalEndDragMethod.call(this);
                this.win.savePositionToRestore();
            }
        });
    });
});