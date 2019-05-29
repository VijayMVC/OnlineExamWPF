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
using CollegeExam.EntityModels;



namespace CollegeExam.View.Student
{
    /// <summary>
    /// Interaction logic for ucStudentAdd.xaml
    /// </summary>
    public partial class ucStudentAdd : UserControl
    {
        private DockPanel main;
        public ucStudentAdd(DockPanel main)
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

        private void BtnSave_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            Controller.ControllerStudent ctrl = new Controller.ControllerStudent();
            var student = new EntityModels.Student()
            {
                NameFamily = txtStudentName.Text,
                Mobile = txtMobile.txtMobile.Text,
                CodeMeli = txtNationCode.txtCode.Text,
                StudentCode = txtStudentCode.txtStudentCode.Text,
                DadName = txtFatherName.Text,
                UserName = txtUserName.Text,
                Password = txtPassword.Text,
                Class = comboLevel.Text,
                Email = txtEmail.Text,
                IsDisabled = false,
                IsGraguated = false,
                RegisterDate = DateTime.Now.Date

            };
            int result=ctrl.Save(student);
            if (result >= 1)
                MessageBox.Show("به درستی ذخیره شد");
        }
    }
}
