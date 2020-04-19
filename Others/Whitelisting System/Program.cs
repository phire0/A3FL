using BattleNET;
using System;
using System.Net;
using System.Text;

namespace A3FL_Whitelist
{
  internal class Program
  {
    public static BattlEyeClient b;

    private static void Main(string[] args)
    {
      string command1 = "";
      Console.OutputEncoding = Encoding.UTF8;
      BattlEyeLoginCredentials loginCredentials = Program.GetLoginCredentials();
      Console.Title = string.Format("A3FL Whitelist - {0}:{1}", (object) loginCredentials.Host, (object) loginCredentials.Port);
      Console.SetWindowSize(Console.WindowWidth * 2, Console.WindowHeight);
      Program.b = new BattlEyeClient(loginCredentials);
      Program.b.BattlEyeMessageReceived += new BattlEyeMessageEventHandler(Program.BattlEyeMessageReceived);
      Program.b.BattlEyeConnected += new BattlEyeConnectEventHandler(Program.BattlEyeConnected);
      Program.b.BattlEyeDisconnected += new BattlEyeDisconnectEventHandler(Program.BattlEyeDisconnected);
      Program.b.ReconnectOnPacketLoss = true;
      int num = (int) Program.b.Connect();
      if (command1 != "")
      {
        Program.b.SendCommand(command1, true);
        while (Program.b.CommandQueue > 0)
          ;
      }
      else
      {
        while (true)
        {
          string command2 = Console.ReadLine();
          if (!(command2 == "exit") && !(command2 == "logout"))
          {
            if (command2 == "clear")
              Console.Clear();
            else if (Program.b.Connected)
              Program.b.SendCommand(command2, true);
            else
              Environment.Exit(0);
          }
          else
            break;
        }
      }
      Program.b.Disconnect();
    }

    private static void BattlEyeConnected(BattlEyeConnectEventArgs args)
    {
      Console.WriteLine(args.Message);
    }

    private static void BattlEyeDisconnected(BattlEyeDisconnectEventArgs args)
    {
      Console.WriteLine(args.Message);
    }

    private static void BattlEyeMessageReceived(BattlEyeMessageEventArgs args)
    {
      Message message = new Message(args.Message, args.Id);
      switch (message.Type)
      {
        case Message.MessageType.Chat:
          Console.ForegroundColor = ConsoleColor.Cyan;
          Console.WriteLine(message.Content);
          Console.ForegroundColor = ConsoleColor.White;
          break;
        case Message.MessageType.ConnectGUID:
          Player player = new Player(message);
                    if (new DBConnect().Count(player.Data) != 1)
                    {
                        Console.ForegroundColor = ConsoleColor.Red;
                        Console.WriteLine("Kicking " + player.Name + ": Not Whitelisted " + new DBConnect().Count(player.Data));
                        Console.ForegroundColor = ConsoleColor.White;
                        Program.b.SendCommand("kick " + (object)player.Id + " You are not whitelisted - arma3fisherslife.net", true);
                    }
          break;
        default:
          Console.WriteLine(message.Content);
          break;
      }
    }

    private static BattlEyeLoginCredentials GetLoginCredentials()
    {
      BattlEyeLoginCredentials loginCredentials = new BattlEyeLoginCredentials();
      string[] commandLineArgs = Environment.GetCommandLineArgs();
      IPAddress hostAddress = Dns.GetHostAddresses("127.0.0.1")[0];
      loginCredentials.Host = hostAddress;
      loginCredentials.Port = int.Parse(commandLineArgs[1]);
      loginCredentials.Password = commandLineArgs[2];
      return loginCredentials;
    }
  }
}
