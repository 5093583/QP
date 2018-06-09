package t.cx.cmd
{
	public class TCmd
	{
		/////////////////////////////////////////////////////////////////////////
		//聊天
		public static const MDM_MSG_CAHT				: uint	= 10;		//聊天命令
		
		public static const SUB_MSG_CHAT_SEND			: uint	= 11;		//发送聊天
		public static const SUB_MSG_SHAT_RECV			: uint	= 12;		//接收聊天
		
		
		//////////////////////////////////////////////////////////////////////////
		
		//消息验证命令
		public static const MDM_MSG_VERIFY		: uint		= 1;					//消息服务验证
		public static const SUB_MSG_CONNECT		: uint		= 1;					//链接验证
		
		public static const SUB_MSG_VERIFY_SUCCESS : uint	= 100;					//验证成功
		public static const SUB_MSG_VERIFY_FIELD : uint		= 101;					//验证失败
		
	}
}