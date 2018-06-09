package cx.gamebase.events
{
	public class GameEvent
	{
		public static const INIT_G_COMPLETE				: String = 'init_g_complete';				//游戏初始化完成
		public static const INIT_G_ERROR				: String = 'init_g_error';					//游戏初始化完成
		public static const PRE_G_EXIT					: String = 'pre_g_exit';					//退出游戏前处理
		public static const GAME_SEND_EXIT				: String = 'game_send_exit';				//游戏端发送关闭
		public static const USER_STATUS					: String = 'user_status';					//用户状态发生改变
		public static const USER_COME					: String = 'user_come';						//用户进入游戏
		public static const CONTINUE_GAME 				: String = 'continue_game';					//继续游戏
		public static const GAME_READY 					: String = 'game_ready';					//游戏准备
		public static const GAME_LEAVE_ENABLE			: String = 'game_leave_enable';				//是否能够离开
		public static const USER_SCORE					: String = 'user_score';					//金币变化
		public static const USER_GAME_SCORE				: String = 'user_game_score';				//玩家游戏时前台金币变化
		public static const GAME_MATCH_EVENT			: String = 'game_match_event';				//比赛消息
		
		public static const GAME_NOTICE_EVENT			: String = 'game_notice_event';				//公告
		public static const CLIENT_GAME_OFFLIE			: String = 'client_game_offlie';			//游戏客户端检测断线
		
		
		public static const GAME_G_MINBTN					: String = 'game_minbtn';					//最小画按钮
		public static const GAME_G_MOVELINE					: String = 'game_moveline';			//移动
	}	
}