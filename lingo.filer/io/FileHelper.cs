using System.IO;
using System.Text;
using System.Threading.Tasks;

namespace lingo.filer.io
{
    class FileHelper
    {
        public static async Task<string> ReadTextFromFileAsync(string filepath, bool createIfNotExists)
        {
            if (string.IsNullOrWhiteSpace(filepath))
                return null;

            if (!Path.IsPathRooted(filepath))
                return null;

            if (createIfNotExists)
                EnsureFileExists(filepath);

            if (!File.Exists(filepath))
                return null;

            using (var reader = new StreamReader(filepath, Encoding.UTF8))
                return await reader.ReadToEndAsync();
        }

        public static async Task WriteTextToFileOverwriteAsync(string filepath, string serial) => 
            await WriteTextToFileAsync(filepath, false, serial);

        public static async Task WriteTextToFileAsync(string filepath, bool append, string serial)
        {
            EnsureFolderExists(filepath);
            using (var writer = new StreamWriter(filepath, append, Encoding.UTF8))
            {
                writer.AutoFlush = true;
                await writer.WriteAsync(serial);
            }
        }

        public static void EnsureFileExists(string filepath)
        {
            if (!File.Exists(filepath))
                File.Create(filepath);
        }

        public static void EnsureFolderExists(string filepath)
        {
            string dirpath = Path.GetDirectoryName(filepath);
            if (!Directory.Exists(dirpath))
                Directory.CreateDirectory(dirpath);
        }
    }
}
