using System.Web.UI;
using AjaxControlToolkit;

[assembly: WebResource("Application.ScriptResources.ScriptTranslate.js", "text/javascript")]
[assembly: ScriptResource("Application.ScriptResources.ScriptTranslate.js",
    "Application.ScriptResources.ScriptTranslate",
    "Application.Translate")]

namespace Application.ScriptResources
{
    [ClientScriptResource(null, "Application.ScriptResources.ScriptTranslate.js")]
    internal static class ScriptTranslate
    {

    }
}