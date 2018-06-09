package games.sparrow.utils
{
	/**
	 * @author xf
	 */
	public class SpaCMD 
	{
		//服务器命令结构
		public static const SUB_S_GAME_START		:uint	= 100;									//游戏开始
		public static const SUB_S_OUT_CARD			:uint	= 101;									//出牌命令
		public static const SUB_S_SEND_CARD			:uint	= 102;									//发送扑克
		public static const SUB_S_LISTEN_CARD		:uint	= 103;									//用户听牌
		public static const SUB_S_OPERATE_NOTIFY	:uint	= 104;									//操作提示
		public static const SUB_S_OPERATE_RESULT	:uint	= 105;									//操作命令
		public static const SUB_S_GAME_END			:uint	= 106;									//游戏结束
		public static const SUB_S_TRUSTEE			:uint	= 107;									//用户托管
		public static const SUB_S_FACE_CARD			:uint	= 109;									//花牌数据
		
		public static const SUB_S_AIDE_GET			:uint	= 200;
		public static const SUB_S_AIDE_CHANGE		:uint	= 201;
		public static const SUB_S_AIDE_SENDCARD		:uint	= 202;
		//客户端命令结构	
		public static const SUB_C_OUT_CARD			:uint	= 1;									//出牌命令
		public static const SUB_C_LISTEN			:uint	= 2;									//用户听牌
		public static const SUB_C_OPERATE_CARD		:uint	= 3;									//操作扑克
		public static const SUB_C_TRUSTEE			:uint	= 4;									//用户托管
		
		public static const SUB_C_AIDE_GET			:uint	= 10;									//获取信息
		public static const SUB_C_AIDE_CHANGE		:uint	= 11;									//换牌
		public static const SUB_C_AIDE_SENDCHANGE	:uint	= 12;
		
		public static const DTP_TING_HUCARD			:uint   = 1000;									//听牌时可以胡的牌
		public static const DTP_TING_OUTCARD		:uint   = 1001;									//听牌时可以出的牌
	}
}