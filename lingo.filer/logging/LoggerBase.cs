using System;

namespace lingo.filer.logging
{
    public abstract class LoggerBase : ILog
    {
        public event EventHandler<LogEvent> EventLogged;
        protected void _fireEventLogged(LogEvent logEvent) =>
            EventLogged?.Invoke(this, logEvent);

        string _getMessage(string msg, Exception e) => $"{msg} : {e.ToString()}";

        public abstract void SetEventThreshold(Level minLevel);
        public abstract void Debug(string message);
        public abstract void Info(string message);
        public abstract void Warn(string message);
        public abstract void Error(string message);

        public void Debug(Exception e) => Debug(e.ToString());
        public void Debug(string msg, Exception e) => Debug(_getMessage(msg, e));
        public void DebugFormat(string msg, params object[] args) => Debug(string.Format(msg, args));

        public void InfoFormat(string msg, params object[] args) => Info(string.Format(msg, args));

        public void Warn(string msg, Exception e) => Warn(_getMessage(msg, e));
        public void WarnFormat(string msg, params object[] args) => Warn(string.Format(msg, args));

        public void Error(Exception e) => Error(e.ToString());
        public void Error(string msg, Exception e) => Error(_getMessage(msg, e));
        public void ErrorFormat(string msg, params object[] args) => Error(string.Format(msg, args));
        public void ErrorRecurse(string msg, Exception e)
        {
            Error(msg, e);
            while ((e = e.InnerException) != null)
                Error($"innerX: {msg}", e);
        }
    }
}
