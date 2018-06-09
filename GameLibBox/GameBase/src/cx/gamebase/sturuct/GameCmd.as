package cx.gamebase.sturuct
{
	public class GameCmd
	{
		//////////////////////////////////////////////////////////////////////////
		//登录数据包定义
		
		public static const MDM_GR_LOGON						: uint = 1;		//房间登录
		
		public static const SUB_GR_LOGON_ACCOUNTS				: uint = 1;		//帐户登录
		public static const SUB_GR_LOGON_USERID					: uint = 2;		//I D 登录
		
		public static const SUB_GR_LOGON_SUCCESS				: uint = 100;	//登录成功
		public static const SUB_GR_LOGON_ERROR					: uint = 101;	//登录失败
		public static const SUB_GR_LOGON_FINISH					: uint = 102;	//登录完成
		
		//////////////////////////////////////////////////////////////////////////
		//用户数据包定义
		
		public static const  MDM_GR_USER						: uint = 2;		//用户信息
		
		public static const  SUB_GR_USER_SIT_REQ				: uint = 1;		//坐下请求
		public static const  SUB_GR_USER_LOOKON_REQ				: uint = 2;		//旁观请求
		public static const  SUB_GR_USER_STANDUP_REQ			: uint = 3;		//起立请求
		public static const  SUB_GR_USER_LEFT_GAME_REQ			: uint = 4;		//离开游戏
		public static const  SUB_GR_USER_ADMIN_OUT				: uint = 5;		//管理员提出游戏
		public static const  SUB_GR_USER_WITHFRIEND 			: uint = 6;		//邀请好友游戏
		
		public static const  SUB_GP_USER_WITHOUTROOM   			: uint = 7;		//好友离开房间
		
		
		public static const  SUB_GR_USER_COME					: uint = 100;	//用户进入
									
		public static const  SUB_GR_USER_STATUS					: uint = 101;	//用户状态
		public static const  SUB_GR_USER_SCORE					: uint = 102;	//用户分数
		public static const  SUB_GR_SIT_FAILED					: uint = 103;	//坐下失败
		public static const  SUB_GR_USER_RIGHT					: uint = 104;	//用户权限
		public static const  SUB_GR_MEMBER_ORDER				: uint = 105;	//会员等级
		
		public static const  SUB_GR_USER_RULE					: uint = 202;	//用户规则
		
		public static const  SUB_GR_USER_INVITE					: uint = 300;	//邀请消息
		public static const  SUB_GR_USER_INVITE_REQ				: uint = 301;	//邀请请求
		
		public static const   SUB_GR_USER_QUEUE_REQ				: uint = 400;	//请求进入等待队列
		public static const   SUB_GR_USER_QUEUE					: uint = 401;	//进入等待队列
		public static const   SUB_GR_USER_QUEUE_FIELD			: uint = 402;	//等待队列请求失败
		public static const   SUB_GR_USER_QUEUE_READY			: uint = 403;	//等待队列准备完毕
		public static const   SUB_GR_USER_QUEUE_COM				: uint = 404;	//队列分配完毕
		public static const   SUB_GR_USER_QUEUE_REQ_AGAIN		: uint = 405;	//队列分配完毕
		public static const   SUB_GR_USER_CONTINUE_GAME			: uint = 406;	//在游戏中继续
		
		//////////////////////////////////////////////////////////////////////////
		//配置信息数据包
		
		public static const MDM_GR_INFO							: uint = 3;		//配置信息
		
		public static const SUB_GR_SERVER_INFO					: uint = 100;	//房间配置
		public static const SUB_GR_ORDER_INFO					: uint = 101;	//等级配置
		public static const SUB_GR_MEMBER_INFO					: uint = 102;	//会员配置
		public static const SUB_GR_COLUMN_INFO					: uint = 103;	//列表配置
		public static const SUB_GR_CONFIG_FINISH				: uint = 104;	//配置完成
		
		
		//////////////////////////////////////////////////////////////////////////
		//房间状态数据包
		
		public static const MDM_GR_STATUS						: uint = 4;		//状态信息
		
		public static const SUB_GR_TABLE_INFO					: uint = 100;	//桌子信息
		public static const SUB_GR_TABLE_STATUS					: uint = 101;	//桌子状态
		
		//管理数据包
		
		public static const MDM_GR_MANAGER						: uint = 5;		//管理命令
		
		public static const SUB_GR_SEND_WARNING					: uint = 1;		//发送警告
		public static const SUB_GR_SEND_MESSAGE					: uint = 2;		//发送消息
		public static const SUB_GR_LOOK_USER_IP					: uint = 3;		//查看地址
		public static const SUB_GR_KILL_USER					: uint = 4;		//踢出用户
		public static const SUB_GR_LIMIT_ACCOUNS				: uint = 5;		//禁用帐户
		public static const SUB_GR_SET_USER_RIGHT				: uint = 6;		//权限设置
		public static const SUB_GR_OPTION_SERVER				: uint = 7;		//房间设置
		
		
		//////////////////////////////////////////////////////////////////////////
		//系统数据包
		
		public static const MDM_GR_SYSTEM						: uint = 10;	//系统信息
		
		public static const SUB_GR_MESSAGE						: uint = 100;	//系统消息
		
		//////////////////////////////////////////////////////////////////////////
		//房间数据包
		
		public static const MDM_GR_SERVER_INFO					: uint = 11;	//房间信息
		public static const SUB_GR_ONLINE_COUNT_INFO			: uint = 100;	//在线信息
		
		
		//////////////////////////////////////////////////////////////////////////
		//网络命令码
		
		public static const  MDM_GF_GAME						: uint = 100;	//游戏消息
		public static const  SUB_S_TIMER						: uint = 300;	//时间消息
		
		public static const  MDM_GF_FRAME						: uint = 101;	//框架消息
		public static const  SUB_GF_INFO						: uint = 1;		//游戏信息
		public static const  SUB_GF_USER_READY					: uint = 2;		//用户同意
		public static const  SUB_GF_LOOKON_CONTROL				: uint = 3;		//旁观控制
		public static const  SUB_GF_KICK_TABLE_USER				: uint = 4;		//踢走用户
		public static const  SUB_GF_CONTINUE					: uint = 5;		//继续游戏
		public static const  SUB_GF_ONLINE						: uint = 6;		//在线监测
		public static const  SUB_GF_OPTION						: uint = 100;	//游戏配置
		public static const  SUB_GF_SCENE						: uint = 101;	//场景信息
		public static const  SUB_GF_MESSAGE						: uint = 300;	//系统消息
		
		
		//////////////////////////////////////////////////////////////////////////
		//比赛
		public static const MDM_MSG_MATCH				: uint = 30;		//比赛消息
		public static const SUB_S_REF_MACTH				: uint = 300;		//比赛刷新结果
		public static const SUB_C_REF_MATCH				: uint = 300;		//客户端刷新结果
		
	}
}