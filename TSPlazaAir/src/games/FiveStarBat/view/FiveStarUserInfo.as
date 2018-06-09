package games.FiveStarBat.view
{
	import cx.gamebase.sturuct.tagUserInfoHead;
	import cx.gamebase.view.GameUserViewBase;
	
	import games.FiveStarBat.model.FiveStarBatModel;
	import games.FiveStarBat.utils.ConstCmd;

	public class FiveStarUserInfo extends GameUserViewBase
	{
		private var _model : FiveStarBatModel;
		public function FiveStarUserInfo()
		{
			_model = FiveStarBatModel._getInstance();
		}
		override public function UpdateUserCome(userInfo:tagUserInfoHead, wViewChairID:uint):Boolean
		{
			super.UpdateUserCome(userInfo,wViewChairID);
			
			return true;
		}
		/**
		 * 用户状态 :(在线/断线等信息)
		 **/
		override public function UpdateUserStatus(userID:int, cbStatus:uint, wTableID:int, wViewChairID:uint):Boolean
		{
			if(cbStatus == ConstCmd.GS_PLACE_JETTON||cbStatus == ConstCmd.GS_GAME_END) return true;
			return true;
		}
		override public function UpdateGameScore(score:Number, wViewChairID:uint):void
		{
			super.UpdateGameScore(score,wViewChairID);
		}
	}
}