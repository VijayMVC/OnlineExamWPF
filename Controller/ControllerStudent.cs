using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CollegeExam.EntityModels;
namespace CollegeExam.Controller
{
    class ControllerStudent
    {
        public int Save(Student student)
        {
            var context = new OnlineExamEntities();
            context.Student.Add(student);
            int g=context.SaveChanges();
            return g;
        }
    }
}
