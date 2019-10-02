using System.Diagnostics;

namespace lingo.filer.logging.traceLogger
{
    sealed class TraceLogger : LoggerBase
    {
        const int ID = 1;

        readonly TraceSource _log;
        public TraceLogger(string name)
        {
            _log = new TraceSource(name, SourceLevels.Verbose);
            _log.Listeners.Clear();
            _log.Listeners.AddRange(Trace.Listeners);
            _threshhold = Level.Debug;
        }

        void _write(TraceEventType traceLevel, string msg)
        {
            try
            {
                _log.TraceEvent(traceLevel, ID, msg);
                var level = FromTraceLevel(traceLevel);
                if (LogEvent.MeetsThreshold(level, _threshhold))
                    _fireEventLogged(LogEvent.FromLevel(level, msg));
            }
            catch { }
        }

        Level _threshhold;
        public override void SetEventThreshold(Level minLevel) => _threshhold = minLevel;
        public override void Debug(string msg) => _write(TraceEventType.Verbose, msg);
        public override void Info(string msg) => _write(TraceEventType.Information, msg);
        public override void Warn(string msg) => _write(TraceEventType.Warning, msg);
        public override void Error(string msg) => _write(TraceEventType.Error, msg);

        public static Level FromTraceLevel(TraceEventType level)
        {
            if (level >= TraceEventType.Verbose)
                return Level.Debug;
            if (level >= TraceEventType.Information)
                return Level.Info;
            if (level >= TraceEventType.Warning)
                return Level.Warn;
            return Level.Error;
        }
    }
}
