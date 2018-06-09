package games.landlord.enum
{
	public class enGameStatus
	{
		//游戏状态
		public static const  GS_WK_FREE					: uint = 0;							//等待开始
		public static const  GS_WK_SCORE				: uint = 100;						//叫分状态
		public static const  GS_WK_DOUBLE_SCORE			: uint = 101;						//加倍状态
		public static const  GS_WK_PLAYING				: uint = 102;						//游戏进行
	}
}