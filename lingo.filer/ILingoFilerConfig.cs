using System.Collections.Generic;

namespace lingo.filer
{
    interface ILingoFilerConfig
    {
        string BaseLanguageKey { get; set; }
        List<ResourceFile> ResourceFiles { get; set; }
    }
}
