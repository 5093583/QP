package cx.client.logon.model
{
	import cx.client.logon.model.events.MsgEvent;
	import cx.client.logon.model.events.RoomEvents;
	import cx.client.logon.model.struct.CMD_GP_GetRoomList;
	import cx.client.logon.model.struct.CMD_GP_GetRoomList2;
	import cx.client.logon.model.struct.CMD_MSG_RoomlistUpdate;
	import cx.client.logon.model.struct.LGCmd;
	import cx.client.logon.model.vo.KindOption;
	import cx.client.logon.view.message.Message;
	import cx.gamebase.sturuct.tagMatch;
	import cx.net.Interface.IClientSocket;
	import cx.net.enum.enSocketState;
	
	import flash.system.System;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import t.cx.air.TConst;
	import t.cx.air.TDas;
	import t.cx.air.controller.Controller;
	import t.cx.air.utils.HashMap;
	import t.cx.cmd.struct.tagGameKind;
	import t.cx.cmd.struct.tagGameServer;
	import t.cx.cmd.struct.tagGameType;

	public class ServerList
	{
		private static var _instance : ServerList;
		public static function _getInstance() : ServerList
		{
			return _instance==null ? _instance = new ServerList() : _instance;
		}
		
		public var _bGameOpen 		: Boolean = false;
		private var _MatchVector 	: Vector.<tagMatch>;
		private var _kindVector 	: Vector.<tagGameKind>;
		private var _serverVector 	: Vector.<tagGameServer>;
		private var _optionVector 	: Vector.<KindOption>;
		public function get kindOption() : Array
		{
			if(_optionVector == null) { _optionVector = new Vector.<KindOption>(); }
			var arrs : Array = new Array();
			for each(var kindop : KindOption in _optionVector)
			{
				if(kindop != null) { arrs.push(kindop); }
			}
			return arrs;
		}
		private var _loadRoomList : Boolean = false;
		public function get bLoading() : Boolean
		{
			return _loadRoomList;
		}
		
		
		private var _wSendUserID:Boolean = false;
		public function set m_sendUserID( val : Boolean ) : void
		{
			_wSendUserID = val;
		}
		
		private var _wCurrentKind : int
		public function get m_wCurrentKind() : int
		{
			return _wCurrentKind;
		}
		public function set m_wCurrentKind( val : int ) : void
		{
			if(val > 0 && (_wCurrentKind != val||GetServerList(val).length == 0))
			{
				var option : KindOption = GetKindOption(val);
				if(option == null) return;
				_wCurrentKind = val;
				if(!option.bRequestRoom||GetServerList(_wCurrentKind).length == 0)
				{
					Controller.dispatchEvent(RoomEvents.ROOMLIST_EVENT,RoomEvents.ROOM_LOADING,val);
					_loadRoomList = true;
					LogonNet._getInstance().GetRoomList(_wCurrentKind,onGetRoomList);
					return;
				}else {
					Controller.dispatchEvent(RoomEvents.ROOMLIST_EVENT,RoomEvents.ROOM_SELECT,val);
				}
			}
			else if(_wCurrentKind == val)
			{
//				var serverArr : Array= GetServerList( val );
//				if(!serverArr.length)
//				{
//					_loadRoomList = true;
//					LogonNet._getInstance().GetRoomList(_wCurrentKind,onGetRoomList);
//				}
//				else
//					Controller.dispatchEvent(RoomEvents.ROOMLIST_EVENT,RoomEvents.ROOM_SELECT,val);
					
				Controller.dispatchEvent(RoomEvents.ROOMLIST_EVENT,RoomEvents.ROOM_SELECT,val);
			}
				
		}
		//coverflow
		private var _coverflowW : Number;
		public function get CoverflowW() : Number
		{
			return _coverflowW;
		}
		private var _coverflowH : Number;
		public function get CoverflowH() : Number
		{
			return _coverflowH;
		}
		private var _coverflowRef : Boolean;
		public function get CoverflowRef() : Boolean
		{
			return _coverflowRef;
		}
		public function ServerList()
		{
			init();
		}
		public function init() : void
		{
			if(_optionVector == null) { _optionVector = new Vector.<KindOption>(); }
			var xml : XML = new XML(TDas._getStringItem(TConst.GAME_OPTION,20480));
			_coverflowW = xml.@coverFlowW;
			_coverflowH = xml.@coverFlowH;
			_coverflowRef = xml.@coverFlowRef;
			
			var list : XMLList = xml.child('item');
			_wCurrentKind = -1;
			for(var i : uint = 0;i<list.length();i++) 
			{
				var option : KindOption = new KindOption(list[i]);
				if(option != null)
				{
					var gameKind : tagGameKind = new tagGameKind();
					gameKind.wKindID = option.wKindID;
					gameKind.dwMaxVersion = 0;
					gameKind.dwOnLineCount = 0;
					gameKind.szKindIcon = '';
					gameKind.szKindName = option.name;
					gameKind.szProcessName = option.exe;
					gameKind.wSortID = option.index;
					InsertKind(gameKind);
					_optionVector.push(option);
				}
			}
			System.disposeXML(xml);
		}
		private function existServerList(server : tagGameServer) : Boolean
		{
			if(server == null) return true;
			if(_serverVector==null)return true;
			for each(var tServer : tagGameServer in _serverVector)
			{
				if(tServer != null && ( tServer.wServerID == server.wServerID || tServer.wServerPort==server.wServerPort)) { return true; }
			}
			return false;		
		}
		public function InsertKind(kind : tagGameKind) : void
		{
			if(_kindVector == null) { _kindVector = new Vector.<tagGameKind>(); }
			_kindVector.push(kind);
		}
		public function GetKind(wKindID : int) : tagGameKind
		{
			if(_kindVector == null) { _kindVector = new Vector.<tagGameKind>(); }
			
			for each(var kind : tagGameKind in _kindVector)
			{
				if(kind != null && kind.wKindID == wKindID)
				{
					return kind;
				}
			}
			return null;
		}
		
		public function InsertServer(server : tagGameServer) : void
		{
			if(_serverVector == null) { _serverVector = new Vector.<tagGameServer>(); }
			if(existServerList(server)) return;
			_serverVector.push(server);
		}
		public function LoadServerComplete() : void
		{
			_loadRoomList = false;
			var option : KindOption = GetKindOption(_wCurrentKind);
			if(option)
			{
				option.bRequestRoom = true;
				Controller.dispatchEvent(RoomEvents.ROOMLIST_EVENT,RoomEvents.ROOM_UPDATE,_wCurrentKind);
			}
		}
		public function UpdateServer(server : CMD_MSG_RoomlistUpdate) : Boolean
		{
			if(server == null) return false;
			for each(var pServer : tagGameServer in _serverVector)
			{
				if(pServer != null && pServer.wServerID == server.wServerID)
				{
					pServer.dwOnLineCount = server.dwOnLineCount;
					Controller.dispatchEvent(MsgEvent.MSG_UPDATE_SERVER,1,pServer);
					break;
				}
			}
			return true;
		}
		public function GetServer(wServerID : int) : tagGameServer
		{
			if(_serverVector == null) { _serverVector = new Vector.<tagGameServer>(); }
			for each(var server : tagGameServer in _serverVector)
			{
				if(server != null && server.wServerID == wServerID)
				{
					return server;
				}
			}
			return null;
		}
		public function GetServerList(wKindID : int) : Array
		{
			var servers : Array = new Array();
			for each(var server : tagGameServer in _serverVector)
			{
				if(server != null && server.wKindID == wKindID) { servers.push(server); }
			}
			return servers;
		}
		public function GetKindOption(wKindID : int) : KindOption
		{
			if(_optionVector == null) { _optionVector = new Vector.<KindOption>(); }
			for each(var option : KindOption in _optionVector)
			{
				if(option != null && option.wKindID == wKindID)
				{
					return option;
				}
			}
			return null;
		}
		
		private function onGetRoomList(pClientSocket : IClientSocket,szError : String = '') : void
		{
			if(pClientSocket.GetConnectState() == enSocketState.en_Connected) 
			{
				if(_wSendUserID)
				{
					var SendList2 : CMD_GP_GetRoomList2 = new CMD_GP_GetRoomList2();
					SendList2.wKindID = _wCurrentKind;
					SendList2.wUserID = UserModel._getInstance().selfID;
					pClientSocket.SendData(LGCmd.MDM_GP_SERVER_LIST,LGCmd.SUB_GP_LIST_SERVER,SendList2.toByteArray(),SendList2.size);
				}
				else
				{
					var SendList : CMD_GP_GetRoomList = new CMD_GP_GetRoomList();
					SendList.wKindID = _wCurrentKind;
					
					pClientSocket.SendData(LGCmd.MDM_GP_SERVER_LIST,LGCmd.SUB_GP_LIST_SERVER,SendList.toByteArray(),SendList.size);
				}
			}
			else 
			{
				Message.show(szError);
			}
		}
		//-----比赛
		public function InsertMatch(match : tagMatch) : Boolean
		{
			if(_MatchVector == null) _MatchVector = new Vector.<tagMatch>();
			var oldMatch : tagMatch = ExistMatchByTaskID(match.dwTaskID);
			if(oldMatch == null)
			{
				_MatchVector.push(match);
			}else {
				oldMatch.dwStartDate = match.dwStartDate;
				oldMatch.dwEndDate = match.dwEndDate;
			}
			return true;
		}
		public function CheckTaskID(arrs : Array) : void
		{
			if(_MatchVector == null) return;
			var match : tagMatch;
			for(var i : int = _MatchVector.length-1;i>=0;i--)
			{
				match = _MatchVector[i];
				if(match != null && arrs.indexOf(match.dwTaskID) == -1) { _MatchVector.splice(i,1); }
			}
		}
		public function ExistMatchByTaskID(taskID : int) : tagMatch
		{
			if(_MatchVector == null) return null;
			for each(var match : tagMatch in _MatchVector)
			{
				if(match != null && match.dwTaskID == taskID) { return match; }
			}
			return null;
		}
		public function ExistMatchByServerID(ServerID : int) : tagMatch
		{
			if(_MatchVector == null) return null;
			for each(var match : tagMatch in _MatchVector)
			{
				if(match != null && match.wServerID == ServerID) { return match; }
			}
			return null;
		}
	}
}