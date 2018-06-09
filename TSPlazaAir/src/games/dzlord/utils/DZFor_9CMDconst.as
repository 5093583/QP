package games.dzlord.utils
{
	public class DZFor_9CMDconst
	{
		
		public static const			 KIND_ID		:uint=	2002;								//游戏 I D
		public static const			 GAME_TYPE		:uint=	2	;								//游戏类型
		public static const			 GAME_PLAYER	:uint=	9	;								//游戏人数
		public static const 		 CARD_COUNT		:uint=  18  ;								//牌数
				
		//结束原因
		public static const			 GER_NO_PLAYER	:uint=	0x10 ;								//没有玩家
		//数目定义
		public static const			 FULL_COUNT		:uint=		52;								//全牌数目
		public static const			 MAX_COUNT		:uint=2;									//最大数目
		public static const	 		 MAX_CENTERCOUNT:uint=5;									//最大数目
		//任务掩码
		public static const			 TASK_TONGHUASHUN:uint=0x0002;								//同花顺
		public static const			 TASK_SITIAO	  :uint=0x0004;								//四条
			
		public static const			 TK_ACTION			:uint=	1;								//玩家操作
		public static const	 		 TK_CONTINUE		:uint=	2;								//继续游戏
		public static const			 TK_READY			:uint=	3;								//玩家准备
		public static const			 TK_BACK			:uint=  4;								//玩家断线重连
			
			
		public static const			 SUB_S_AIDE_GET		:uint=  201;
		public static const	 		 SUB_S_AIDE_CHANGE  :uint=	202;
		public static const			 SUB_S_GAME_START	:uint=	100;									//游戏开始
		public static const			 SUB_S_ADD_SCORE	:uint=	101;									//加注结果
		public static const			 SUB_S_GIVE_UP		:uint=	102;									//放弃跟注	
		public static const	 	  	 SUB_S_SEND_CARD	:uint=	103;									//发牌消息
		public static const			 SUB_S_GAME_END		:uint=	104;									//游戏结束
		public static const			 SUB_S_SIT_DOWN		:uint=	105;									//用户坐下
		public static const			 SUB_S_SEND_CENTER_CARD :uint=200;									//给机器人发中心牌
		
		//////////////////////////////////////////////////////////////////////////
		//客户端命令结构
		public static const			 SUB_C_ADD_SCORE	:uint=	1;									//用户加注
		public static const			 SUB_C_GIVE_UP		:uint=	2;									//放弃消息
		public static const			 SUB_C_AIDE_GET		:uint=	3;									//获得超级功能
		public static const			 SUB_C_AIDE_CHANGE	:uint= 	4;									//换牌
		
		
		
		public static const			SUB_C_SHOUHAND		:uint= 	5;									//梭哈
		
		////////////////////////////////////////////////////////////////////////
		//游戏状态
		public static const  GS_WK_FREE					: uint = 0;							//等待开始
		public static const  GS_WK_PLAYING				: uint = 100;						//游戏进行
		
		
		public static const SUB_C_CLIENT_ONLINE		:uint		= 10;
	}
}