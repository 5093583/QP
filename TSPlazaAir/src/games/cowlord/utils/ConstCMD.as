package games.cowlord.utils
{
	public class ConstCMD
	{
		//公共宏定义
		public static const				 KIND_ID					:uint=1002;									//游戏 I D
		public static const				 GAME_PLAYER				:uint=100;									//游戏人数

		//状态定义
		//游戏状态
		public static const  			GS_FREE						:uint = 0;									//等待开始
		public static const				GS_PLACE_JETTON				:uint=100;									//下注状态
		public static const				GS_GAME_END					:uint=101;									//结束状态
		public static const				 MAX_COUNT					:uint=5;									//扑克数目
		//玩家索引
		public static const				 ID_ZHUANG					:uint=0;									//庄家索引
		public static const				 ID_TIAN					:uint=1;									//天
		public static const				 ID_DI						:uint=2;									//地	
		public static const				 ID_XUAN					:uint=3;									//玄
		public static const				 ID_HUANG					:uint=4;									//黄
		
		public static const				 AREA_COUNT					:uint=4;									//区域数目
		//结果标志
		public static const				 BANKER_SUCCESS				:uint=1;									//庄胜利
		public static const				 PLAYER_SUCCESS				:uint=2;									//闲胜利
		public static const				 PING_BANKER_PLAYER			:uint=3;									//平			
		//客户端命令结构
		public static const				 SUB_C_PLACE_JETTON			:uint=1;									//用户下注
		public static const				 SUB_C_APPLY_BANKER			:uint=2;									//申请庄家
		public static const				 SUB_C_CANCEL_BANKER		:uint=3;									//取消申请
		
		
		
		public static const				SUB_C_AIDE_CHANGE			:uint=4;
		////////////////////////////////////////////////////////////////////////////////////
		//aide
		public static const				 SUB_C_AIDE_GET             :uint=5;                                   // 超客
		//服务器命令结构		
		public static const				 SUB_S_GAME_FREE			:uint=99;									//游戏空闲
		public static const				 SUB_S_GAME_START			:uint=100;									//游戏开始
		public static const				 SUB_S_PLACE_JETTON			:uint=101;									//用户下注
		public static const				 SUB_S_GAME_END				:uint=102;									//游戏结束
		public static const				 SUB_S_APPLY_BANKER			:uint=103;									//申请庄家
		public static const				 SUB_S_CHANGE_BANKER		:uint=104;									//切换庄家
		public static const				 SUB_S_PLACE_JETTON_FAIL	:uint=107;									//下注失败
		public static const				 SUB_S_CANCEL_BANKER		:uint=108;									//取消申请
		public static const				 SUB_S_AMDIN_COMMAND		:uint=109;									//管理员命令
		
		public static const 			 SUB_S_OUTPLAYERRESON		:uint=120;
		
		public static const				 SUB_S_SEND_RECORD			:uint=121;									//游戏记录
		
		public static const				 TK_FREE					:uint = 1;									 //空闲 
		public static const				 TK_JETTON					:uint = 2;									 //下注
		public static const				 TK_OPEN					:uint = 3;									 //开牌
	}
}