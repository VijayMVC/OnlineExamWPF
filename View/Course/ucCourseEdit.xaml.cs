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

namespace CollegeExam.View.Course
{
    /// <summary>
    /// Interaction logic for ucCourseEdit.xaml
    /// </summary>
    public partial class ucCourseEdit : UserControl
    {
        private DockPanel main;
        public ucCourseEdit(DockPanel main)
        {
            InitializeComponent();
            this.main = main;
        }

        private void Image_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            main.Children.RemoveAt(main.Children.Count - 1);
        }
    }
}
