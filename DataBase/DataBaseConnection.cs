using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data.SqlClient;
using System.Data;
using System.Windows.Forms;

namespace CollegeExamApp.DataBase
{

    class SQLDataBaseConnection
    {
        private static string serverName = "PCSERVER";
        private static string dataBaseName = "OnlineExam";
        private static string userName = "user1";
        private static string password = "123";
        private static string connectionString =string.Format("Data Source={0};Initial Catalog={1};Integrated Security=True",serverName,dataBaseName);
        protected SqlConnection connection;
        public SQLDataBaseConnection()
        {
            try
            {
                connection = new SqlConnection(connectionString);
                connection.Open();
                connection.Close();
            }
            catch (Exception er)
            {
                MessageBox.Show(er.Message);
            }
        }
    }

}
