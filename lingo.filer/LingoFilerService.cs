using lingo.common;
using lingo.filer.logging;
using lingo.filer.logging.traceLogger;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace lingo.filer
{
    public class LingoFilerService : ILingoDataService
    {
        public event EventHandler SyncDataRequested;

        public LingoLanguage BaseLanguage { get; }

        readonly List<LingoGroupFile> _files = new List<LingoGroupFile>();

        static readonly ILog _log;
        static LingoFilerService() => _log = new TraceLogger("lingo.filer");

        internal LingoFilerService(ILingoFilerConfig filerConfig)
        {
            // Read the base language from the config
            BaseLanguage = LingoLanguages.GetLanguageFromKey(filerConfig.BaseLanguageKey);

            // Read the groups/files from the config
            var oneSuccess = false;
            foreach (var rf in filerConfig.ResourceFiles)
            {
                var parseResult = LingoGroupFile.ParseFromFile(rf.Filename, rf.FriendlyName);
                if (parseResult.Group == null)
                {
                    _log.Warn($"Error opening resource file from config: {parseResult.Error}");
                    continue;
                }
                _addGroup(parseResult.Group);
                oneSuccess = true;
            }
            if (!oneSuccess)
                throw new InvalidOperationException("No resource files in the configuration were loaded");
        }

        void _addGroup(LingoGroupFile group)
        {
            _files.Add(group);
            group.DataModified += _dataModified;
        }

        void _dataModified(object sender, string message)
        {
            _log.Info(message);

            // TODO: Mark sync status as dirty
            // TODO: save the file that was modified
        }

        public IEnumerable<ILingoGroup> IterAvailableGroups() => _files;

        public Task<(bool Success, string Message)> SyncDataAsync()
        {
            // No data to fetch because this is a local file version
            // Perhaps open windows to the data locations and tell user to email them to us?
            SyncDataRequested?.Invoke(this, null);
            return Task.FromResult((true, (string)null));
        }

        public static (LingoFilerService Service, string Error) LoadFromConfigFile(string lingoFilerConfigFilepath)
        {
            // Read the config from the file
            var configResult = LingoFilerConfig.Deserialize(lingoFilerConfigFilepath);
            if (configResult.JsonObject == null)
            {
                _log.Error(configResult.Error);
                return (null, configResult.Error);
            }

            try
            {
                // Create the service from the config file
                var config = configResult.JsonObject;
                return (new LingoFilerService(config), null);
            }
            catch (Exception e) { return (null, e.ToString()); }
        }
    }
}
