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

namespace CollegeExam.View.Student
{
    /// <summary>
    /// Interaction logic for ucStudentEdit.xaml
    /// </summary>
    public partial class ucStudentEdit : UserControl
    {
        private DockPanel main;
        public ucStudentEdit(DockPanel main)
        {
            InitializeComponent();
            this.main = main;
        }
        public void CloseForm()
        {
            main.Children.Clear();
        }
        private void Image_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            CloseForm();
        }

        private void BtnCancel_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            CloseForm();

        }
    }
}
