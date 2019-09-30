using lingo.desktop.Model;
using lingo.desktop.ViewModels;
using System;
namespace lingo.desktop
{
    public class NetAppContext
    {
        private readonly FeedViewModel feedViewModel;

        public NetAppContext()
        {
            feedViewModel = new FeedViewModel(new Feed());
        }

        public FeedViewModel GetFeedViewModel() => feedViewModel;

        public void Log(string val) {
            Console.WriteLine(val);
        }
    }
}
