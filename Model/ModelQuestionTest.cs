using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace CollegeExamApp.Model
{
    class ModelQuestionTest : ModelQuestion
    {
        private HashSet<string> options;
        public HashSet<string> Options
        {
            get { return options; }
            set { options = value; }
        }
        public string Answer { get; set; }
        public ModelQuestionTest()
        {
            options = new HashSet<string>();
        }
        public void AddOption(string option)
        {
            options.Add(option);
        }
        public void RemoveOption(string option)
        {
            options.Remove(option);
        }
        public void RemoveAlloption()
        {
            options.Clear();
        }
        public HashSet<string> GetList()
        {
            return options;
        }
        public HashSet<string> GetRandomList()
        {
            HashSet<string> set1 = new HashSet<string>(options);
            HashSet<string> set2 = new HashSet<string>();
            Random r = new Random();
            while (set1.Count > 0)
            {
                int next = r.Next(set1.Count);
                string element = set1.ElementAt(next);
                set1.Remove(element);
                set2.Add(element);
            }
            return set2;
        }
        public string[] GetArrayList()
        {
           
            return options.ToArray<string>();
        }
        public string[] GetRandomArrayList()
        {
            HashSet<string> set1 = new HashSet<string>(options);
            HashSet<string> set2 = new HashSet<string>();
            Random r = new Random();
            while(set1.Count>0)
            {
                int next = r.Next(set1.Count);
                string element=set1.ElementAt(next);
                set1.Remove(element);
                set2.Add(element);
            }
            return set2.ToArray<string>();
        }
        public bool CheckAnswer(string answer)
        {
            return Answer.Equals(answer) && (options.Contains(answer));
        }
        public string ToJSON()
        {
            var serializer = new JavaScriptSerializer();
            var serializedResult = serializer.Serialize(this);
            return serializedResult.ToString();
        }
    }

}
