using System;

namespace lingo.common
{
    /// <summary>
    /// An interface to represent a Language used in Lingo. This allows the implementation to store extra details
    /// in its implementation that might not be relevant to third party consumers of this interface
    /// </summary>
    public interface ILingoLanguage : IEquatable<ILingoLanguage>
    {
        /// <summary>
        /// The language key, e.g. "en" for English, "es" for Spanish, "ru" for Russian
        /// </summary>
        string Key { get; }

        /// <summary>
        /// The language friendly name, i.e. "Español (Spanish)", or "pусская (Russian)"
        /// </summary>
        string Name { get; }
    }
}
