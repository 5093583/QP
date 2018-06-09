package games.baccarat.utils
{
		public class BaccConst
		{
				//定时器操作类型
				public static const TK_FREE                     :uint		=  1;                           //空闲  
				public static const TK_JETTON                   :uint		=  2;                          	//下注
				public static const TK_OPEN                     :uint		=  3;                       	//开牌
					
					
				public static const GAME_PLAYER					:uint		= 300;							//游戏人数
				//状态定义
				public static const GS_PLACE_JETTON				:uint		= 100;							//下注状态
				public static const	GS_GAME_END					:uint		= 101;							//结束状态
				
				
				public static const	ID_XIAN_JIA					:uint		= 1;							//闲家索引
				public static const	ID_PING_JIA					:uint		= 2;							//平家索引
				public static const	ID_ZHUANG_JIA				:uint		= 3;							//庄家索引
				public static const	ID_XIAN_TIAN_WANG			:uint		= 4;							//闲天王
				public static const	ID_ZHUANG_TIAN_WANG			:uint		= 5;							//庄天王
				public static const	ID_TONG_DIAN_PING			:uint		= 6;							//同点平
				public static const	ID_PLAYER_TWO_PAIR			:uint		= 7;							//闲对子
				public static const	ID_BANKER_TWO_PAIR			:uint		= 8;							//庄对子
				
		}
}