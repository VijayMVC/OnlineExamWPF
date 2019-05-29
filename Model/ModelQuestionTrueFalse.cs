using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace CollegeExamApp.Model
{
    class ModelQuestionTrueFalse : ModelQuestion
    {
        public string Answer{ get; set; }
        public string ToJSON()
        {
            var serializer = new JavaScriptSerializer();
            var serializedResult = serializer.Serialize(this);
            return serializedResult.ToString();
        }
    }
}
