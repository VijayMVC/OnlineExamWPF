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
using CollegeExam.View.Student;

namespace CollegeExam.View.Student
{
    /// <summary>
    /// Interaction logic for ucStudentSearch.xaml
    /// </summary>
    public partial class ucStudentSearch : UserControl
    {
        DockPanel main;
        public ucStudentSearch(DockPanel main)
        {
            InitializeComponent();
            this.main = main;
        }
        private void BtnCancel_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            CloseForm();
        }

        private void TextBlock_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            CloseForm();
        }

        public void CloseForm()
        {
            main.Children.Clear();
        }

        private void BtnEdit_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            //Window window = new Window
            //{
            //    Title = "ویرایش اطلاعات دانش آموز",
            //    Content = new ucStudentEdit(main),ResizeMode=ResizeMode.NoResize,WindowStartupLocation=WindowStartupLocation.CenterScreen,SizeToContent=SizeToContent.WidthAndHeight
            //};
            //window.ShowDialog();
            windowStudentEdit window = new windowStudentEdit();
            window.ShowDialog();
        }

        private void BtnUserAcount_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            windowStudentEditUserName window = new windowStudentEditUserName();
            window.ShowDialog();
        }
    }
}
