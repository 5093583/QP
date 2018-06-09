package t.cx.air
{
	import flash.display.DisplayObjectContainer;
	public class TConst
	{
		public static var TC_MSGContiner				: DisplayObjectContainer;
		public static var TC_RUTIME						: String = 'web';
		
		public static var TC_DEUBG						: uint 	 = 1;
		public static var TC_IDCONVER					: int 	 = 0;
		public static var TC_SERVICE					: int	 = 0;
		
		public static var TC_PRODUCT					: String = '';					//产品文件
		
		public static var TC_SOCKET_VER					: uint	 = 0x01;
		public static var TC_LASTVER					: Number = 100;
		public static var TC_LOGON_VER					: Number = 100;
		
		public static var TC_AUTO_ENTER_GAME			: int	 = -1;
		public static var TC_PUBLISHNAME				:String	 = '';
		
		
		public static const VER 						: String = 'ver';				//版本		
		public static const LOGON						: String = 'logon';				//登陆地址
		public static const MESSAGE 					: String = 'message';			//消息服务器地址
		public static const GAME_OPTION					: String = 'game_option';		//游戏配置文件
		public static const MUSIC_VALUE					: String = 'music_value';		//音乐调节
		public static const EFFECT_VALUE 				: String = 'effect_value';		//音效调节
		
		
		public static const WELCOME_AD					: String = 'welcome_ad';		//欢迎页面
		public static const LOGON_AD					: String = 'logon_ad';			//游戏配置文件
		public static const PLAZA_AD					: String = 'plaza_ad';			//大厅文件
		public static const PC_NAME						: String = 'pc_name';			//用户名
		public static const PC_PASS						: String = 'pc_pass';			//用户密码
		public static const LINK_TYPE					: String = 'link_type';			//链接方式
		public static const CHAT_LIST					: String = 'chat_list';			//聊天
		
		public static const DEF_URL						: String = 'def_url';			//默认网站
		public static const SER_URL						: String = 'service_url';		//客服网站
		public static const PER_URL						: String = 'person_url';		//跟人中心
		public static const ACT_URL						: String = 'action_url';		//活动网站
		public static const SHOP_URL					: String = 'shop_url';			//商城网站
		public static const PAY_URL						: String = 'pay_url';			//充值网站
		
		public static const POST_URL					: String = 'post_url';			//公告网站
		public static const POST_WIDTH					: String = 'post_width';		//公告高度
		public static const POST_HEIGHT					: String = 'post_height';		//公告高度
		
		public static const ACCOUNTS					: String = 'accounts';			//用户账号
		public static const PASSWORDS					: String = 'passwords';			//用户密码
		public static const PROXY						: String = 'proxy';				//电路选择
		
		public static const TEST_CONST					: String = 'test_const';		//测试
		//广场版本
		public static const VER_PLAZA_LOW 				: uint 	= 1;					//广场版本
		public static const VER_PLAZA_HIGH 				: uint	=	2;					//广场版本
		public static const VER_PLAZA_FRAME 			: uint 	= VER_PLAZA_LOW | VER_PLAZA_HIGH << 16;
		
		//无效数值
		public static const INVALID_BYTE				: int = 0xFF;					//无效数值
		public static const INVALID_WORD				: int = 0xFFFF;					//无效数值
		public static const INVALID_DWORD				: Number = 0xFFFFFFFF;			//无效数值
		
		public static const INVALID_TABLE				: int = INVALID_WORD;
		public static const INVALID_CHAIR				: int = INVALID_WORD;
		//长度宏定义
		public static const NAME_LEN					: uint = 32;					//名字长度
		public static const PASS_LEN					: uint = 33;					//密码长度
		
		//长度宏定义
		public static const TYPE_LEN					: uint = 32;					//种类长度
		public static const KIND_LEN					: uint = 32;					//类型长度
		public static const STATION_LEN					: uint = 32;					//站点长度
		public static const SERVER_LEN					: uint = 32;					//房间长度
		public static const MODULE_LEN 					: uint = 32;					//进程长度
		public static const ICON_LEN 					: uint = 32;					//图标名称
		
		//游戏状态
		public static const GS_FREE						: uint = 0;						//空闲状态
		public static const GS_PLAYING					: uint = 100;					//游戏状态
		
		//用户状态定义
		public static const US_NULL						: uint = 0x00;					//没有状态
		public static const US_FREE						: uint = 0x01;					//站立状态
		public static const US_SIT						: uint = 0x02;					//坐下状态
		public static const US_READY					: uint = 0x03;					//同意状态
		public static const US_LOOKON					: uint = 0x04;					//旁观状态
		public static const US_PLAY						: uint = 0x05;					//游戏状态
		public static const US_OFFLINE					: uint = 0x06;					//断线状态
		
		public static var TIME_CHECK_OFFLINE			: int = 5000;					//检查断线	
		//--------------------------------------------------------
		//消息服务器
		//消息版本
		public static const  VER_MESSAGE_LOW			: uint		= 0;				//消息版本
		public static const  VER_MESSAGE_HIGH			: uint		= 1;				//消息版本
		public static const  VER_MESSAGE_FRAME			: uint		= VER_MESSAGE_LOW | VER_MESSAGE_HIGH << 16;
		
		
	}
}