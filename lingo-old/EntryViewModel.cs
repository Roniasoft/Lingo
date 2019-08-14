using System;
using System.ComponentModel;

namespace lingo
{
    sealed class EntryViewModel : INotifyPropertyChanged
    {
        readonly AppString _appString;
        readonly Action _changeCallback;

        public string Name => _appString?.Name;

        public string English => _appString?.EnglishValue ?? string.Empty;

        public string Translation
        {
            get => _appString?.Value ?? string.Empty;
            set
            {
                if (_appString.Value == value)
                    return;
                _appString.Value = value;
                _onPropertyChanged(nameof(Translation));
            }
        }

        public string Comment => _appString?.Comment ?? string.Empty;

        //[Browsable(false)]
        public bool Complete
        {
            get => !_appString.IsDirty;
            set
            {
                if (_appString.IsDirty == !value)
                    return;
                _appString.IsDirty = !value;
                _onPropertyChanged(nameof(Complete));
            }
        }

        public event PropertyChangedEventHandler PropertyChanged;

        public EntryViewModel(AppString appString, Action changeCallback = null)
        {
            _appString = appString;
            _changeCallback = changeCallback;
        }

        void _onPropertyChanged(string propertyName)
        {
            _changeCallback?.Invoke();
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
