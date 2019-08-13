#include "applicationwindowplugin_plugin.h"
#include "framelessappwindow.h"

#include <qqml.h>

void ApplicationWindowPluginPlugin::registerTypes(const char *uri)
{
    // @uri com.mycompany.qmlcomponents
    Q_ASSERT(uri == QLatin1String("FramelessWindow"));
    qmlRegisterType<FramelessAppWindow>(uri, 1, 0, "FramelessAppWindow");
}

