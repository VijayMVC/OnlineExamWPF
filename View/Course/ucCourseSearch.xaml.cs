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
    /// Interaction logic for ucCourseSearch.xaml
    /// </summary>
    public partial class ucCourseSearch : UserControl
    {
        DockPanel main;
        ucCourseEdit uc;
        public ucCourseSearch(DockPanel main)
        {
            InitializeComponent();
            this.main = main;
            uc=new ucCourseEdit(main);
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
            
            DockPanel.SetDock(uc, Dock.Top);
            if (main.Children.Contains(uc)==false)
                main.Children.Add(uc);

        }
    }
}
