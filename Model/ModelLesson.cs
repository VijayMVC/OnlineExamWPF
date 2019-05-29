using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CollegeExamApp.Model
{
    class ModelLesson
    {
        public int LessonID { get; set; }

        public string LessonName { get; set; }

        public string Description { get; set; }

        public string Level { get; set; }

        public bool? IsDisabled { get; set; }

    }
}
