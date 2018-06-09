package cx.gamebase.events
{
	public class TCPEvent
	{
		/**
		 * 信息提示消息弹窗
		 * */
		public static const MESSAGE_EVENT		:	String	=	'message_event';
		
		/**
		 * 游戏配置信息
		 * */
		public static const GAME_ATTRIBUTE		: String	=	'game_attribute';
		
		/**
		 * 接收socket消息
		 * */
		public static const SOCKET_SINK			: String	=	'socket_sink';
		public static const SOCKET_INIT			: uint		= 	1;
		public static const SOCKET_CLOSE		: uint		= 	4;
		
		/**
		 * 聊天 系统消息
		 * */
		public static const MSG_INOF 			: String	= 'msg_inof';
		
		/**
		 * 房间服务消息
		 * */
		public static const TCP_SERVER_INFO		: String 	= 'tcp_server_info';
		public static const TCP_ONLINE_COUNTINFO: uint 		= 1;
		
		/**
		 * 音乐消息
		 * */
		public static const GAME_SOUND_COMPLETE	: String	= 'game_sound_complete';
	}
}