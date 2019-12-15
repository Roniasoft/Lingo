using System;
using Qml.Net;
using lingo.desktop.ViewModels;
using System.Collections.Generic;

namespace lingo.desktop.Model
{
    public class Project
    {
        public int Id { get; set; }

        public string LangKey {get; set;}
        public string Title { get; set; }
        public bool IsOpen { get; set; }
        public string Summary { get; set; }
        public DateTime UpdateTime { get; set; }

        public int UntranslatedCounts {get; set;}
        public int DirtyCounts {get; set;}
        public string FilePath {get; set;}
        
        [NotifySignal]
        public List<PhraseViewModel> Phrases { get; set; }


        public void update() {
            this.ActivateSignal("phrasesChanged");
        }

        public Project(int id)
        {
            Id = id;
            Title = $"Lorem ipsum {Id}";
            Summary = "summary!";
            UpdateTime = DateTime.Now;
            Phrases = new List<PhraseViewModel>();
            UntranslatedCounts = 0;
        }
    }
}
