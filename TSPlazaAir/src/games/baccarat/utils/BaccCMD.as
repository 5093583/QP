package games.baccarat.utils
{
	public class BaccCMD
	{
		//客户端
		public static const SUB_C_PLACE_JETTON			:uint		=1;									//用户下注
		public static const SUB_C_APPLY_BANKER			:uint		=2;									//申请庄家
		public static const SUB_C_CANCEL_BANKER			:uint		=3;									//取消申请
		public static const SUB_C_AIDE_GET            	:uint		=5; 								//管理员命令
		//服务端
		public static const SUB_S_GAME_FREE				:uint		=99;								//游戏空闲
		public static const SUB_S_GAME_START			:uint		=100;								//游戏开始
		public static const SUB_S_PLACE_JETTON			:uint		=101;								//用户下注
		public static const SUB_S_GAME_END				:uint		=102;								//游戏结束
		
		public static const SUB_S_APPLY_BANKER			:uint		=103;								//申请庄家
		public static const SUB_S_CHANGE_BANKER			:uint		=104;								//切换庄家
		public static const SUB_S_CHANGE_USER_SCORE		:uint		=105;								//更新积分
		public static const SUB_S_SEND_RECORD			:uint		=106;								//游戏记录
		public static const SUB_S_PLACE_JETTON_FAIL		:uint		=107;								//下注失败
		public static const SUB_S_CANCEL_BANKER			:uint		=108;								//取消申请
		public static const SUB_S_AMDIN_COMMAND			:uint		=109;								//管理员命令
		
		
		public static const SUB_S_OUTPLAYERRESON		:uint		=110;
	}
}