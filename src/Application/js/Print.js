var page = require('webpage').create(),
    system = require('system'),
    fs = require('fs'),
    address, w, h, postData, log,
    postDataFileName, headersFileName, snapshotFileName, enableVerboseLogger,
    renderCheckLoopcounter = 0;
    
log = function(s) {
    console.log(s);
    if (snapshotFileName && enableVerboseLogger)
        fs.write("partial-" + snapshotFileName + "-log.txt", s + '\n', 'a');
}

log('Args:');
system.args.forEach(function (arg, i) {
    log(i + ': ' + arg);
});

function debugPage() {
  console.log("Refresh a second debugger-port page and open a second webkit inspector for the target page.");
  console.log("Letting this page continue will then trigger a break in the target page.");
  debugger; // pause here in first web browser tab for steps 5 & 6
  page.evaluateAsync(function() {
    debugger; // step 7 will wait here in the second web browser tab
  });
}

if (system.args.length !== 8) {
    log('Wrong usage.');
    phantom.exit(1);
} else {

    address = system.args[1];
    w = parseInt(system.args[2], 10);
    h = parseInt(system.args[3], 10);
    postDataFileName = system.args[4];
    headersFileName = system.args[5];
    snapshotFileName = system.args[6];
    enableVerboseLogger = parseInt(system.args[7]);

    log("address: " + address + "\n" +
        "w: " + w + "\n" +
        "h: " + h + "\n" +
        "postDataFileName: " + postDataFileName + "\n" +
        "headersFileName: " + headersFileName + "\n" +
        "snapshotFileName: " + snapshotFileName + "\n");

    page.viewportSize = { width: w, height: h };

    postData = fs.read(postDataFileName);
    page.customHeaders = JSON.parse(fs.read(headersFileName));

    page.onConsoleMessage = function(msg) {
      log('Internal SnapshotPage console message: ' + msg);
    };
    page.onError = function(msg, trace) {

        var msgStack = ['ERROR fro Page: ' + msg];

        if (trace && trace.length) {
          msgStack.push('TRACE:');
          trace.forEach(function(t) {
            msgStack.push(' -> ' + t.file + ': ' + t.line + (t["function"] ? ' (in function "' + t["function"] +'")' : ''));
          });
        }

        log(msgStack.join('\n'));

    };
    page.onResourceError = function(resourceError) {
        log('Unable to load resource (#' + resourceError.id + 'URL:' + resourceError.url + ')');
        log('Error code: ' + resourceError.errorCode + '. Description: ' + resourceError.errorString);
    };

    startTime = new Date().getTime() / 1000;
    log('Opening the page.');

    if (enableVerboseLogger) {
        var counter = 0;
        window.setInterval(function () {
            page.render("partial-outer-" + snapshotFileName + "-" + (counter++).toLocaleString("en", { minimumIntegerDigits: 4 }) + ".png" );
        }, 2000);
    }

    page.open(address, 'POST', postData, function (status) {
        log('Open finished.');
        if (status !== 'success') {
            log('Unable to load the address!');
            page.render("error-" + snapshotFileName);
            phantom.exit();
        } else {
            page.evaluate(function() {
                document.body.bgColor = 'white';
            });
            window.setInterval(function () {
                var dat = page.evaluate(function() {
                    var evs = window.printingEvents;
                    window.printingEvents = [];
                    return { rendered: window.printingReady, events: evs };
                });
                var rendered = dat.rendered;
                log("Rendered: "+rendered+". Loop num: " + ++renderCheckLoopcounter + " Events: " ); 
                dat.events.forEach(function (arg, i) {
                    log("    " + i + ":  " + arg);
                });
                if (enableVerboseLogger)
                    page.render("partial-" + snapshotFileName);
                if (!rendered)
                    return;

                page.render(snapshotFileName);
                renderEndTime = new Date().getTime() / 1000;
                log("Rendered. Rendering time: " + (renderEndTime - startTime) + "s" ); 
                phantom.exit();
            }, 2000);
        }
    });

    //debugPage();
}
