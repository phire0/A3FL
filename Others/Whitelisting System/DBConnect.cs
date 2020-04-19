using MySql.Data.MySqlClient;
using System;

namespace A3FL_Whitelist
{
  internal class DBConnect
  {
    private MySqlConnection connection;
    private string server;
    private string database;
    private string uid;
    private string password;

    public DBConnect()
    {
      this.Initialize();
    }

    private void Initialize()
    {
      string[] commandLineArgs = Environment.GetCommandLineArgs();
      this.server = commandLineArgs[3];
      this.database = commandLineArgs[4];
      this.uid = commandLineArgs[5];
      this.password = commandLineArgs[6];
      this.connection = new MySqlConnection("SERVER=" + this.server + ";DATABASE=" + this.database + ";UID=" + this.uid + ";PASSWORD=" + this.password + ";");
    }

    private bool OpenConnection()
    {
      try
      {
        this.connection.Open();
        return true;
      }
      catch (MySqlException ex)
      {
        switch (ex.Number)
        {
          case 0:
            Console.WriteLine("Error connecting to MYSQL Database!");
            break;
          case 1045:
            Console.WriteLine("The username/password may be invalid! Please try again.");
            break;
        }
        return false;
      }
    }

    private bool CloseConnection()
    {
      try
      {
        this.connection.Close();
        return true;
      }
      catch (MySqlException ex)
      {
        Console.WriteLine(ex.Message);
        return false;
      }
    }

    public int Count(string beguid)
    {
      string cmdText = "SELECT Count(*) FROM whitelist WHERE beguid = '" + beguid + "'";
         
            try
            {
                this.connection.Open();
                int num = int.Parse(string.Concat(new MySqlCommand(cmdText, this.connection).ExecuteScalar()));
                return num;
            }
            catch (MySqlException e)
            {
                this.connection.Close();
                Console.WriteLine(e);
                return 7;
            }
            finally
            {
                this.connection.Close();
            }
        }
  }
}
