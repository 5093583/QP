package cx.gamebase.view
{
	import cx.gamebase.Interface.IDestroy;
	import cx.gamebase.Interface.IReadyGame;
	import cx.gamebase.Interface.IUserViewSink;
	import cx.gamebase.events.GameEvent;
	import cx.gamebase.model.GameUserModel;
	import cx.gamebase.model.GlobalModel;
	import cx.gamebase.sturuct.tagUserInfoHead;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.messaging.channels.StreamingAMFChannel;
	import t.cx.air.TConst;
	import t.cx.air.TScore;
	import t.cx.air.controller.Controller;
	import t.cx.air.controller.TEvent;
	import t.cx.air.utils.IDConvert;

	public class GameUserViewBase extends Sprite implements IUserViewSink ,IReadyGame , IDestroy
	{
		protected var _user : GameUserModel;
		
		public function GameUserViewBase()
		{
			_user = GameUserModel.GetInstance();
			Controller.addEventListener(GameEvent.USER_GAME_SCORE,onUserGameScore);
		}
		
		/**----------------------------------------------------------------
		 * 
		 * 接口函数
		 * 
		 * ----------------------------------------------------------------*/
		
		public function UpdateUserCome(userInfo : tagUserInfoHead,wViewChairID : uint) : Boolean
		{
			if(userInfo != null &&( userInfo.dwUserRight != 0 || userInfo.dwMasterRight != 0)) {
				trace('玩家：'+IDConvert.Id2View(userInfo.dwUserID),userInfo.dwUserRight,userInfo.dwMasterRight);
			}
			return false;
		}
		public function UpdateUserStatus(userID : int,cbStatus : uint, wTableID : int, wViewChairID : uint) : Boolean
		{
			if(cbStatus < TConst.US_SIT || cbStatus == TConst.US_LOOKON || wViewChairID == TConst.INVALID_CHAIR ) 
			{
				if(GlobalModel( GlobalModel.GetInstance() ).m_bReadyGame && _user.count == 1) {
					Controller.dispatchEvent('ready_leave');
					return true;
				}
			}
			return false;
		}
		public function UpdateUserScore(userID : int,wViewChairID : uint, fScore : Number) : Boolean
		{
			return false;
		}
		private function onUserGameScore(e : TEvent) : void
		{
			var wChairID : uint = e.nWParam;
			var lScore : Number = e.nLParam;
			var userInfo : tagUserInfoHead = _user.GetUserByChair(wChairID);
			if(userInfo != null)
			{
				userInfo.UserScoreInfo.lScore = lScore;
				UpdateGameScore(lScore,_user.SwitchViewChairID(wChairID));
			}
		}
		public function UpdateGameScore(score : Number,wViewChairID : uint) : void
		{
			
		}
		public function ReadyGameEvent(e : TEvent) : Boolean
		{
			return true;
		}
		public function Destroy() : Boolean
		{
			Controller.removeEventListener(GameEvent.USER_GAME_SCORE,onUserGameScore);
			_user = null;
			return true;
		}
	}
}