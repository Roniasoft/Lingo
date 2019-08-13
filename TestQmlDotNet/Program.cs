using System;
using System.Runtime.InteropServices;
using Qml.Net;
using Qml.Net.Runtimes;

namespace TestQMLNet
{
    class Program
    {
        static int Main(string[] args)
        {
            RuntimeManager.DiscoverOrDownloadSuitableQtRuntime();
            using (QGuiApplication app = new QGuiApplication(args))
            {
                using (var engine = new QQmlApplicationEngine())
                {
                    
                    // Register our new type to be used in Qml
                    //Qml.Net.Qml.RegisterType<QmlType>("test", 1, 1);
                    engine.Load("main.qml");
                    return app.Exec();
                }
            }
        }
    }
}
