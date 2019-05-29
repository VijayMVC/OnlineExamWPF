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
using CollegeExam.View.Course;
using CollegeExam.View.Student;
using CollegeExam.View.Exam;
using CollegeExam.View.Question;
using CollegeExam.View.Lesson;
namespace CollegeExam
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void MnuCourseAdd_Click(object sender, RoutedEventArgs e)
        {
            ucCourseAdd uc = new ucCourseAdd(dkpMain);
            DockPanel.SetDock(uc, Dock.Top);
            dkpMain.Children.Clear();
            dkpMain.Children.Add(uc);
        }

        private void MnuCourseSearch_Click(object sender, RoutedEventArgs e)
        {
            ucCourseSearch uc = new ucCourseSearch(dkpMain);
            dkpMain.Children.Clear();
            DockPanel.SetDock(uc, Dock.Top);
            dkpMain.Children.Add(uc);
        }

        private void MnuStudentAdd_Click(object sender, RoutedEventArgs e)
        {
            ucStudentAdd uc = new ucStudentAdd(dkpMain);
            dkpMain.Children.Clear();
            DockPanel.SetDock(uc, Dock.Top);
            dkpMain.Children.Add(uc);
        }

        private void MnuStudentSearch_Click(object sender, RoutedEventArgs e)
        {
            ucStudentSearch uc = new ucStudentSearch(dkpMain);
            dkpMain.Children.Clear();
            DockPanel.SetDock(uc, Dock.Top);
            dkpMain.Children.Add(uc);
        }

        private void MnuExamAdd_Click(object sender, RoutedEventArgs e)
        {
            ucExamAdd uc = new ucExamAdd(dkpMain);
            dkpMain.Children.Clear();
            DockPanel.SetDock(uc, Dock.Top);
            dkpMain.Children.Add(uc);
        }

        private void MnuExamSearch_Click(object sender, RoutedEventArgs e)
        {
            ucExamSearch uc = new ucExamSearch(dkpMain);
            dkpMain.Children.Clear();
            DockPanel.SetDock(uc, Dock.Top);
            dkpMain.Children.Add(uc);
        }

        private void MnuQuestionTestAdd_Click(object sender, RoutedEventArgs e)
        {
            ucQuestionTestAdd uc = new ucQuestionTestAdd(dkpMain);
            dkpMain.Children.Clear();
            DockPanel.SetDock(uc, Dock.Top);
            dkpMain.Children.Add(uc);

        }

        private void MnuQuestionDescriptiveAdd_Click(object sender, RoutedEventArgs e)
        {
            ucQuestionDescriptiveAdd uc = new ucQuestionDescriptiveAdd(dkpMain);
            dkpMain.Children.Clear();
            DockPanel.SetDock(uc, Dock.Top);
            dkpMain.Children.Add(uc);
        }

        private void MnuQuestionTrueFalseAdd_Click(object sender, RoutedEventArgs e)
        {
            ucQuestionTrueFalseAdd uc = new ucQuestionTrueFalseAdd(dkpMain);
            dkpMain.Children.Clear();
            DockPanel.SetDock(uc, Dock.Top);
            dkpMain.Children.Add(uc);
        }

        private void MnuQuestionBlankAdd_Click(object sender, RoutedEventArgs e)
        {
            ucQuestionBlankAdd uc = new ucQuestionBlankAdd(dkpMain);
            dkpMain.Children.Clear();
            DockPanel.SetDock(uc, Dock.Top);
            dkpMain.Children.Add(uc);
        }

        private void MnuQuestionPracticalAdd_Click(object sender, RoutedEventArgs e)
        {
            ucQuestionPracticalAdd uc = new ucQuestionPracticalAdd(dkpMain);
            dkpMain.Children.Clear();
            DockPanel.SetDock(uc, Dock.Top);
            dkpMain.Children.Add(uc);
        }



        private void MnuQuestionSearch_Click(object sender, RoutedEventArgs e)
        {
            ucQuestionSearch uc = new ucQuestionSearch(dkpMain);
            dkpMain.Children.Clear();
            DockPanel.SetDock(uc, Dock.Top);
            dkpMain.Children.Add(uc);
        }

        private void MnuQuestionMatchingAdd_Click(object sender, RoutedEventArgs e)
        {
            ucQuestionMatchingAdd uc = new ucQuestionMatchingAdd(dkpMain);
            dkpMain.Children.Clear();
            DockPanel.SetDock(uc, Dock.Top);
            dkpMain.Children.Add(uc);
        }

        private void MnuQuestionSequentialAdd_Click(object sender, RoutedEventArgs e)
        {
            ucQuestionSequentialAdd uc = new ucQuestionSequentialAdd(dkpMain);
            dkpMain.Children.Clear();
            DockPanel.SetDock(uc, Dock.Top);
            dkpMain.Children.Add(uc);
        }


        private void MnuLessonAdd_Click(object sender, RoutedEventArgs e)
        {
            ucLessonAdd uc = new ucLessonAdd(dkpMain);
            dkpMain.Children.Clear();
            DockPanel.SetDock(uc, Dock.Top);
            dkpMain.Children.Add(uc);
        }

        private void MnuLessonSearch_Click(object sender, RoutedEventArgs e)
        {
            ucLessonSearch uc = new ucLessonSearch(dkpMain);
            dkpMain.Children.Clear();
            DockPanel.SetDock(uc, Dock.Top);
            dkpMain.Children.Add(uc);
        }

        private void MnuStudentRegisterInExam_Click(object sender, RoutedEventArgs e)
        {
            ucStudentRegisterInExam uc = new ucStudentRegisterInExam(dkpMain);
            dkpMain.Children.Clear();
            DockPanel.SetDock(uc, Dock.Top);
            dkpMain.Children.Add(uc);
        }

        private void MnuStudentParticipantInExam_Click(object sender, RoutedEventArgs e)
        {
            ucStudentParticipantInExam uc = new ucStudentParticipantInExam(dkpMain);
            dkpMain.Children.Clear();
            DockPanel.SetDock(uc, Dock.Top);
            dkpMain.Children.Add(uc);
        }

        private void MnuStudentTakedExam_Click(object sender, RoutedEventArgs e)
        {
            ucStudentTakedExam uc = new ucStudentTakedExam(dkpMain);
            dkpMain.Children.Clear();
            DockPanel.SetDock(uc, Dock.Top);
            dkpMain.Children.Add(uc);
        }

        private void MnuStudentStartExam_Click(object sender, RoutedEventArgs e)
        {
            ucStudentStartExam uc = new ucStudentStartExam(dkpMain);
            dkpMain.Children.Clear();
            DockPanel.SetDock(uc, Dock.Top);
            dkpMain.Children.Add(uc);
        }
    }
}
