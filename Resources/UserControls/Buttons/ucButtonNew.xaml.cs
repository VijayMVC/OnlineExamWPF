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

namespace CollegeExam.Resources.UserControls.Buttons
{
    /// <summary>
    /// Interaction logic for ucButtonNew.xaml
    /// </summary>
    public partial class ucButtonNew : UserControl
    {
        public ucButtonNew()
        {
            InitializeComponent();
        }
        private void Border_MouseMove(object sender, MouseEventArgs e)
        {
            //BorderButton.Background = Brushes.Green;
        }
        private void BorderButton_MouseEnter(object sender, MouseEventArgs e)
        {
            BorderButton.Background = Brushes.OrangeRed;
            //BorderButton.BorderBrush = Brushes.White;
        }
        private void BorderButton_MouseLeave(object sender, MouseEventArgs e)
        {
            var bc = new BrushConverter();
            BorderButton.Background = Brushes.Tomato;
            //BorderButton.BorderBrush = (Brush)bc.ConvertFrom("#FFFFFF");
        }
    }
}
