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
    
    public partial class Chapter
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Chapter()
        {
            this.Question = new HashSet<Question>();
            this.Exam = new HashSet<Exam>();
        }
    
        public int ChapterID { get; set; }
        public Nullable<int> ChapterNo { get; set; }
        public string ChapterTitle { get; set; }
        public Nullable<int> LessonID { get; set; }
        public string Description { get; set; }
        public Nullable<bool> IsDisabled { get; set; }
    
        public virtual Lesson Lesson { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Question> Question { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Exam> Exam { get; set; }
    }
}
