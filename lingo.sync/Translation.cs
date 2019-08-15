using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;

namespace lingo.sync
{
    public static class Translation
    {
        public static IEnumerable<AppString> IterAppStrings(XElement root) =>
            root.IterChildNodes()
            .Where(e => e.Name == "data")
            .Select(e => new AppString(e))
            .Where(e => e.IsValid);

        public static Dictionary<string, AppString> GetAppStringDict(XDocument doc)
        {
            var appStrings = new Dictionary<string, AppString>();
            foreach (var appString in IterAppStrings(doc.Root))
                if (appStrings.ContainsKey(appString.Name) == false)
                    appStrings[appString.Name] = appString;

            return appStrings;
        }

        public static void SyncWorkingFromAuthoritive(
            XDocument workingDoc, XDocument authoritiveDoc)
        {
            var workingAppStrings = GetAppStringDict(workingDoc);
            foreach (var authoritiveAppString in IterAppStrings(authoritiveDoc.Root))
                if (workingAppStrings.TryGetValue(authoritiveAppString.Name, out var workingAppString))
                {
                    // If the original english has changed in the authoritive doc, mark
                    // the working string dirty
                    if (authoritiveAppString.HasEnglishValue &&
                        workingAppString.EnglishValue != authoritiveAppString.EnglishValue)
                        workingAppString.IsDirty = true;

                    // Always set the english value - this forces the creation of the
                    // english value element
                    workingAppString.EnglishValue = authoritiveAppString.EnglishValue;
                }

                // Exists in authoritive doc but not working doc. Add it now
                else
                    workingDoc.Root.Add(
                        (workingAppStrings[authoritiveAppString.Name] = AppString.Create(authoritiveAppString))
                        .Element);

            var authoritiveAppStrings = GetAppStringDict(authoritiveDoc);
            var workingStringsToRemove = new List<AppString>();
            foreach (var workingAppString in workingAppStrings.Values)
                if (authoritiveAppStrings.ContainsKey(workingAppString.Name) == false)

                    // Exists in working doc but not authoritive doc. Mark it to be removed
                    workingStringsToRemove.Add(workingAppString);

            // Remove the elements to be removed
            foreach (var appString in workingStringsToRemove)
            {
                var workingAppString = workingAppStrings[appString.Name];
                workingAppString.Element.Remove();
                workingAppStrings.Remove(appString.Name);
            }
        }

        public static void SyncAuthoritiveFromWorking(
            XDocument workingDoc, XDocument authoritiveDoc)
        {
            var authoritiveAppStrings = GetAppStringDict(authoritiveDoc);
            foreach (var workingAppString in IterAppStrings(workingDoc.Root))
            {
                if (workingAppString.IsDirty == false &&
                    authoritiveAppStrings.TryGetValue(workingAppString.Name, out var authoritiveAppString))
                    if (workingAppString.HasEnglishValue &&
                        workingAppString.EnglishValue == authoritiveAppString.EnglishValue)
                    {
                        authoritiveAppString.Value = workingAppString.Value;
                        authoritiveAppString.IsDirty = false;
                    }
            }
        }

        public static void Sync(XDocument workingDoc, XDocument authoritiveDoc)
        {
            // Update the working document with new strings from the authoritive document
            SyncWorkingFromAuthoritive(workingDoc, authoritiveDoc);

            // Update the authoritive document with translated strings
            SyncAuthoritiveFromWorking(workingDoc, authoritiveDoc);
        }
    }
}
