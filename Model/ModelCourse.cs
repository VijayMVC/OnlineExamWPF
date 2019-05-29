﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CollegeExamApp.Model
{
    class ModelCourse
    {
        public ModelCourse()
        {

        }
        public int CourseID { get; set; }
        public string CourseName { get; set; }
        public string Description { get; set; }
        public bool? IsDisabled { get; set; }
    }
}
