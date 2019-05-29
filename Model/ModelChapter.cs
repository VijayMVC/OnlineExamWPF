using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;

namespace CollegeExamApp.Model
{
    class ModelChapter
    {
        public int ChapterID { get; set; }
        public int? ChapterNo { get; set; }
        public string ChapterTitle { get; set; }
        public int? LessonID { get; set; }
        public string Description { get; set; }
        public bool? IsDisabled { get; set; }
    }
}
