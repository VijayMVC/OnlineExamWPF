using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace CollegeExam.Resources.UserControls.DatePicker
{
    /// <summary>
    /// Interaction logic for ucDatePicker.xaml
    /// </summary>
    public partial class ucDatePicker : UserControl
    {
        public ucDatePicker()
        {
            InitializeComponent();
            txtDay.Text = "21";
            txtMonth.Text = "مهر";
            txtYear.Text = "1391";
        }
        public string GetDate()
        {
            return txtYear.Text+"/"+(txtMonth.SelectedIndex+1).ToString()+"/" +txtDay.Text;
        }
    }
}
