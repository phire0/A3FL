using System;
using System.Text.RegularExpressions;

namespace A3FL_Whitelist
{
  public class Message
  {
    private readonly Message.MessageType _type = Message.MessageType.Log;
    private readonly Regex _chatRegex = new Regex("^\\((?<Channel>[^\\)]+)\\) (?<Name>[^:]+): (?<Message>.*)$");
    private readonly Regex _connectedIpRegex = new Regex("^Player #(?<Id>[0-9]+) (?<Name>.*) \\((?<Ip>[0-9\\.]+):[0-9]+\\) connected$");
    private readonly Regex _connectedGuidRegex = new Regex("^Verified GUID \\((?<Guid>[a-f0-9]{32})\\) of player #(?<Id>[0-9]+) (?<Name>.*)$");
    private readonly Regex _connectedLegacyGuidRegex = new Regex("^Player #(?<Id>[0-9]+) (?<Name>[^:]+) \\- Legacy GUID: (?<Guid>[a-f0-9]{32})$");
    private readonly Regex _disconnectedRegex = new Regex("^Player #(?<Id>[0-9]+) (?<Name>[^:]+) disconnected$");
    private readonly Regex _kickRegex = new Regex("^Player #(?<Id>[0-9\\-]+) (?<Name>.*) \\((?<Guid>[a-f0-9]{32})\\) has been kicked by BattlEye: (?<Reason>.*)$");
    private readonly string _content;
    private readonly int _id;
    private readonly DateTime _received;
    private readonly Match _match;

    public Message.MessageType Type
    {
      get
      {
        return this._type;
      }
    }

    public string Content
    {
      get
      {
        return this._content;
      }
    }

    public int Id
    {
      get
      {
        return this._id;
      }
    }

    public DateTime Received
    {
      get
      {
        return this._received;
      }
    }

    public Match Match
    {
      get
      {
        return this._match;
      }
    }

    public Message(string message, int id)
    {
      this._content = message;
      this._id = id;
      this._received = DateTime.Now;
      if (this._chatRegex.IsMatch(this._content))
      {
        this._type = Message.MessageType.Chat;
        this._match = this._chatRegex.Match(this._content);
      }
      if (this._connectedIpRegex.IsMatch(message))
      {
        this._type = Message.MessageType.ConnectIP;
        this._match = this._connectedIpRegex.Match(this._content);
      }
      if (this._connectedGuidRegex.IsMatch(message))
      {
        this._type = Message.MessageType.ConnectGUID;
        this._match = this._connectedGuidRegex.Match(this._content);
      }
      if (this._connectedLegacyGuidRegex.IsMatch(message))
      {
        this._type = Message.MessageType.ConnectLegacyGUID;
        this._match = this._connectedLegacyGuidRegex.Match(this._content);
      }
      if (this._kickRegex.IsMatch(message))
      {
        this._type = Message.MessageType.Kick;
        this._match = this._kickRegex.Match(this._content);
      }
      if (!this._disconnectedRegex.IsMatch(message))
        return;
      this._type = Message.MessageType.Disconnect;
      this._match = this._disconnectedRegex.Match(this._content);
    }

    public byte[] GetMessageBytes()
    {
      byte[] numArray = new byte[this._content.Length * 2];
      Buffer.BlockCopy((Array) this._content.ToCharArray(), 0, (Array) numArray, 0, numArray.Length);
      return numArray;
    }

    public enum MessageType
    {
      Log,
      Chat,
      ConnectIP,
      ConnectGUID,
      ConnectLegacyGUID,
      Disconnect,
      Kick,
    }
  }
}
