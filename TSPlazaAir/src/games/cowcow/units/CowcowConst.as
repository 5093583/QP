package games.cowcow.units
{
	import t.cx.air.TConst;

	public class CowcowConst 
	{
		public static const GAME_PLAYER				:uint		= 4;								//游戏人数
		//结束原因
		public static const GER_NO_PLAYER			:uint		= 0x10;								//没有玩家
		
		
		public static const GS_TK_FREE				:uint		= TConst.GS_FREE;								//等待开始
		public static const GS_TK_CALL				:uint		= TConst.GS_PLAYING;							//叫庄状态
		public static const GS_TK_SCORE				:uint		= TConst.GS_PLAYING+1;							//下注状态
		public static const GS_TK_PLAYING			:uint		= TConst.GS_PLAYING+2;							//游戏进行
	}
}