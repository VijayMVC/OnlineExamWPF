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
using System.Windows.Media.Animation;
using CollegeExamApp.Model;
using System.IO;

namespace CollegeExam.View
{
   
    /// <summary>
    /// Interaction logic for ucDefault.xaml
    /// </summary>
    public partial class ucDefault : UserControl
    {
        List<ModelContest> listContest = new List<ModelContest>();
        public ucDefault()
        {

            InitializeComponent();
            ModelContest m1 = new ModelContest();
            m1.ContestID = 1;
            m1.TestID = 1000;
            m1.StudentID = 2000;
            m1.IsDisabled = false;
            m1.RegisterDate = DateTime.Now;
            m1.IsTeacherResponse = true;
            m1.TeacherResponse = "Noobe Va khare  Mordeeee خری  eeeegdgdg eeeeesss";
            m1.ContestText = "علی خر است سسسسسسسسسسسسسسسسسسسسسسسسسسسسسسسسسسسس";

            ModelContest m2 = new ModelContest();
            m2.ContestID = 3;
            m2.TestID = 10000;
            m2.StudentID = 2001;
            m2.IsDisabled = false;
            m2.RegisterDate = DateTime.Now;
            m2.IsTeacherResponse = false;
            m2.TeacherResponse = "zxcvbnm,.';lkjhgfdsxzqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqییییییییییییییییییی";
            m2.ContestText = "علی حسن است خخخخخخخخخخخخخخخخخخخخخخخخخخخ";

            listContest.Add(m1);
            listContest.Add(m2);
            Datagrid.ItemsSource = listContest;
        }

        public byte[] getJPGFromImageControl(BitmapImage imageC)
        {
            MemoryStream memStream = new MemoryStream();
            JpegBitmapEncoder encoder = new JpegBitmapEncoder();
            encoder.Frames.Add(BitmapFrame.Create(imageC));
            encoder.Save(memStream);
            return memStream.ToArray();
        }
        public byte [] GetImage(Image img)
        {
            

            var bmp = img.Source as BitmapImage;
            int height = bmp.PixelHeight;
            int width = bmp.PixelWidth;
            int stride = width * ((bmp.Format.BitsPerPixel + 7) / 8);

            byte[] bits = new byte[height * stride];
            bmp.CopyPixels(bits, stride, 0);
            return bits;

        }

        private void ImageAwesome_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {

        }
    }
}
