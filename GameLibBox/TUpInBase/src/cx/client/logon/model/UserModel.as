package cx.client.logon.model
{
	import cx.client.logon.model.vo.UserInfo;
	import cx.gamebase.events.GameEvent;
	import cx.gamebase.sturuct.CMD_GR_UserStatus;
	import cx.gamebase.sturuct.tagUserInfoHead;
	import cx.gamebase.sturuct.tagUserStatus;
	
	import t.cx.air.TConst;
	import t.cx.air.controller.Controller;
	import t.cx.air.utils.SystemEx;

	public class UserModel
	{
		private static var _instance : UserModel;
		public static function _getInstance() : UserModel
		{
			return _instance==null ? _instance = new UserModel() : _instance;
		}
		
		private var _aide : Boolean = false;
		public function get Aide() : Boolean
		{
			return _aide;
		}
		public function set Aide(value : Boolean) : void
		{
			_aide = value;
		}
		
		private var _selfUserInfo	: UserInfo;
		public function get selfInfo() : UserInfo
		{
			return _selfUserInfo;
		}
		public function get selfID() : int
		{
			if( _selfUserInfo == null ) return 0;
			return _selfUserInfo.dwUserID;
		}
		
		private var _playerMap : Vector.<tagUserInfoHead>;
		private var _statusMap : Vector.<CMD_GR_UserStatus>;
		
		public function UserModel()
		{
			_selfUserInfo = new UserInfo();
			_playerMap = new Vector.<tagUserInfoHead>();
			_statusMap = new Vector.<CMD_GR_UserStatus>();
		}
		public function InsertPlayer(pUserHead : tagUserInfoHead) : Boolean
		{
			_playerMap.push(pUserHead);
			
			//构建玩家状态
			if( GetStatusByID(pUserHead.dwUserID) == null )
			{
				var pStatus : CMD_GR_UserStatus = new CMD_GR_UserStatus();
				pStatus.dwUserID = pUserHead.dwUserID;
				pStatus.wTableID = pUserHead.wTableID;
				pStatus.wChairID = pUserHead.wChairID;
				pStatus.cbUserStatus = pUserHead.cbUserStatus;
				InsertStatus(pStatus);
			}
			return true;
		}
		public function UpdateUserInfo(obj : Object) : void
		{
			if( _selfUserInfo == null ) return;
			if(obj.hasOwnProperty('score')) {
				_selfUserInfo.lScore = obj.score;
				if(SelfHead != null) {SelfHead.UserScoreInfo.lScore = obj.score; }
			}
			if(obj.hasOwnProperty('bankScore')) {
				_selfUserInfo.lBankScore = obj.bankScore;
			}
			if(obj.hasOwnProperty('face')) {
				_selfUserInfo.wFaceID = obj.face;
				if(SelfHead != null) {SelfHead.wFaceID = obj.face; }
			}
			if(obj.hasOwnProperty('exp')) {
				_selfUserInfo.dwExperience = obj.exp;
				if(SelfHead != null) {SelfHead.UserScoreInfo.lExperience = obj.exp; }
			}
			if(obj.hasOwnProperty('status')) {
				_selfUserInfo.cbUserStatus = obj.status;
				if(SelfHead != null) {SelfHead.cbUserStatus = obj.status; }
			}
			
			Controller.dispatchEvent(GameEvent.USER_SCORE,2);
		}
		public function Remove(userID : int) : Boolean
		{
			var i : int = 0;
			for( i = 0;i<_playerMap.length;i++ )
			{
				if(_playerMap[i]!= null && _playerMap[i].dwUserID == userID)
				{
					_playerMap[i].Destroy();
					_playerMap.splice(i,1);
					break;
				}
			}
			for( i = 0;i<_statusMap.length;i++ )
			{
				if(_statusMap[i]!= null && _statusMap[i].dwUserID == userID)
				{
					_statusMap.splice(i,1);
					break;
				}
			}
			return true;
		}
		public function RemoveAll() : Boolean
		{
			var i : int = 0;
			
			var selfInfoHead : tagUserInfoHead = GetUser(selfID);
			if(_playerMap != null) {
				for( i = 0;i<_playerMap.length;i++ )
				{
					if(_playerMap[i].dwUserID != _selfUserInfo.dwUserID)
					{
						_playerMap[i].Destroy();
						_playerMap[i] = null;
					}
				}
			}
			_playerMap = new Vector.<tagUserInfoHead>();
			InsertPlayer(selfInfoHead);
			
			var selStatus : CMD_GR_UserStatus = GetStatusByID(selfID);
			if(_statusMap!=null) {
				for(i = 0;i<_statusMap.length;i++)
				{
					if(_statusMap[i].dwUserID != _selfUserInfo.dwUserID)
					{
						_statusMap[i] = null;
					}
				}
			}
			_statusMap = new Vector.<CMD_GR_UserStatus>();
			InsertStatus(selStatus);
			SystemEx._froceGC();
			return true;
		}
		
		public function GetUser(userID : Number) : tagUserInfoHead
		{
			if(_playerMap == null) return null;
			for each(var pUserHead : tagUserInfoHead in _playerMap)
			{
				if(pUserHead != null && pUserHead.dwUserID == userID)
				{
					return pUserHead;
				}
			}
			return null;
		}
		
		public function get SelfHead() : tagUserInfoHead
		{
			return GetUser(selfID);
		}
		
		
		public function InsertStatus(status : CMD_GR_UserStatus) : CMD_GR_UserStatus
		{
			var oldStatus : CMD_GR_UserStatus = GetStatusByID(status.dwUserID);
			
			if(oldStatus == null) {
				_statusMap.push(status);
			}else {
				var resultStatus : CMD_GR_UserStatus = oldStatus.Clone();
				oldStatus.cbUserStatus 	= status.cbUserStatus;
				oldStatus.wTableID 		= status.wTableID;
				oldStatus.wChairID 		= status.wChairID;
			}
			return resultStatus;
		}
		public function GetStatusByID(dwUserID : int) : CMD_GR_UserStatus
		{
			for each(var pStatus : CMD_GR_UserStatus in _statusMap)
			{
				if(pStatus != null && pStatus.dwUserID == dwUserID) { return pStatus; }
			}
			return null;
		}
		
		public function UpdateStatus(status : CMD_GR_UserStatus) : CMD_GR_UserStatus
		{
			var oldStatus : CMD_GR_UserStatus = GetStatusByID(status.dwUserID);
			var resultOldStatus : CMD_GR_UserStatus 
			if(oldStatus != null) {
				resultOldStatus = oldStatus.Clone();
				oldStatus.cbUserStatus 	= status.cbUserStatus;
				oldStatus.wTableID 		= status.wTableID;
				oldStatus.wChairID 		= status.wChairID;
			}else {
				_statusMap.push(status);
			}
			//更新用户状态
			var updateUser : tagUserInfoHead = GetUser(status.dwUserID);
			if(updateUser != null)
			{
				updateUser.cbUserStatus = status.cbUserStatus;
				updateUser.wChairID 	= status.wChairID;
				updateUser.wTableID 	= status.wTableID;
			}
			return resultOldStatus;
		}
		
		public function RemoveStatus(userID : int) : CMD_GR_UserStatus
		{
			for( var i : uint = 0;i<_statusMap.length;i++ )
			{
				if(_statusMap[i]!= null && _statusMap[i].dwUserID == userID)
				{
					var result : CMD_GR_UserStatus = _statusMap.splice(i,1)[0];
					return result;
				}
			}
			return null;
		}
		
		public function GetUsersByTable(tableID : int) : Array
		{
			var usersArrs : Array = new Array();
			for each(var pUserHead : tagUserInfoHead in _playerMap)
			{
				if( pUserHead && pUserHead.cbUserStatus>TConst.US_FREE && pUserHead.wTableID == tableID)
				{
					usersArrs.push(pUserHead);
				}
			}
			return usersArrs;
		}
		public function Destroy() : void
		{
			var i : int = 0;
			if(_playerMap != null) {
				for( i = 0;i<_playerMap.length;i++ )
				{
					_playerMap[i].Destroy();
					_playerMap[i] = null;	
				}
			}
			_playerMap = new Vector.<tagUserInfoHead>();
			if(_statusMap!=null) {
				for(i = 0;i<_statusMap.length;i++) { _statusMap[i] = null;	 }
			}
			_statusMap = new Vector.<CMD_GR_UserStatus>();
			SystemEx._froceGC();
		}
	}
}