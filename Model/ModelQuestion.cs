using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace CollegeExamApp.Model
{
    class ModelQuestion
    {
        public int QuestionID { get; set; }
        public int? DesignerID { get; set; }
        public int? ChapterID { get; set; }
        public string QuestionType { get; set; }
        public string Difficulty { get; set; }
        public int? BookPage { get; set; }
        public DateTime? RegistrationDate { get; set; }
        public string TextQuestion { get; set; }
        public int? DisplayCount { get; set; }
        public double? Score { get; set; }
        public bool? IsDisabled { get; set; }
        
    }
}
