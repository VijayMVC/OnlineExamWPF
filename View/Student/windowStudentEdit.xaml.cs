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
using System.Windows.Shapes;

namespace CollegeExam.View.Student
{
    /// <summary>
    /// Interaction logic for windowStudentEdit.xaml
    /// </summary>
    public partial class windowStudentEdit : Window
    {
        public windowStudentEdit()
        {
            InitializeComponent();
        }

        private void BtnCancel_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            this.Close();
        }


    }
}
