using System.Collections.Generic;
using System.IO;

namespace lingo.filer.tests
{
    public class ExampleConfig : ILingoFilerConfig
    {
        public string BaseLanguageKey { get; set; } = "en";
        public List<ResourceFile> ResourceFiles { get; set; }

        public ExampleConfig()
        {
            var rootPath = Path.GetDirectoryName(typeof(ExampleConfig).Assembly.Location);
            ResourceFiles = new List<ResourceFile>
            {
                new ResourceFile
                {
                    Filename = Path.Combine(rootPath, "DisplayNames.es.resx"),
                    FriendlyName = "Display Names",
                },
                new ResourceFile
                {
                    Filename = Path.Combine(rootPath, "DisplayNames.ru.resx"),
                    FriendlyName = "Display Names",
                },
                new ResourceFile
                {
                    Filename = Path.Combine(rootPath, "Descriptions.es.resx"),
                    FriendlyName = "Descriptions",
                },
                new ResourceFile
                {
                    Filename = Path.Combine(rootPath, "Descriptions.ru.resx"),
                    FriendlyName = "Descriptions",
                },
            };
        }
    }
}
