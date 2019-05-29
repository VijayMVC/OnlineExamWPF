using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CollegeExamApp.Model
{
    class ModelStudent
    {
        public int StudentID { get; set; }
        public string NameFamily { get; set; }
        public string CodeMeli { get; set; }
        public string StudentCode { get; set; }
        public string DadName { get; set; }
        public string Mobile { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string Class { get; set; }
        public string Email { get; set; }
        public bool? IsGraguated { get; set; }
        public DateTime? GraduateDate { get; set; }
        public DateTime? RegisterDate { get; set; }
        public bool? IsDisabled { get; set; }
    }
}
