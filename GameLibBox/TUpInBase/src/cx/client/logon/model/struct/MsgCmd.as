package cx.client.logon.model.struct
{
	public class MsgCmd
	{
		//////////////////////////////////////////////////////////////////////////
		
		//消息验证命令
		public static const MDM_MSG_VERIFY		: uint		= 1;					//消息服务验证
		public static const SUB_MSG_CONNECT		: uint		= 1;					//链接验证
		
		public static const SUB_MSG_VERIFY_SUCCESS : uint	= 100;					//验证成功
		public static const SUB_MSG_VERIFY_FIELD : uint		= 101;					//验证失败
		
		
		/////////////////////////////////////////////////////////////////////////
		//聊天
		public static const MDM_MSG_CAHT				: uint	= 10;		//聊天命令
		
		public static const SUB_MSG_CHAT_SEND			: uint	= 11;		//发送聊天
		public static const SUB_MSG_CHAT_RECV			: uint	= 12;		//接收聊天
	
		/////////////////////////////////////////////////////////////////////////
		//网页
		public static const MDM_MSG_NET					: uint	= 200;		//网页消息	
		public static const SUB_MSG_NET_MESSAGE			: uint	= 201;		//公告
		public static const SUB_MSG_NET_OUTUSER			: uint	= 202;		//提人
		
		/////////////////////////////////////////////////////////////////////////
		//更新
		public static const MDM_MSG_UPDATE				: uint = 20;		//更新
		public static const SUB_MSG_SERVER_LIST			: uint = 200;		//更新游戏列表
		public static const SUB_MSG_SERVER_MATCH		: uint = 201;		//游戏比赛数据更新
		/////////////////////////////////////////////////////////////////////////
		
		//好友
		public static const MDM_MSG_FRIENDMES			: uint = 40;
		
		public static const SUB_GP_INPUTFRIEND			: uint = 129;	//添加好友
		public static const SUB_GP_DELETEFRIEND			: uint = 130;	//删除好友
		
		public static const SUB_GP_WAITINPUTFRIEND		: uint = 135;	//等待验证
		public static const SUB_GP_INPUTFRIEND_NO_YES	: uint = 136;	//同意拒绝添加
		
		public static const SUB_GP_INPUTFRIEND_NO_YES_RESULT:uint=137;	//同意拒绝添加
		public static const SUB_GP_BOOKFRIEND			: uint = 138;		//备注好友
		
		
		
		public static const SUB_GP_FRIENDINFO			: uint = 141;	//	请求发送上线信息
		public static const SUB_GP_PLAYERONLINE			: uint = 140;	//	好友上线
		
		
		public static const SUB_GP_CHECKRESULT			: uint = 142;
		
		public static const SUB_GP_PLAYOFFLINE			: uint = 143;
		
		
		public static const SUB_GP_PLAYWITHFRIEND		: uint = 144;
		
		
		public static const MDM_MSG_USERLIST	 		: uint = 90;
		public static const SUB_MSG_SENDUSERLIST	 	: uint = 500;
		public static const SUB_MSG_SENDUSERLIST_FINISH	: uint = 501;
		
		
	}
}