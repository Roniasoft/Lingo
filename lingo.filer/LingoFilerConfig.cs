using lingo.filer.io;
using System.Collections.Generic;

namespace lingo.filer
{
    public class LingoFilerConfig : JsonSerializable<LingoFilerConfig>, ILingoFilerConfig
    {
        public string BaseLanguageKey { get; set; }
        public List<ResourceFile> ResourceFiles { get; set; }
    }

    public class ResourceFile
    {
        public string Filename { get; set; }
        public string FriendlyName { get; set; }
    }
}
