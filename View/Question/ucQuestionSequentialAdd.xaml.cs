﻿using System;
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

namespace CollegeExam.View.Question
{
    /// <summary>
    /// Interaction logic for ucQuestionSequentialAdd.xaml
    /// </summary>
    public partial class ucQuestionSequentialAdd : UserControl
    {
        private DockPanel main;
        public ucQuestionSequentialAdd(DockPanel main)
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
    }
}
