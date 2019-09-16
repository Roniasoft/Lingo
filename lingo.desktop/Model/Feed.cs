using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using lingo.common;
using lingo.rsync.mock;

namespace lingo.desktop.Model
{
    internal sealed class Feed
    {
        private readonly List<Project> projects;
        public Feed()
        {
            projects = new List<Project>();
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
                projects.Add(groupItem);

            }
        }

        public IEnumerable<Project> Projects => projects;
    }
}
