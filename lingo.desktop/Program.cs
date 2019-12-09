using Qml.Net.Runtimes;
using System;
namespace lingo.desktop
{
    public class Program
    {
        [STAThread]
        static int Main(string[] _)
        {
            var qmlHosting = new ManagedQmlHosting();
            return qmlHosting.RunHost(_);
        }
    }
}