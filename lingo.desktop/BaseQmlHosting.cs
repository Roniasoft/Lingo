using lingo.desktop.ViewModels;

namespace lingo.desktop
{
    internal abstract class BaseQmlHosting : IQmlHosting
    {
        public int RunHost(string[] _) => RunHostOverride(_);
        protected void RegisterTypes()
        {
            // TODO: Register your .NET types.
            Qml.Net.Qml.RegisterType<FeedViewModel>("NetViewModels", 1, 0);
            Qml.Net.Qml.RegisterType<ProjectViewModel>("NetViewModels", 1, 0);
            Qml.Net.Qml.RegisterType<NetAppContext>("NetViewModels", 1, 0);
        }

        protected abstract int RunHostOverride(string[] _);

    }
}
