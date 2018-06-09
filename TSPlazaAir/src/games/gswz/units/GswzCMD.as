package games.gswz.units
{
	/**
	 * ...
	 * @author xf
	 */
	public class GswzCMD 
	{
		//服务器命令结构
		public static const SUB_S_GAME_START				:uint =	100;									//游戏开始
		public static const SUB_S_ADD_SCORE					:uint =	101;									//加注结果
		public static const SUB_S_GIVE_UP					:uint =	102;									//放弃跟注
		public static const SUB_S_SEND_CARD					:uint =	103;									//发牌消息
		public static const SUB_S_GAME_END					:uint =	104;									//游戏结束
		public static const SUB_S_GAME_CHANGECARD			:uint =	105;									//用户换牌
		public static const SUB_S_OPEN_CARD					:uint =	106;									//用户换牌
		//客户端命令结构
		public static const SUB_C_ADD_SCORE					:uint =	1;										//用户加注
		public static const SUB_C_GIVE_UP					:uint =	2;										//放弃跟注
		public static const SUB_C_CHANGECARD				:uint = 3;										//用户点击换牌、不换
		public static const SUB_C_OPENCARD					:uint = 4;										//开牌
		
		public static const SUB_S_AIDE_GET					:uint = 200;									//获取作弊信息
		public static const SUB_S_AIDE_CHANGE				:uint = 201;									//换牌消息
		
		public static const SUB_C_AIDE_GET					:uint = 50;									//获得所有玩家的牌
		public static const SUB_C_AIDE_CHANGE				:uint = 51;									//换牌消息
		
		
		public static const SUB_C_CLIENT_ONLINE		:uint		= 10;
	}
}