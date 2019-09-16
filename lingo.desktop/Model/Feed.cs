using lingo.rsync.mock;
using System.Collections.Generic;

namespace lingo.desktop.Model
{
    internal sealed class Feed
    {
        public IEnumerable<Project> Projects => _projects;

        readonly List<Project> _projects;
        public Feed()
        {
            _projects = new List<Project>();
            var mock = new LingoDataServiceRsyncMock(true, 0);
            IEnumerable<(string groupKey, string groupName)> availableGroups;
            availableGroups = mock.IterAvailableGroups();
            int id = 0;
            foreach (var item in availableGroups)
            {
                Project groupItem = new Project(id++);
                groupItem.Id = id++;
                groupItem.Title = item.groupName;
                groupItem.Summary = item.groupName;
                groupItem.IsOpen = false;
                _projects.Add(groupItem);

            }
        }
    }
}
