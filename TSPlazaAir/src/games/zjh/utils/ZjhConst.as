package games.zjh.utils
{
	public class ZjhConst
	{
		public static const GAME_PLAYER 	: uint		= 5;								//玩家人数
		public static const MAX_COUNT		: uint		= 3;								//扑克数目
		//结束原因
		public static const GER_NO_PLAYER 	: uint		= 0x10;								//没有玩家
		public static const GER_COMPARECARD	: uint		= 0x20;								//比牌结束
		public static const GER_OPENCARD 	: uint		= 0x30;								//开牌结束
		
		//游戏状态
		public static const GS_T_FREE		: uint		= 0;								//等待开始
		public static const GS_T_PLAYING	: uint		= 100;								//游戏进行
	}
}