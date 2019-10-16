using System.Collections.Generic;

namespace lingo.filer
{
    public interface ILingoFilerConfig
    {
        string BaseLanguageKey { get; set; }
        List<ResourceFile> ResourceFiles { get; set; }
    }
}
