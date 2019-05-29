using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CollegeExamApp.Model
{
    class ModelExam
    {
        public int ExamID { get; set; }
        public string ExamName { get; set; }
        public string Level { get; set; }

        public int? ChapterID { get; set; }

        public DateTime? Date { get; set; }

        public int? Duration { get; set; }

        public TimeSpan? StartTime { get; set; }

        public string QuestionType { get; set; }

        public string ExamType { get; set; }

        public string SupervisorName { get; set; }

        public int? RepeatTestCount { get; set; }

        public int? OptionalQuestionCount { get; set; }

        public double? OptionalQuestionScore { get; set; }

        public int? DescriptionQuestionCount { get; set; }

        public double? DescriptionQuestionScore { get; set; }

        public int? BlankQuestionCount { get; set; }

        public double? BlankQuestionScore { get; set; }

        public int? TrueFalseQuestionCount { get; set; }

        public double? TrueFalseQuestionScore { get; set; }

        public int? PracticalQuestionCount { get; set; }

        public double? PracticalQuestionScore { get; set; }

        public double? TotalScore { get; set; }

        public string Status { get; set; }

        public string Difficulty { get; set; }

        public DateTime? StartDate { get; set; }

        public int? DelayTime { get; set; }

        public bool? IsDisabled { get; set; }

    }
}
