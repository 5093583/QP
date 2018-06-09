package games.cowlord.view
{
	import cx.gamebase.sturuct.tagUserInfoHead;
	import cx.gamebase.view.GameUserViewBase;
	
	import flash.text.TextField;
	
	import games.cowlord.model.CowModle;
	import games.cowlord.utils.ConstCMD;
	
	import t.cx.air.TConst;
	import t.cx.air.TScore;
	import t.cx.air.utils.IDConvert;
	
	public class CowUserView extends GameUserViewBase
	{
		private var  _cowModle:CowModle;
		public function CowUserView()
		{
			super();
			_cowModle = CowModle._getInstance();
		}
		/**
		 * 用户进入游戏房间
		 * 	(如：用户ID，头像，昵称等信息)
		 **/
		override public function UpdateUserCome(userInfo:tagUserInfoHead, wViewChairID:uint):Boolean
		{
			super.UpdateUserCome(userInfo,wViewChairID);
			if(userInfo.dwUserID == _user.selfID){
				theIDTxt.text = IDConvert.Id2View(userInfo.dwUserID).toString();
				theIPTxt.text = userInfo.ip;
				_cowModle.m_wUserGold = _cowModle.m_User.GetUserByID(userInfo.dwUserID).UserScoreInfo.lScore;//自己手中的金币
				theSTxt.text =  TScore.toStringEx(_cowModle.m_User.GetUserByID(userInfo.dwUserID).UserScoreInfo.lScore);
				theCJTxt.text = TScore.toStringEx(_cowModle.m_wUserScore);
			}
			return true;
		}
		/**
		 * 用户状态 :(在线/断线等信息)
		 **/
		override public function UpdateUserStatus(userID:int, cbStatus:uint, wTableID:int, wViewChairID:uint):Boolean
		{
			if(cbStatus == ConstCMD.GS_GAME_END||cbStatus == ConstCMD.GS_PLACE_JETTON) return true;
			return true;
		}
		/**
		 * 用户分数
		 * (游戏积分，金币等信息)
		 **/
		override public function UpdateGameScore(score:Number, wViewChairID:uint):void
		{
			super.UpdateGameScore(score,wViewChairID);
			trace('(游戏积分，金币等信息)');
		}
		private function get theIDTxt():TextField
		{
			return this['IDTxt'];
		}
		private function get theIPTxt():TextField
		{
			return this['IPTxt'];
		}
		public function get theSTxt():TextField
		{
			return this['STxt'];
		}
		public function get theCJTxt():TextField
		{
			return this['CJTxt'];
		}
		override public function Destroy():Boolean
		{
			return true;
		}
	}
}