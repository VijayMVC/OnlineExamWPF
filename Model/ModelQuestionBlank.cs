using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace CollegeExamApp.Model
{
    class ModelQuestionBlank : ModelQuestion
    {
        private List<string> keywords;
        public List<string> KeyWords
        {
            get{ return keywords; }
            set { keywords = value; }
        }
        public bool ShowKeyword { get; set; }
        public int KeywordCount { get; set; }
        public string TextDelimiter { get; set; }
        public string AnswerDelimiter { get; set; }
        public string Answer { get; set; }

        public ModelQuestionBlank()
        {
            keywords = new List<string>();
        }
        public ModelQuestionBlank(string answers)
        {
            this.keywords = new List<string>();
            foreach (string item in answers.Split(','))
            {
                if (!this.keywords.Contains(item))
                    keywords.Add(item);
            }
       }
        public ModelQuestionBlank(string answers,char splitter)
        {
            this.keywords = new List<string>();
            foreach (string item in answers.Split(splitter))
            {
                if (!this.keywords.Contains(item))
                    keywords.Add(item);
            }
            
        }
        public void RemoveAllKeyword()
        {
            keywords.Clear();
        }
        public List<string> GetListSeperated()
        {
            return keywords;
        }
        public List<string> GetRandomListSeperated()
        {
            HashSet<string> set1 = new HashSet<string>(keywords);
            HashSet<string> set2 = new HashSet<string>();
            Random r = new Random();
            while (set1.Count > 0)
            {
                int next = r.Next(set1.Count);
                string element = set1.ElementAt(next);
                set1.Remove(element);
                set2.Add(element);
            }
            return new List<string>(set2);
        }
        public string[] GetArrayListSeperated()
        {

            return keywords.ToArray<string>();
        }
        public string[] GetRandomArrayListSeperated()
        {
            HashSet<string> set1 = new HashSet<string>(keywords);
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
        public void SetKeyword(string keywords,char splitter)
        {
            this.keywords.AddRange(keywords.Split(splitter));
        }
        public string  GetKeywordTogether()
        {
            string output="";
            foreach(string item in keywords)
            {
                output += item + ",";
            }
            output.Remove(output.Length - 1, 1);
            return output;
        }
        public int CheckAnswer(string answer)
        {
            List<string> ans = new List<string>(answer.Split(','));
            int count = 0;
            for (int i=0;i<ans.Capacity;i++)
            {
                if (ans[i] == keywords[i])
                    count++;
            }
            return count;
        }
        public int CheckAnswer(string answer,char spliter)
        {
            List<string> ans = new List<string>(answer.Split(spliter));
            int count = 0;
            for (int i = 0; i < ans.Capacity; i++)
            {
                if (ans[i] == keywords[i])
                    count++;
            }
            return count;
        }
        public int ComputeLevenshteinDistance(string source, string target)
        {
            if ((source == null) || (target == null)) return 0;
            if ((source.Length == 0) || (target.Length == 0)) return 0;
            if (source == target) return source.Length;

            int sourceWordCount = source.Length;
            int targetWordCount = target.Length;

            // Step 1
            if (sourceWordCount == 0)
                return targetWordCount;

            if (targetWordCount == 0)
                return sourceWordCount;

            int[,] distance = new int[sourceWordCount + 1, targetWordCount + 1];

            // Step 2
            for (int i = 0; i <= sourceWordCount; distance[i, 0] = i++) ;
            for (int j = 0; j <= targetWordCount; distance[0, j] = j++) ;

            for (int i = 1; i <= sourceWordCount; i++)
            {
                for (int j = 1; j <= targetWordCount; j++)
                {
                    // Step 3
                    int cost = (target[j - 1] == source[i - 1]) ? 0 : 1;

                    // Step 4
                    distance[i, j] = Math.Min(Math.Min(distance[i - 1, j] + 1, distance[i, j - 1] + 1), distance[i - 1, j - 1] + cost);
                }
            }

            return distance[sourceWordCount, targetWordCount];
        }
        public string ReplaceTextSplitterWith(string text,string delimiter)
        {
            string temp = text;
            int i = 1;
            while(true)
            {
                int index = temp.IndexOf(delimiter, 0);
                if (index > 0)
                {
                    temp = temp.Remove(index, delimiter.Length);
                    temp = temp.Insert(index, string.Format(" ....({0}).... ", i));
                    i++;
                }
                else
                    break;
            }
            return temp;
        }
        public string ToJSON()
        {
            var serializer = new JavaScriptSerializer();
            var serializedResult = serializer.Serialize(this);
            return serializedResult.ToString();
        }
    }
}
