using System;
using System.Threading.Tasks;

namespace lingo.filer.io
{
    abstract class JsonFile<TObject> : JsonSerializable<TObject>
        where TObject : class, new()
    {
        public static async Task<(TObject JsonObject, string Error)> LoadFromFileAsync(string filename, bool createIfNotExists)
        {
            if (string.IsNullOrWhiteSpace(filename))
                return (null, "Filename is invalid");
            try
            {
                string text = await FileHelper.ReadTextFromFileAsync(filename, createIfNotExists);
                if (string.IsNullOrWhiteSpace(text))
                    return (null, "JSON is empty");
                return Deserialize(text);
            }
            catch (Exception e) { return (null, e.ToString()); }
        }

        public async Task WriteToFile_OverwriteAsync(string filename) =>
            await FileHelper.WriteTextToFileOverwriteAsync(filename, this.Serialize());
    }
}
