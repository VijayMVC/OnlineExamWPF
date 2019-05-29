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
    /// Interaction logic for ucButton.xaml
    /// </summary>
    public partial class ucButton : UserControl
    {
        public ucButton()
        {
            InitializeComponent();
        }
        public String ContentText
        {
            set { txtBlock.Text = value; }
            get { return txtBlock.Text; }
        }
        public FontAwesome.WPF.FontAwesomeIcon IconName
        {
            set { iconName.Icon = value; }
            get { return iconName.Icon; }
        }

        

        private void BorderButton_MouseEnter(object sender, MouseEventArgs e)
        {
            BorderButton.Background = Brushes.Tomato;
            //BorderButton.BorderBrush = Brushes.Tomato;
        }

        private void BorderButton_MouseLeave(object sender, MouseEventArgs e)
        {
            var bc = new BrushConverter();
            BorderButton.Background = (Brush)bc.ConvertFrom("#C82333");
            //BorderButton.BorderBrush = (Brush)bc.ConvertFrom("#C82333");

        }
    }
}
