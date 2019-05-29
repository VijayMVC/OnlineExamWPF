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
using Microsoft.Win32;

namespace CollegeExam.View.Question
{
    /// <summary>
    /// Interaction logic for ucQuestionPracticalAdd.xaml
    /// </summary>
    public partial class ucQuestionPracticalAdd : UserControl
    {
        private DockPanel main;
        public ucQuestionPracticalAdd(DockPanel main)
        {
            InitializeComponent();
            this.main = main;
        }
        private void Image_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            //main.Children.RemoveAt(main.Children.Count - 1);
            CloseForm();
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

        private void BtnInsertImage_Click(object sender, RoutedEventArgs e)
        {
            FlowDocument flowDoc = txtQuestionText.Document;
            Paragraph para = new Paragraph();
            para.Inlines.Add("Some ");
            OpenFileDialog open = new OpenFileDialog();
            open.ShowDialog();
            
            BitmapImage bitmap = new BitmapImage(new Uri(open.FileName));
            Image image = new Image();
            image.Source = bitmap;
            image.Width = 200;
            
            para.Inlines.Add(image);

            para.Inlines.Add(" text");
            flowDoc.Blocks.Add(para);


            
        }
    }
}
