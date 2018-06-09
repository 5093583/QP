package cx.client.logon.model
{
	import cx.net.NetConst;
	public class LogonModel
	{
		private static var _instance : LogonModel;
		public static function _GetInstance() : LogonModel
		{
			return _instance == null ? _instance = new LogonModel() : _instance;
		}
		
		private var _LogonNet 			: LogonNet;
		public function get MainNet() 	: LogonNet
		{
			return _LogonNet;
		}
		private var _msgNet				: MessageNet;
		public function get msgNet()	: MessageNet
		{
			return _msgNet;
		}
		
		private var _ServerList 		: ServerList;
		private var _userModel 			: UserModel;
		public function get user() 		: UserModel
		{
			return _userModel;
		}
		
		public function LogonModel()
		{
		}
		public function Init() : void
		{
			_LogonNet 	= LogonNet._getInstance();
			_msgNet		= MessageNet._getInstance();
			_ServerList = ServerList._getInstance();
			_userModel 	= UserModel._getInstance();
		}
	}
}