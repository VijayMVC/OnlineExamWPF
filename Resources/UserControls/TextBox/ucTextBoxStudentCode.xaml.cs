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

namespace CollegeExam.Resources.UserControls.TextBox
{
    /// <summary>
    /// Interaction logic for ucTextBoxStudentCode.xaml
    /// </summary>
    public partial class ucTextBoxStudentCode : UserControl
    {
        private string previousText;
        public ucTextBoxStudentCode()
        {
            InitializeComponent();
        }

        private void TxtStudentCode_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (string.IsNullOrEmpty(((System.Windows.Controls.TextBox)sender).Text))
                previousText = "";
            else
            {
                double num = 0;
                bool success = double.TryParse(((System.Windows.Controls.TextBox)sender).Text, out num);
                if (success & num >= 0)
                {
                    ((System.Windows.Controls.TextBox)sender).Text.Trim();
                    previousText = ((System.Windows.Controls.TextBox)sender).Text;
                }
                else
                {
                    ((System.Windows.Controls.TextBox)sender).Text = previousText;
                    ((System.Windows.Controls.TextBox)sender).SelectionStart = ((System.Windows.Controls.TextBox)sender).Text.Length;
                }
            }

        }
    }
}
