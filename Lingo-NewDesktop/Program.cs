using Qml.Net;
using Qml.Net.Runtimes;

namespace Lingo
{
public class Program
{
    static int Main(string[] args)
    {
        RuntimeManager.DiscoverOrDownloadSuitableQtRuntime();
		QQuickStyle.SetStyle("Universal");
        using (var app = new QGuiApplication(args))
        {
            using (var engine = new QQmlApplicationEngine())
            {
                // TODO: Register your .NET types.
                // Qml.RegisterType<NetObject>("test");

                engine.SetContextProperty("runningFromQt", false);
                engine.Load("main.qml");
                
                return app.Exec();
            }
        }
    }
}
}
