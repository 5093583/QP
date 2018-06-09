package games.landlord.utils
{
	public class LandCmd
	{
		//////////////////////////////////////////////////////////////////////////
		//服务器命令结构
		
		public static const  SUB_S_SEND_CARD			: uint = 100;								//发牌命令
		public static const  SUB_S_LAND_SCORE			: uint = 101;								//叫分命令
		public static const  SUB_S_GAME_START			: uint = 102;								//游戏开始
		public static const  SUB_S_OUT_CARD				: uint = 103;								//用户出牌
		public static const  SUB_S_PASS_CARD			: uint = 104;								//放弃出牌
		public static const  SUB_S_GAME_END				: uint = 105;								//游戏结束
		public static const  SUB_S_BRIGHT_START			: uint = 106;								//明牌开始
		public static const  SUB_S_BRIGHT_CARD			: uint = 107;								//玩家明牌
		public static const  SUB_S_DOUBLE_SCORE			: uint = 108;								//加倍命令
		public static const  SUB_S_USER_DOUBLE			: uint = 109;								//加倍命令
		public static const	SUB_S_CLEARTABLE  			: uint = 110;								//清理桌面
		//////////////////////////////////////////////////////////////////////////
		//客户端命令结构
		
		public static const  SUB_C_LAND_SCORE			: uint = 1;									//用户叫分
		public static const  SUB_C_OUT_CART				: uint = 2;									//用户出牌
		public static const  SUB_C_PASS_CARD			: uint = 3;									//放弃出牌
		public static const  SUB_C_TRUSTEE				: uint = 4;									//托管消息
		public static const  SUB_C_BRIGHT_START			: uint = 5;									//明牌开始
		public static const  SUB_C_BRIGHT				: uint = 6;									//玩家明牌
		public static const  SUB_C_DOUBLE_SCORE			: uint = 7;									//加倍命令
		public static const  SUB_C_YUYAN_SELECT			: uint = 8;									//语言选择
		
		public static const  SUB_S_AIDE_GET				: uint = 200;
		
		
		
		public static const SUB_C_CLIENT_ONLINE		:uint		= 10;
		public static const SUB_S_CLIENT_ONLINE		:uint		= 120;
		
	}
}