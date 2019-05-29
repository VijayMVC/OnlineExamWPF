using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CollegeExamApp.Model
{
    class ModelQuestionExam
    {
        public int QuestionExamID { get; set; }
        public int? TestID { get; set; }
        public int? StudentID { get; set; }
        public int? QuestionID { get; set; }
        public string StudentAnswer { get; set; }
        public double? TeacherScore { get; set; }
        public bool? DidTeacherCheck { get; set; }
        public bool? IsDisabled { get; set; }
    }
}
