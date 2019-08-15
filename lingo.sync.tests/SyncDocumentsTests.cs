using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Linq;
using System.Reflection;
using System.Xml.Linq;

namespace lingo.sync.tests
{
    [TestClass]
    public class SyncDocumentsTests
    {
        XDocument authoritiveDoc;
        XDocument workingDoc;

        [TestInitialize]
        public void Setup()
        {
            var assembly = Assembly.GetExecutingAssembly();
            using (var authoritiveStream = assembly.GetManifestResourceStream("lingo.sync.tests.testAuthoritiveDoc.xml"))
                authoritiveDoc = XDocument.Load(authoritiveStream);

            using (var workingStream = assembly.GetManifestResourceStream("lingo.sync.tests.testWorkingDoc.xml"))
                workingDoc = XDocument.Load(workingStream);
        }

        [TestMethod]
        public void SyncFromAuth()
        {
            var strs = Translation.IterAppStrings(workingDoc.Root).ToArray();
            Assert.AreEqual(strs.Length, 8);
            Assert.AreEqual(strs[0].Name, "AnnotationNode");
            Assert.AreEqual(strs[1].Name, "NodeAttributeStore");
            Assert.AreEqual(strs[2].Name, "BlastDagNode");
            Assert.AreEqual(strs[3].Name, "PercentageLengthRule");
            Assert.AreEqual(strs[4].Name, "PreferencesNode");
            Assert.AreEqual(strs[5].Name, "PrintPreferencesNode");
            Assert.AreEqual(strs[6].Name, "DeletedFromAuth");
            Assert.AreEqual(strs[7].Name, "AnotherDeletedFromAuth");
            Translation.SyncWorkingFromAuthoritive(workingDoc, authoritiveDoc);

            strs = Translation.IterAppStrings(workingDoc.Root).ToArray();
            Assert.AreEqual(strs.Length, 7);
            Assert.AreEqual(strs[0].Name, "AnnotationNode");
            Assert.AreEqual(strs[1].Name, "NodeAttributeStore");
            Assert.AreEqual(strs[2].Name, "BlastDagNode");
            Assert.AreEqual(strs[3].Name, "PercentageLengthRule");
            Assert.AreEqual(strs[4].Name, "PreferencesNode");
            Assert.AreEqual(strs[5].Name, "BlastPolygonNode");
            Assert.AreEqual(strs[6].Name, "SnapshotNode");

            Assert.AreEqual(strs[0].Value, "translated");
            Assert.AreEqual(strs[1].Value, "translated");
            Assert.AreEqual(strs[2].Value, "translated");
            Assert.AreEqual(strs[3].Value, "translated");
            Assert.AreEqual(strs[4].Value, "random");
            Assert.AreEqual(strs[5].Value, "original");
            Assert.AreEqual(strs[6].Value, "original");

            Assert.AreEqual(strs[0].IsDirty, false);
            Assert.AreEqual(strs[1].IsDirty, true); // Dirty as the auth doc has altered the english string so the translation is invalid
            Assert.AreEqual(strs[2].IsDirty, false);
            Assert.AreEqual(strs[3].IsDirty, true); // ''
            Assert.AreEqual(strs[4].IsDirty, true); // ''
            Assert.AreEqual(strs[5].IsDirty, true); // Dirty as it is a new string
            Assert.AreEqual(strs[6].IsDirty, true); // ''

            Assert.AreEqual(strs[0].EnglishValue, "Annotation");
            Assert.AreEqual(strs[1].EnglishValue, "Attribute Store");
            Assert.AreEqual(strs[2].EnglishValue, "Blast Dag");
            Assert.AreEqual(strs[3].EnglishValue, "Perc. Length");
            Assert.AreEqual(strs[4].EnglishValue, "Prefs");
            Assert.AreEqual(strs[5].EnglishValue, "Blast Polygon");
            Assert.AreEqual(strs[6].EnglishValue, "Snapshot");
        }

        [TestMethod]
        public void SyncBoth()
        {
            Translation.SyncWorkingFromAuthoritive(workingDoc, authoritiveDoc);
            Translation.SyncAuthoritiveFromWorking(workingDoc, authoritiveDoc);

            var strs = Translation.IterAppStrings(authoritiveDoc.Root).ToArray();
            Assert.AreEqual(strs.Length, 7);
            Assert.AreEqual(strs[0].Name, "AnnotationNode");
            Assert.AreEqual(strs[1].Name, "NodeAttributeStore");
            Assert.AreEqual(strs[2].Name, "BlastDagNode");
            Assert.AreEqual(strs[3].Name, "BlastPolygonNode");
            Assert.AreEqual(strs[4].Name, "PercentageLengthRule");
            Assert.AreEqual(strs[5].Name, "PreferencesNode");
            Assert.AreEqual(strs[6].Name, "SnapshotNode");

            Assert.AreEqual(strs[0].Value, "translated");
            Assert.AreEqual(strs[1].Value, "original"); // Not updated because the working doc translation was dirty
            Assert.AreEqual(strs[2].Value, "translated");
            Assert.AreEqual(strs[3].Value, "original"); // ''
            Assert.AreEqual(strs[4].Value, "original"); // ''
            Assert.AreEqual(strs[5].Value, "original"); // ''
            Assert.AreEqual(strs[6].Value, "original"); // ''

            Assert.AreEqual(strs[0].IsDirty, false);
            Assert.AreEqual(strs[1].IsDirty, false);
            Assert.AreEqual(strs[2].IsDirty, false);
            Assert.AreEqual(strs[3].IsDirty, false);
            Assert.AreEqual(strs[4].IsDirty, true);
            Assert.AreEqual(strs[5].IsDirty, true);
            Assert.AreEqual(strs[6].IsDirty, false);
        }
    }
}
