using System;

namespace lingo.desktop.Model
{
    internal sealed class Project
    {
        public Project(int id)
        {
            Id = id;
            Title = $"Lorem ipsum {Id}";
            Summary = "summary!";
            UpdateTime = new DateTime(2019, 06, 01).AddDays(Id * 3);
        }

        public int Id { get; set;}
        public string Title { get;  set;}
        public bool IsOpen { get;  set;}
        public string Summary { get;  set;}
        public DateTime UpdateTime { get; set; }
    }
}
