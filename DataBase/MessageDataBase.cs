using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CollegeExamApp.DataBase
{
    public class MessageDataBase
    {
        public int ErrorNO; // شماره خطای تولید شده هنگام اجرای پرس و جو 
        public string ErrorMessage; //متن خطای تولید شده هنگام اجرای پرس و جو
        public int Result; // نتیجه اجرای پرس و جو در این فیلد ذخیره می شود
        public bool Check = false; // در صورتی که درست باشد یعنی فرمان مورد نظر به درستی اجرا شده است
        public MessageDataBase()
        {
            ErrorMessage = "";
            ErrorNO = -1;
            Result = 0;
            Check = false;

        }
    }
}
