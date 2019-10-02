using System.Collections.Generic;
using System.Threading.Tasks;

namespace lingo.common
{
    public interface ILingoDataService
    {
        /// <summary>
        /// Iterates the available groups. These might be files
        /// </summary>
        /// <returns></returns>
        IEnumerable<ILingoGroup> IterAvailableGroups();

        /// <summary>
        /// Fetches new base-phrases from server, merges any updates, dirties any existing phrases, and pushes new local translations to the server.
        /// If any base phrases have changed since before then those translations will be marked as dirty.
        /// After merging, translations get published to server.
        /// </summary>
        Task<(bool Success, string Message)> SyncDataAsync();
    }
}
