using System;
using System.Text.RegularExpressions;

namespace A3FL_Whitelist
{
  public class Player
  {
    private readonly int _id;
    private readonly string _name;
    private readonly string _data;

    public int Id
    {
      get
      {
        return this._id;
      }
    }

    public string Name
    {
      get
      {
        return this._name;
      }
    }

    public string Data
    {
      get
      {
        return this._data;
      }
    }

    public Player(Message message)
    {
      try
      {
        GroupCollection groups = message.Match.Groups;
        this._name = groups[nameof (Name)].Value;
        this._id = (int) Convert.ToInt16(groups[nameof (Id)].Value);
        this._data = message.Type == Message.MessageType.ConnectIP ? groups["Ip"].Value : groups["Guid"].Value;
      }
      catch (Exception ex)
      {
        Console.WriteLine(ex.ToString());
      }
    }
  }
}
