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
    /// Interaction logic for ucStudentTakedExam.xaml
    /// </summary>
    public partial class ucStudentTakedExam : UserControl
    {
        private DockPanel main;
        public ucStudentTakedExam(DockPanel main)
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
            Window window = new Window();
            window.Title = "ویرایش آزمون";
            //window.Content = new ucExamEdit(window);
            window.ResizeMode = ResizeMode.NoResize;
            window.WindowStartupLocation = WindowStartupLocation.CenterScreen;
            window.SizeToContent = SizeToContent.WidthAndHeight;
            window.ShowDialog();
        }

        private void BtnParticipantList_Click(object sender, RoutedEventArgs e)
        {
            Window window = new Window();
            window.Title = "لیست شرگت گنندگان آزمون";
            //window.Content = new ucParticipantList(window);
            window.ResizeMode = ResizeMode.NoResize;
            window.WindowStartupLocation = WindowStartupLocation.CenterScreen;
            window.SizeToContent = SizeToContent.WidthAndHeight;
            window.ShowDialog();
        }

        private void BtnRegisterExam_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
