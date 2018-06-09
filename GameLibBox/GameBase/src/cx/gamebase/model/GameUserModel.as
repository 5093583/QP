package cx.gamebase.model
{
	import cx.gamebase.Interface.IDestroy;
	import cx.gamebase.Interface.IUserViewSink;
	import cx.gamebase.events.GameEvent;
	import cx.gamebase.sturuct.CMD_GR_UserScore;
	import cx.gamebase.sturuct.CMD_GR_UserStatus;
	import cx.gamebase.sturuct.tagUserInfoHead;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import t.cx.air.TConst;
	import t.cx.air.TDas;
	import t.cx.air.controller.Controller;
	import t.cx.air.controller.TEvent;
	import t.cx.air.utils.HashMap;

	public class GameUserModel implements IDestroy
	{
		protected static var _instance : GameUserModel;
		public static function GetInstance() : GameUserModel
		{
			return _instance == null ? (_instance = new GameUserModel()):_instance;
		}
		
		[Bindable]
		public var	_selfID				: int = 0;		
		public function get selfID() 	: int
		{
			return _selfID;
		}
		public function get count() : int
		{
			return _playUsers.size();
		}
		//用户信息
		public var _userMaps : HashMap;
		//游戏玩家
		public var _playUsers  : HashMap;
		//旁观玩家
		public var _lookonUsers: HashMap;
		//用户信息回调
		private var _userViewSink : IUserViewSink;
		public function SetUserViewSink(value : IUserViewSink) : void
		{
			_userViewSink = value;
		}
		
		public function GameUserModel()
		{
			_userMaps	= new HashMap();
			_playUsers	= new HashMap();
			_lookonUsers= new HashMap();
			Controller.addEventListener(GameEvent.USER_COME,OnUserComeEvent);
			Controller.addEventListener(GameEvent.USER_STATUS,OnUserStatusEvent);
			Controller.addEventListener(GameEvent.USER_SCORE,OnUserScoreEvent);
		}
		/**----------------------------------------------------------
		 * 
		 * 保护函数
		 * 
		 * ----------------------------------------------------------*/
		protected function InsertUser(userInfo : tagUserInfoHead) : Boolean
		{
			_userMaps.put(userInfo.dwUserID,userInfo);
			if( _selfID == 0 ) { _selfID = userInfo.dwUserID; }
			return true;
		}
		protected function RemoveUser(UserID : int) : tagUserInfoHead
		{
			_lookonUsers.remove(UserID);
			_playUsers.remove(UserID);
			
			return _userMaps.remove(UserID);
		}
		protected function UpdateUserStatus(status : CMD_GR_UserStatus) : Boolean
		{
			var user : tagUserInfoHead = _userMaps.getValue(status.dwUserID);
			if(user == null) return false;
			
			user.cbUserStatus = status.cbUserStatus;
			user.wTableID = status.wTableID;
			user.wChairID = status.wChairID;
			
			var oldStatus : uint = user.cbUserStatus;
			if(status.cbUserStatus != TConst.US_LOOKON) {
				if(oldStatus == TConst.US_LOOKON) {
					_lookonUsers.remove(user.dwUserID);
				}
				_playUsers.put(user.dwUserID,user);
			}else {
				if(oldStatus != TConst.US_LOOKON) {
					_playUsers.remove(user.dwUserID);
				}
				_lookonUsers.put(user.dwUserID,user);
			}
			_userMaps.put(user.dwUserID,user);
			return true;
		}
		/**
		 * 命令消息
		 * */
		protected function OnUserComeEvent(e : TEvent) : void
		{
			var userInfo : tagUserInfoHead = e.nWParam as tagUserInfoHead;
			switch(e.m_nMsg)
			{
				case 1:
				case 2:
				{
					InsertUser(userInfo);
					if(userInfo.cbUserStatus > TConst.US_SIT) {
						if(userInfo.cbUserStatus != TConst.US_LOOKON) {
							_playUsers.put(userInfo.dwUserID,userInfo);
						}else {
							_lookonUsers.put(userInfo.dwUserID,userInfo);	
						}
					}
					if(_userViewSink != null) { _userViewSink.UpdateUserCome(userInfo,SwitchViewChairID(userInfo.wChairID)); }
					break;
				}
			}
		}
		protected function OnUserStatusEvent(e : TEvent) : void
		{
			var status : CMD_GR_UserStatus;
			if(e.nWParam != null) {
				status = e.nWParam as CMD_GR_UserStatus;
			}
			var oldStatus : CMD_GR_UserStatus;
			if(e.nLParam != null) {
				oldStatus = e.nLParam  as CMD_GR_UserStatus;
			}
			if(status.cbUserStatus <= TConst.US_FREE) {
				RemoveUser(status.dwUserID);
			}else {
				UpdateUserStatus(status);
			}
			if( _userViewSink != null ) {
				_userViewSink.UpdateUserStatus(status.dwUserID,status.cbUserStatus,status.wTableID,SwitchViewChairID(status.wChairID));
			}
		}
		protected function OnUserScoreEvent(e : TEvent) : void
		{
			switch( e.m_nMsg )
			{
				case 1:
				{
					var RecvScore : CMD_GR_UserScore = e.nWParam as CMD_GR_UserScore;
					if(_userMaps == null || RecvScore == null) return;
					var userInfo : tagUserInfoHead = _userMaps.get(RecvScore.dwUserID);
					if(userInfo == null || userInfo.UserScoreInfo) return;
					userInfo.UserScoreInfo.lScore = RecvScore.UserScore.lScore;
					if(_userViewSink != null) { _userViewSink.UpdateUserScore(RecvScore.dwUserID,SwitchViewChairID(userInfo.wChairID),RecvScore.UserScore.lScore); }
					break;
				}
			}
		}
		/**----------------------------------------------------------
		 * 
		 * 公有函数
		 * 
		 * ----------------------------------------------------------*/
		
		/**
		 * 根据用户ID获取用户信息
		 * */
		public function GetUserByID(userID : int) : tagUserInfoHead
		{
			if(_userMaps == null) return null;
			if(!_userMaps.containsKey(userID)) { return null }
			return _userMaps.getValue(userID) as tagUserInfoHead;
		}
		public function GetUserByChair(wChairID : uint) : tagUserInfoHead
		{
			if(_playUsers == null) return null;
			var arrs : Array = _playUsers.values();
			var result : tagUserInfoHead;
			for(var i : uint = 0;i<arrs.length;i++)
			{
				result = arrs[i];
				if(result != null && result.wChairID == wChairID)
				{
					return result;
				}
			}
			return null;
		}
		public function GetUserList() : Array
		{
			return _userMaps.values();
		}
		/**
		 * 获取自己的ID
		 * */
		public function GetMeChairID() : uint
		{
			var userInfo : tagUserInfoHead = GetSelfData();
			if(userInfo == null) return 2048;
			return  userInfo.wChairID;
		}
		/**
		 * 获取自己的用户信息
		 * */
		public function GetSelfData() : tagUserInfoHead
		{
			return GetUserByID(selfID);
		}
		/**
		 * 删除
		 * */
		public function Destroy() : Boolean
		{
			Controller.removeEventListener(GameEvent.USER_COME,OnUserComeEvent);
			Controller.removeEventListener(GameEvent.USER_STATUS,OnUserStatusEvent);
			Controller.removeEventListener(GameEvent.USER_SCORE,OnUserScoreEvent);
			_userMaps.eachValue(onDestroyUserInfo);
			_userMaps = null;
			_playUsers.clear();
			_playUsers = null;
			_lookonUsers.clear();
			_lookonUsers = null;
			_instance = null;
			_userViewSink = null;
			_selfID = 0;
			return true;
		}
		private function onDestroyUserInfo(userInfo : tagUserInfoHead) : void
		{
			if(userInfo != null)
			{
				userInfo.Destroy();
				userInfo = null;
			}
		}
		
		/**
		 * 视图转换
		 * */
		public function SwitchViewChairID(wChairID : uint) : uint
		{
			if(wChairID == TConst.INVALID_CHAIR) return wChairID;
			var wChairCount : uint= GameAttribute.GetInstance().playerCount;
			var pMeData : tagUserInfoHead = GetSelfData();
			if(pMeData == null)
			{
				return 0;
			}
			var wViewChairID:uint=(wChairID+wChairCount-pMeData.wChairID);
			switch( wChairCount )
			{
				case 2 :
				{
					wViewChairID+=1; //自己坐在1的位置
					break;
				};
				case 3 :
				{
					wViewChairID+=1;//自己坐在1的位置
					break;
				};
				case 4 :
				{
					wViewChairID+=2;//自己坐在2的位置
					break;
				};
				case 5 :
				{
					wViewChairID+=2;//自己坐在2的位置
					break;
					
				};
				case 6 :
				{
					wViewChairID+=3;//自己坐在3的位置
					break;
				};
				case 7 :
				{
					wViewChairID+=3;//自己坐在3的位置
					break;
					
				};
				case 8 :
				{
					wViewChairID+=3;//自己坐在3的位置
					break;
				}
				case 9:
				{
					wViewChairID+=0;//自己坐在3的位置
					break;
				}
			};
			return wViewChairID % wChairCount;
		}
	}
}