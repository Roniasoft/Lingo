using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Windows.Forms;
using System.Xml.Linq;

namespace lingo
{
    sealed class ResourceFileEditor : Form
    {
        static IEnumerable<AppString> _iterAppStrings(XElement root) =>
            root.IterChildNodes()
            .Where(e => e.Name == "data")
            .Select(e => new AppString(e))
            .Where(e => e.IsValid);

        readonly MenuStrip _menuStrip = new MenuStrip { Dock = DockStyle.Top };
        readonly DataGridView _dataGrid = new DataGridView { Dock = DockStyle.Fill };
        readonly ToolStripMenuItem _hideItem = new ToolStripMenuItem("Hide Completed");

        public ResourceFileEditor()
        {
            var openItem = new ToolStripMenuItem("Open File");
            openItem.Click += _openFile;
            //var fileMenu = new ToolStripMenuItem("File");
            //fileMenu.DropDownItems.Add(openItem);
            //fileMenu.DropDownItems.Add(_hideItem);
            //_menuStrip.Items.Add(fileMenu);
            _menuStrip.Items.Add(openItem);
            _menuStrip.Items.Add(_hideItem);

            _hideItem.Click += (o, e) =>
            {
                _hideItem.Invalidate();

                // This currency manager code was taken from this SO post:
                // https://stackoverflow.com/a/18942430
                var curManager = (CurrencyManager)BindingContext[_dataGrid.DataSource];
                curManager.SuspendBinding();

                var shouldHide = _hideItem.Checked = !_hideItem.Checked;
                for (var n = 0; n < _entries.Length; n++)
                    _dataGrid.Rows[n].Visible = shouldHide ? !_entries[n].Complete : true;

                curManager.ResumeBinding();
            };

            MainMenuStrip = _menuStrip;
            Controls.Add(_dataGrid);
            Controls.Add(_menuStrip);

            _dataGrid.CellFormatting += _formatCell;
            _dataGrid.EditingControlShowing += _editControlShowing;
            //_dataGrid.ColumnHeaderMouseClick += _columnHeaderMouseClick;
            _dataGrid.CurrentCellDirtyStateChanged += (o, e) =>
            {
                var dg = (DataGridView)o;
                if (dg.CurrentCell is DataGridViewCheckBoxCell)
                    dg.EndEdit();
            };

            Size = new Size(1024, 768);
            WindowState = FormWindowState.Maximized;
            //LoadDocument(@"C:\Users\macaronikazoo\Dropbox\code\paradigm\paradigm\l10n\DisplayText.es.resx");
        }

        void _editControlShowing(object sender, DataGridViewEditingControlShowingEventArgs e)
        {
            if (e.Control is TextBox textBox)
            {
                textBox.AutoCompleteMode = AutoCompleteMode.Suggest;
                textBox.AutoCompleteSource = AutoCompleteSource.RecentlyUsedList;
                textBox.ShortcutsEnabled = true;
            }
        }

        void _formatCell(object sender, DataGridViewCellFormattingEventArgs e)
        {
            var entry = _entries[e.RowIndex];
            if (entry.Complete)
            {
                e.CellStyle.ForeColor = Color.Gray;
                e.CellStyle.BackColor = Color.White;
            }
            else
            {
                e.CellStyle.ForeColor = Color.Black;
                e.CellStyle.BackColor = Color.LightYellow;
            }
        }

        void _openFile(object sender, EventArgs e)
        {
            var dlg = new OpenFileDialog { CheckFileExists = true, Filter = "Language Files|*.resx" };
            if (dlg.ShowDialog() == DialogResult.OK)
                LoadDocument(dlg.FileName);
        }

        string _filepath;
        XDocument _doc;
        EntryViewModel[] _entries;
        public void LoadDocument(string filepath)
        {
            if (File.Exists(filepath) == false)
                return;

            _filepath = filepath;
            _doc = new XDocument(XDocument.Load(filepath));
            _entries = _iterAppStrings(_doc.Root)
                .Select(a => new EntryViewModel(a, _changedCallback))
                .ToArray();
            var bindingList = new BindingList<EntryViewModel>(_entries);
            var bindingSource = new BindingSource { DataSource = bindingList };
            _dataGrid.DataSource = bindingSource;

            _dataGrid.DefaultCellStyle.WrapMode = DataGridViewTriState.True;
            _dataGrid.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells;
            var cols = _dataGrid.Columns.Cast<DataGridViewColumn>();
            foreach (var col in cols.Where(c => c.Name == nameof(EntryViewModel.Name)))
                col.AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            foreach (var col in cols.Where(c => c.Name == nameof(EntryViewModel.English)))
                col.AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            foreach (var col in cols.Where(c => c.Name == nameof(EntryViewModel.Translation)))
                col.AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            foreach (var col in cols.Where(c => c.Name == nameof(EntryViewModel.Comment)))
                col.Width = 300;
            _dataGrid.AutoResizeRows(DataGridViewAutoSizeRowsMode.AllCells);

            // Figure out the language
            //var toks = Path.GetFileName(filepath).Split('.');
            //var lang = toks.Length >= 3 ?
            //    toks[toks.Length - 2] :
            //    "en";
            //var inputLang = InputLanguage.FromCulture(new CultureInfo(lang));
            //if (inputLang != null)
            //    Application.CurrentInputLanguage = inputLang;
        }

        void _changedCallback()
        {
            _doc?.Save(_filepath);
            _dataGrid.Refresh();
        }

        void _columnHeaderMouseClick(object sender, DataGridViewCellMouseEventArgs e)
        {
            var direction = _dataGrid.SortOrder == SortOrder.Ascending ?
                ListSortDirection.Descending :
                ListSortDirection.Ascending;
            _dataGrid.Sort(_dataGrid.Columns[e.ColumnIndex], direction);
        }
    }
}
