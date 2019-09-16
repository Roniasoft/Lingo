using Qml.Net.Runtimes;
using System;
namespace lingo.desktop
{
    public class Program
    {
        static int Main(string[] _)
        {
            var qmlHosting = new ManagedQmlHosting();
            return qmlHosting.RunHost(_);
        }
    }

    
}