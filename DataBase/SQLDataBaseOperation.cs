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
    class SQLDataBaseOperation:SQLDataBaseConnection
    {
        public MessageDataBase InsertCommand(string sql)
        {
            SqlCommand command = new SqlCommand();
            command.Connection = connection;
            command.CommandType = CommandType.Text;
            MessageDataBase result = new MessageDataBase();
            command.CommandText = sql;
            try
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                result.Result = command.ExecuteNonQuery();
                connection.Close();
                result.Check = true;
            }
            catch (Exception ex)
            {
                result.ErrorMessage = ex.Message;
                result.Result = 0;
                result.Check = false;
            }
            finally
            {

            }
            return result;
        }
        public MessageDataBase UpdateCommand(string sql)
        {
            SqlCommand command = new SqlCommand();
            MessageDataBase result = new MessageDataBase();
            result.Check = false;
            command.Connection = connection;
            command.CommandType = CommandType.Text;
            command.CommandText = sql;
            try
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                result.Result = command.ExecuteNonQuery();
                connection.Close();
                result.Check = true;
            }
            catch (Exception ex)
            {
                result.ErrorMessage = ex.Message;
                result.Result = 0;
                result.Check = false;
            }
            finally
            {

            }
            return result;
        }
        public MessageDataBase DeleteCommand(string sql)
        {
            SqlCommand command = new SqlCommand();
            MessageDataBase result = new MessageDataBase();
            result.Check = false;
            command.Connection = connection;
            command.CommandType = CommandType.Text;
            command.CommandText = sql;
            try
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                result.Result = command.ExecuteNonQuery();
                connection.Close();
                result.Check = true;
            }
            catch (Exception ex)
            {
                result.ErrorMessage = ex.Message;
                result.Result = 0;
                result.Check = false;
            }
            finally
            {

            }
            return result;
        }
        public MessageDataBase InsertAndGetLastID(string sql)
        {
            MessageDataBase LastID = new MessageDataBase();
            LastID.Result = -1;

            SqlCommand command = new SqlCommand();
            try
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                command.Connection = connection;
                command.CommandType = CommandType.Text;
                command.CommandText = sql + ";SELECT @@IDENTITY;";
                LastID.Result = Convert.ToInt32(command.ExecuteScalar());
                connection.Close();
            }
            catch (Exception er)
            {
                LastID.ErrorMessage = er.Message;
                LastID.Result = -1;
            }
            return LastID;
        }
        public MessageDataBase TInsertCommand(string[] sql)
        {
            MessageDataBase result = new MessageDataBase();
            result.Check = false;
            if (connection.State == ConnectionState.Closed)
                connection.Open();
            SqlTransaction transaction = connection.BeginTransaction("InsertTransaction");

            SqlCommand command = connection.CreateCommand();

            command.Connection = connection;
            command.CommandType = CommandType.Text;
            command.Transaction = transaction;

            try
            {
                for (int i = 0; i < sql.Length; i++)
                {
                    command.CommandText = sql[i];
                    result.Result = command.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                result.Check = false;
                result.Result = 0;
                result.ErrorMessage = ex.Message;
            }
            finally
            {
                transaction.Commit();
                connection.Close();
                result.Check = true;
            }
            return result;
        }
        public MessageDataBase TUpdateCommand(string[] sql)
        {
            MessageDataBase result = new MessageDataBase();
            result.Check = false;
            if (connection.State == ConnectionState.Closed)
                connection.Open();
            SqlTransaction transaction = connection.BeginTransaction("UpdateTransaction");

            SqlCommand command = connection.CreateCommand();

            command.Connection = connection;
            command.CommandType = CommandType.Text;
            command.Transaction = transaction;

            try
            {
                for (int i = 0; i < sql.Length; i++)
                {
                    command.CommandText = sql[i];
                    result.Result = command.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                result.Check = false;
                result.Result = 0;
                result.ErrorMessage = ex.Message;
            }
            finally
            {
                transaction.Commit();
                connection.Close();
                result.Check = true;
            }
            return result;
        }
        public MessageDataBase TDeleteCommand(string[] sql)
        {
            MessageDataBase result = new MessageDataBase();
            result.Check = false;
            if (connection.State == ConnectionState.Closed)
                connection.Open();
            SqlTransaction transaction = connection.BeginTransaction("DeleteTransaction");

            SqlCommand command = connection.CreateCommand();

            command.Connection = connection;
            command.CommandType = CommandType.Text;
            command.Transaction = transaction;

            try
            {
                for (int i = 0; i < sql.Length; i++)
                {
                    command.CommandText = sql[i];
                    result.Result = command.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                result.Check = false;
                result.Result = 0;
                result.ErrorMessage = ex.Message;
            }
            finally
            {
                transaction.Commit();
                connection.Close();
                result.Check = true;
            }
            return result;
        }
        public MessageDataBase FillCombo(ComboBox combo, string tablename, string fieldname, string id)
        {
            string sql = string.Format("select {0},{1} from {2}", id, fieldname, tablename);
            MessageDataBase message = new MessageDataBase();
            DataSet data = SelectCommnad(sql);
            if (data.Tables.Count > 0)
            {
                combo.DataSource = data.Tables[0];
                combo.DisplayMember = fieldname;
                combo.ValueMember = id;
                message.Check = true;
                message.Result = data.Tables[0].Rows.Count;
            }
            else
            {
                message.Check = false;
                message.ErrorMessage = " جدولی انتخاب نشده است";
            }
            return message;
        }
        public DataSet SelectCommnad(string sql)
        {
            SqlCommand command = new SqlCommand();
            DataSet dataSet = new DataSet();
            command.CommandType = CommandType.Text;
            try
            {
                command.CommandText = sql;
                command.Connection = connection;
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                adapter.Fill(dataSet);
            }
            catch (Exception e)
            {
                MessageBox.Show(e.Message);
            }
            return dataSet;
        }
        public DataTable SelectCommnad(string sql, string tablename)
        {

            SqlCommand command = new SqlCommand();
            DataTable dataTable = new DataTable();
            command.CommandType = CommandType.Text;
            try
            {
                command.CommandText = sql;
                command.Connection = connection;
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                adapter.Fill(dataTable);
            }
            catch (Exception e)
            {
                MessageBox.Show(e.Message);
            }
            return dataTable;
        }

        public MessageDataBase RunStoreProcedure(string storeName,List<SqlParameter> parameters)
        {
            SqlCommand command = new SqlCommand();
            command.Connection = connection;
            command.CommandType = CommandType.StoredProcedure;
            MessageDataBase result = new MessageDataBase();
            command.CommandText = storeName;
            if (parameters != null)
                command.Parameters.AddRange(parameters.ToArray());
           
            try
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                result.Result =Convert.ToInt32(command.ExecuteScalar().ToString());
                connection.Close();
                result.Check = true;
            }
            catch (Exception ex)
            {
                result.ErrorMessage = ex.Message;
                result.Result = 0;
                result.Check = false;
            }
            finally
            {

            }
            return result;
        }
        public MessageDataBase RunStoreProcedureGetLastID(string storeName, List<SqlParameter> parameters)
        {
            SqlCommand command = new SqlCommand();
            command.Connection = connection;
            command.CommandType = CommandType.StoredProcedure;
            MessageDataBase result = new MessageDataBase();
            command.CommandText = storeName;
            if (parameters != null)
                command.Parameters.AddRange(parameters.ToArray());

            try
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                result.Result = Convert.ToInt32(command.ExecuteScalar().ToString());
                connection.Close();
                result.Check = true;
            }
            catch (Exception ex)
            {
                result.ErrorMessage = ex.Message;
                result.Result = 0;
                result.Check = false;
            }
            finally
            {
                command = null;
                connection.Close();
            }
            return result;
        }
        public MessageDataBase RunStoreProcedureWithoutParameters(string storeName)
        {
            SqlCommand command = new SqlCommand();
            command.Connection = connection;
            command.CommandType = CommandType.StoredProcedure;
            MessageDataBase result = new MessageDataBase();
            command.CommandText = storeName;
            try
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                result.Result = command.ExecuteNonQuery();
                connection.Close();
                result.Check = true;
            }
            catch (Exception ex)
            {
                result.ErrorMessage = ex.Message;
                result.Result = 0;
                result.Check = false;
            }
            finally
            {

            }
            return result;
        }

    }
}
