using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace CollegeExamApp.Model
{
    class ModelQuestionMatching : ModelQuestion
    {
        private  Dictionary<string,string> listAnswer;
        public ModelQuestionMatching()
        {
            listAnswer = new Dictionary<string, string>();
        }
        public void AddMatchQuestion(string key,string value)
        {
            listAnswer.Add(key, value);
        }
        public void RemoveAllQuestion()
        {
            listAnswer.Clear();
        }
        public int CheckAnswer(Dictionary<string,string> answer )
        {
            int count = 0;
            try
            {
                foreach (string key in listAnswer.Keys)
                {
                    string answervalue = answer[key];
                    string listvalue = listAnswer[key];
                    if (answervalue == listvalue)
                        count++;
                }
            }
            catch(KeyNotFoundException)
            {

            }
            return count;
        }
        public Dictionary<string,string> GetAllMatching()
        {
            return listAnswer;
        }
        public string[] GetKeysListToArray()
        {
           return listAnswer.Keys.ToArray<string>();
        }
        public string[] GetValuesListToArray()
        {
            return listAnswer.Values.ToArray<string>();
        }
        public HashSet<string> GetKeysRandomList()
        {
            HashSet<string> set1 = new HashSet<string>(listAnswer.Keys.ToArray());
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
        public HashSet<string> GetValuesRandomList()
        {
            HashSet<string> set1 = new HashSet<string>(listAnswer.Values.ToArray());
            HashSet<string> set2 = new HashSet<string>();
            Random r = new Random();
            while (set1.Count > 0)
            {
                int next = r.Next(set1.Count);
                string element = set1.ElementAt(next);
                set1.Remove(element);
                set2.Add(element);
            }
            set2.Remove("");
            return set2;
        }
        public string[] GetValuesRandomArrayList()
        {
            HashSet<string> set1 = new HashSet<string>(listAnswer.Values.ToArray());
            HashSet<string> set2 = new HashSet<string>();
            Random r = new Random();
            while (set1.Count > 0)
            {
                int next = r.Next(set1.Count);
                string element = set1.ElementAt(next);
                set1.Remove(element);
                set2.Add(element);
            }
            set2.Remove("");
            return set2.ToArray<string>();
        }
        public string[] GetKeysRandomArrayList()
        {
            HashSet<string> set1 = new HashSet<string>(listAnswer.Keys.ToArray());
            HashSet<string> set2 = new HashSet<string>();
            Random r = new Random();
            while (set1.Count > 0)
            {
                int next = r.Next(set1.Count);
                string element = set1.ElementAt(next);
                set1.Remove(element);
                set2.Add(element);
            }
            return set2.ToArray<string>();
        }

        public string ToJSON()
        {
            var serializer = new JavaScriptSerializer();
            var serializedResult = serializer.Serialize(this);
            return serializedResult.ToString();
        }
    }
}
