using lingo.common;

namespace lingo.filer
{
    public class LingoLanguage : ILingoLanguage
    {
        public string Key { get; }
        public string Name { get; }

        public LingoLanguage(string key, string name)
        {
            Key = key;
            Name = name;
        }

        public bool Equals(ILingoLanguage other) =>
            Key == other.Key;

        public override bool Equals(object obj) =>
            obj is ILingoLanguage ll ? Equals(ll) : false;

        public override int GetHashCode() =>
            typeof(ILingoLanguage).GetHashCode() + Key.GetHashCode();
    }
}
