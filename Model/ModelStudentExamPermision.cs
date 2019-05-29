using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CollegeExamApp.Model
{
    class ModelStudentExamPermision
    {
        public int StudentExamPermisionID { get; set; }

        public int? ExamID { get; set; }

        public int? StudentID { get; set; }
    }
}
