﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class OnlineExamEntities : DbContext
    {
        public OnlineExamEntities()
            : base("name=OnlineExamEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Chapter> Chapter { get; set; }
        public virtual DbSet<Class> Class { get; set; }
        public virtual DbSet<Contest> Contest { get; set; }
        public virtual DbSet<Course> Course { get; set; }
        public virtual DbSet<Designer> Designer { get; set; }
        public virtual DbSet<Exam> Exam { get; set; }
        public virtual DbSet<Lesson> Lesson { get; set; }
        public virtual DbSet<LessonCourse> LessonCourse { get; set; }
        public virtual DbSet<Participant> Participant { get; set; }
        public virtual DbSet<Question> Question { get; set; }
        public virtual DbSet<QuestionExam> QuestionExam { get; set; }
        public virtual DbSet<RegsiterClass> RegsiterClass { get; set; }
        public virtual DbSet<Student> Student { get; set; }
        public virtual DbSet<StudentClass> StudentClass { get; set; }
        public virtual DbSet<StudentExamPermision> StudentExamPermision { get; set; }
        public virtual DbSet<sysdiagrams> sysdiagrams { get; set; }
    }
}
