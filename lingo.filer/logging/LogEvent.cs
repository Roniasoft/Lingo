using System;

namespace lingo.filer.logging
{
    public enum Level
    {
        Debug,
        Info,
        Warn,
        Error
    }

    public sealed class LogEvent
    {
        public static bool MeetsThreshold(Level level, Level threshold) => level >= threshold;
        public bool MeetsThreshold(Level threshold) => MeetsThreshold(Level, threshold);

        public Level Level { get; }
        public string Message { get; }
        public DateTime Timestamp { get; }
        LogEvent(Level level, string message, DateTime time)
        {
            Level = level;
            Message = message;
            Timestamp = time;
        }

        public static LogEvent Debug(string msg, DateTime time) => new LogEvent(Level.Debug, msg, time);
        public static LogEvent Info(string msg, DateTime time) => new LogEvent(Level.Info, msg, time);
        public static LogEvent Warn(string msg, DateTime time) => new LogEvent(Level.Warn, msg, time);
        public static LogEvent Error(string msg, DateTime time) => new LogEvent(Level.Error, msg, time);
        public static LogEvent FromLevel(Level level, string msg, DateTime? time = null)
        {
            switch (level)
            {
                case Level.Info:
                    return Info(msg, time ?? DateTime.Now);
                case Level.Warn:
                    return Warn(msg, time ?? DateTime.Now);
                case Level.Error:
                    return Error(msg, time ?? DateTime.Now);
                case Level.Debug:
                default:
                    return Debug(msg, time ?? DateTime.Now);
            }
        }


        public override string ToString() => $"{Timestamp.ToString("yyyy/MMM/DD HH:mm:ss")} {Level}: {Message}";
    }
}
