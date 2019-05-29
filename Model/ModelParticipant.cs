using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CollegeExamApp.Model
{
    class ModelParticipant
    {
        public int ParticipantID { get; set; }
        public int? TestID { get; set; }
        public int? StudentID { get; set; }
        public double? Grade { get; set; }
        public TimeSpan? TimeIn { get; set; }
        public TimeSpan? ResponseTime { get; set; }
        public DateTime? RegisterDate { get; set; }
        public bool? IsFinishTest { get; set; }
        public bool? IsDisabled { get; set; }
    }
}
