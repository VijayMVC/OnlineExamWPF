//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace CollegeExam.EntityModels
{
    using System;
    using System.Collections.Generic;
    
    public partial class StudentExamPermision
    {
        public int StudentExamPermisionID { get; set; }
        public Nullable<int> ExamID { get; set; }
        public Nullable<int> StudentID { get; set; }
    
        public virtual Exam Exam { get; set; }
        public virtual Student Student { get; set; }
    }
}
