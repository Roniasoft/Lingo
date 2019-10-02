using Newtonsoft.Json;
using System;

namespace lingo.filer.io
{
    public abstract class JsonSerializable<TObject> where TObject : class, new()
    {
        public static (TObject JsonObject, string Error) Deserialize(string serial)
        {
            if (string.IsNullOrWhiteSpace(serial))
                return (null, "JSON is empty");

            TObject value = new TObject();
            try
            {
                JsonConvert.PopulateObject(serial, value);
                return (value, null);
            }
            catch (Exception e) { return (null, e.ToString()); }
        }

        public string Serialize() => JsonConvert.SerializeObject(this);
    }
}
