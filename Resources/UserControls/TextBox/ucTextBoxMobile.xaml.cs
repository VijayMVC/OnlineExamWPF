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
    /// Interaction logic for ucTextBoxMobile.xaml
    /// </summary>
    public partial class ucTextBoxMobile : UserControl
    {
        private string previousText;
        public ucTextBoxMobile()
        {
            InitializeComponent();
        }
        private void TxtMobile_TextChanged(object sender, TextChangedEventArgs e)
        {
            System.Windows.Controls.TextBox textBox = (System.Windows.Controls.TextBox)sender;
            if (string.IsNullOrEmpty(textBox.Text))
                previousText = "";
            else
            {
                double num = 0;
                bool success = double.TryParse(textBox.Text, out num);
                if (success & num >= 0)
                {
                    textBox.Text.Trim();
                    previousText = textBox.Text;
                }
                else
                {
                    textBox.Text = previousText;
                    textBox.SelectionStart = textBox.Text.Length;
                }
            }

        }
    }
}
