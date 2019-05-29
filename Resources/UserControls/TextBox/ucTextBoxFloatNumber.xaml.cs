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
using System.Text;
using System.Text.RegularExpressions;

namespace CollegeExam.Resources.UserControls.TextBox
{
    /// <summary>
    /// Interaction logic for ucTextBoxFloatNumber.xaml
    /// </summary>
    public partial class ucTextBoxFloatNumber : UserControl
    {
        private string previousText;
        public ucTextBoxFloatNumber()
        {
            InitializeComponent();
        }

        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            Regex regex = new Regex(@"^\d*\.?\d?$");
            if (string.IsNullOrEmpty(((System.Windows.Controls.TextBox)sender).Text))
                previousText = "";
            else
            {
                bool success = regex.IsMatch( ((System.Windows.Controls.TextBox)sender).Text);
                if (success)
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
