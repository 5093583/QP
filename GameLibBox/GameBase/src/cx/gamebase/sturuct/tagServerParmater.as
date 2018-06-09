package cx.gamebase.sturuct
{
	import t.cx.cmd.struct.tagGameKind;
	import t.cx.cmd.struct.tagGameServer;

	public class tagServerParmater
	{
		private var _wServerID 	: int;
		
		public function get wServerID() : int
		{
			return _wServerID;
		}
		public function tagServerParmater(serverID : int)
		{
			_wServerID = serverID;
		}
	}
}