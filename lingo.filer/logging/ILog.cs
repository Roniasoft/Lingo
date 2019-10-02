using System;

namespace lingo.filer.logging
{
    public interface ILog
    {
        event EventHandler<LogEvent> EventLogged;
        void SetEventThreshold(Level minLevel);

        void Debug(string message);
        void Debug(Exception e);
        void Debug(string message, Exception e);
        void DebugFormat(string message, params object[] args);

        void Info(string message);
        void InfoFormat(string msg, params object[] args);

        void Warn(string message);
        void Warn(string message, Exception e);
        void WarnFormat(string message, params object[] args);

        void Error(string message);
        void ErrorFormat(string message, params object[] args);
        void Error(Exception e);
        void Error(string message, Exception e);
        void ErrorRecurse(string message, Exception e);
    }
}
