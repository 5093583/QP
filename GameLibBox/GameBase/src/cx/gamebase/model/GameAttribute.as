package cx.gamebase.model
{
	import cx.gamebase.Interface.IDestroy;
	import cx.gamebase.events.TCPEvent;
	
	import t.cx.air.controller.Controller;
	import t.cx.air.controller.TEvent;
	import t.cx.cmd.struct.tagGameKind;
	import t.cx.cmd.struct.tagGameServer;

	public class GameAttribute implements IDestroy
	{
		protected static var _instance : GameAttribute;
		public static function GetInstance() : GameAttribute
		{
			return _instance == null ? ( _instance = new GameAttribute() ) : _instance;
		}
		
		/**--------------------------------------------------------------------
		 * 变量定义
		 * --------------------------------------------------------------------*/
		private var _playerCount : uint;
		public function set playerCount( value : uint ) : void
		{
			_playerCount = value;
		}
		public function get playerCount() : uint
		{
			return _playerCount;
		}
		
		private var _server : tagGameServer;
		public function get Server() : tagGameServer
		{
			return _server;
		}
		private var _kind : tagGameKind;
		public function get Kind() : tagGameKind
		{
			return _kind;
		}
		/**
		 * 删除
		 * */
		public function Destroy() : Boolean
		{
			Controller.removeEventListener(TCPEvent.GAME_ATTRIBUTE,OnGameAttributeEvent);
			_playerCount = 0;
			_server = null;
			_kind = null;
			return true;
		}
		
		/**--------------------------------------------------------------------
		 * 函数定义
		 * --------------------------------------------------------------------*/
		public function GameAttribute()
		{
			Controller.addEventListener(TCPEvent.GAME_ATTRIBUTE,OnGameAttributeEvent);
		}
		
		public function OnGameAttributeEvent(e : TEvent) : void
		{
			Controller.removeEventListener(TCPEvent.GAME_ATTRIBUTE,OnGameAttributeEvent);
			_server = e.nWParam as tagGameServer;
			_kind = e.nLParam as tagGameKind;
		}
	}
}