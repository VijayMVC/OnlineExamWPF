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

namespace CollegeExam.View.Exam
{
    /// <summary>
    /// Interaction logic for ucExamEdit.xaml
    /// </summary>
    public partial class ucExamEdit : UserControl
    {
        private Window parent;
        public ucExamEdit(Window parent)
        {
            InitializeComponent();
            this.parent = parent;
        }
        private void BtnCancel_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            CloseForm();
        }

        private void TextBlock_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            CloseForm();
        }
        private void Image_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            CloseForm();
        }

        public void CloseForm()
        {
            parent.Close();
        }


        private void BtnDetails_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
