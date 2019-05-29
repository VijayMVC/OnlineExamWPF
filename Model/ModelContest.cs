using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Windows.Media.Imaging;

namespace CollegeExamApp.Model
{
    public class ModelContest
    {
        public ModelContest()
        {
            lst.Add("tt1t1t1t1t1t1t1t1t1t1t1t1t1t1t11");
            lst.Add("t2");
            lst.Add("t3");
            lst.Add("t4");
            lst.Add("t5");
        }
        public List<string> lst = new List<string>();
        public int ContestID { get; set; }

        public int? TestID { get; set; }

        public string ContestText { get; set; }

        public int? StudentID { get; set; }

        public bool? IsDisabled { get; set; }

        public DateTime? RegisterDate { get; set; }

        public bool? IsTeacherResponse { get; set; }

        public string TeacherResponse { get; set; }

        public int? DesingerID { get; set; }

    }
}
