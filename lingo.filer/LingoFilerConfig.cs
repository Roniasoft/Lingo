using lingo.filer.io;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;

namespace lingo.filer
{
    public class LingoFilerConfig : JsonSerializable<LingoFilerConfig>, ILingoFilerConfig
    {
        public string BaseLanguageKey { get; set; } = "en";
        public List<ResourceFile> ResourceFiles { get; set; }

        /// <summary>
        /// A friendly name is extracted from fileName. The file name is 
        /// splitted from the capital letters using a regexp pattern.
        /// </summary>
        /// <param name="name">File name</param>
        /// <returns>A friendly name version of the file name.</returns>
        public string ExtractFriendlyName(string name)
        {
            string[] words = Regex.Matches(name, "(^[a-z]+|[A-Z]+(?![a-z])|[A-Z][a-z]+)")
                .OfType<Match>()
                .Select(m => m.Value).ToArray();
            string result = string.Join(" ", words);
            return result;
        }

        public LingoFilerConfig()
        {
            var rootPath = Path.GetDirectoryName(typeof(LingoFilerConfig).Assembly.Location);
            var files = Directory.GetFiles(rootPath, "*.resx", SearchOption.AllDirectories);

            ResourceFiles = new List<ResourceFile>();
            foreach (var file in files)
            {
                var fileName = Path.GetFileName(file);
                var friendlyName = ExtractFriendlyName(fileName);
                ResourceFiles.Add(new ResourceFile(file, friendlyName));
            }
        }
    }

    public class ResourceFile
    {
        public ResourceFile(string filename, string friendlyName)
        {
            Filename = filename;
            FriendlyName = friendlyName;
        }
        public ResourceFile()
        {

        }
        public string Filename { get; set; }
        public string FriendlyName { get; set; }
    }
}
