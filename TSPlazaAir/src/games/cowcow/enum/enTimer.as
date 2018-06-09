package games.cowcow.enum
{
	/**
	 * ...
	 * @author xf
	 */
	public class enTimer 
	{
	
		//定时器状态
		public static const TT_SHOW					: uint	= 1;									//显示
		public static const TT_HIDE					: uint	= 2;									//隐藏
		//游戏状态
		public static const TK_TURNSCORE			:uint		= 1;								//玩家叫分
		public static const TK_CONTINUE				:uint		= 2;								//继续游戏
		public static const TK_READY				:uint		= 3;								//玩家准备
		public static const TK_CALLBANK				:uint		= 4;								//玩家叫庄
		public static const TK_OPENCARD				:uint		= 5;								//玩家摊牌
		
		public static const TK_ONPLAYERCALL			:uint		= 7;			//播放随机庄家动画
	}
}