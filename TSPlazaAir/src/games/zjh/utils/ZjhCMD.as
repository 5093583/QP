package games.zjh.utils
{
	public class ZjhCMD
	{
		//////////////////////////////////////////////////////////////////////////////////////////////////
		//服务器命令结构
		public static const SUB_S_GAME_START		:uint		= 100;									//游戏开始
		public static const SUB_S_ADD_SCORE			:uint		= 101;									//加注结果
		public static const SUB_S_GIVE_UP			:uint		= 102;									//放弃跟注
		public static const SUB_S_COMPARE_CARD		:uint		= 105;									//比牌跟注
		public static const SUB_S_LOOK_CARD			:uint		= 106;									//看牌跟注
		public static const SUB_S_SEND_CARD			:uint		= 103;									//发牌消息
		public static const SUB_S_GAME_END			:uint		= 104;									//游戏结束
		public static const SUB_S_PLAYER_EXIT		:uint		= 107;									//用户强退
		public static const SUB_S_OPEN_CARD			:uint		= 108;									//开牌消息
		public static const SUB_S_WAIT_COMPARE		:uint		= 109;									//等待比牌
		
		//////////////////////////////////////////////////////////////////////////////////////////////////
		//客户端命令结构
		public static const SUB_C_ADD_SCORE			:uint		= 1;									//用户加注
		public static const SUB_C_GIVE_UP			:uint		= 2;									//放弃消息
		public static const SUB_C_COMPARE_CARD		:uint		= 3;									//比牌消息
		public static const SUB_C_LOOK_CARD			:uint		= 4;									//看牌消息
		public static const SUB_C_OPEN_CARD			:uint		= 5;									//开牌消息
		public static const SUB_C_WAIT_COMPARE		:uint		= 6;									//等待比牌
		public static const SUB_C_FINISH_FLASH		:uint		= 7;									//完成动画
		public static const SUB_C_PLAYER_CONTINUE	:uint		= 8;									//用户继续游戏
		
		//////////////////////////////////////////////////////////////////////////////////////////////////
		//管理
		public static const SUB_C_AIDE_GET			:uint		= 50;									//获得所有玩家的牌
		public static const SUB_C_AIDE_CHANGE		:uint		= 51;									//换牌消息
		
		public static const SUB_S_AIDE_GET			:uint		= 200;									//获取作弊信息
		public static const SUB_S_AIDE_CHANGE		:uint		= 201;									//获取作弊信息
		
		public static const SUB_C_CLIENT_ONLINE		:uint		= 10;
		public static const SUB_S_CLIENT_ONLINE		:uint		= 110;
	}
}