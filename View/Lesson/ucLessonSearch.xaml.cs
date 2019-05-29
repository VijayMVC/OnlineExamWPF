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

namespace CollegeExam.View.Lesson
{
    /// <summary>
    /// Interaction logic for ucLessonSearch.xaml
    /// </summary>
    public partial class ucLessonSearch : UserControl
    {
        DockPanel main;
        public ucLessonSearch(DockPanel main)
        {
            InitializeComponent();
            this.main = main;
        }

        private void BtnCancel_Loaded(object sender, RoutedEventArgs e)
        {

        }

        private void Image_MouseDown(object sender, MouseButtonEventArgs e)
        {
            //CloseForm();
        }
        public void CloseForm()
        {
            main.Children.Clear();
        }
        private void BtnCancel_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            CloseForm();
        }

        private void TextBlock_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            CloseForm();
        }

        private void BtnEdit_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            Window window = new Window();
            window.Title = "ویرایش آزمون";
            window.Content = new ucLessonEdit(window);
            window.ResizeMode = ResizeMode.CanResize;
            window.WindowStartupLocation = WindowStartupLocation.CenterScreen;
            window.SizeToContent = SizeToContent.WidthAndHeight;
            window.ShowDialog();
        }

        private void BtnChapterList_Click(object sender, RoutedEventArgs e)
        {
            Window window = new Window();
            window.Title = "ویرایش آزمون";
            window.Content = new ucLessonChapterList(window);
            window.ResizeMode = ResizeMode.CanResize;
            window.WindowStartupLocation = WindowStartupLocation.CenterScreen;
            window.SizeToContent = SizeToContent.WidthAndHeight;
            window.ShowDialog();
        }
    }
}
