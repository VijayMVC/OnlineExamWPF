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
    /// Interaction logic for ucQuestionPanelFill.xaml
    /// </summary>
    public partial class ucQuestionPanelFill : UserControl
    {
        int WordCount = 500;
        string text = ".در این *** مورد می خواهم که *** به شما بگویم *** نیازی به  استفاده  مجدد  از بازاریابی *** نیست .در این *** مورد می خواهم که *** به شما بگویم *** نیازی به  استفاده  مجدد  از بازاریابی *** نیست .در این *** مورد می خواهم که *** به شما بگویم *** نیازی به  استفاده  مجدد  از بازاریابی *** نیست ";
        public ucQuestionPanelFill()
        {
            InitializeComponent();
            char []ch = { ' ' };
            string[] array = text.Split(ch,StringSplitOptions.RemoveEmptyEntries);
            Run[] run = new Run[array.Length+1];
            TextBox[] textBoxes = new TextBox[40];
            int i = 0;
            int runcounter = 0;
            int wordcounter = 0;
            while (i<array.Length)
            {
                if ( array[i].Trim()!="")
                {
                    if (array[i]=="***")
                    {
                        textBoxes[wordcounter] = new TextBox();
                        textBoxes[wordcounter].MinWidth = 40;
                        QuestionBlock.Inlines.Add(textBoxes[wordcounter]);
                        wordcounter++;
                    }
                    else
                    {
                        run[runcounter] = new Run("کریم " + runcounter.ToString());
                        QuestionBlock.Inlines.Add(run[runcounter]);
                        runcounter++;
                    }
                }
                i++;
            }
        }
    }
}
