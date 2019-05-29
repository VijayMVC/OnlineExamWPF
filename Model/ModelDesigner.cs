using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CollegeExamApp.Model
{
    class ModelDesigner
    {
        public int DesignerID { get; set; }
        public string Name { get; set; }
        public string CodeMeli { get; set; }
        public string Official { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string Mobile { get; set; }
        public string Email { get; set; }
        public bool? IsDisabled { get; set; }
        public DateTime? RegisterDate { get; set; }

    }
}
