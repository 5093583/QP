package cx.client.logon.model.struct
{
	public class LGCmd
	{
		//////////////////////////////////////////////////////////////////////////
		//游戏登录
		public static const MDM_GP_LOGON 				: uint	= 1;		//广场登录
		public static const SUB_GP_LOGON_ACCOUNTS 		: uint	= 1; 		//帐号登录
		public static const SUB_GP_REGISTER_ACCOUNTS 	: uint	= 3;		//注册帐号
		
		public static const SUB_GP_LOGON_SUCCESS 		: uint	= 100;		//登陆成功
		public static const SUB_GP_LOGON_ERROR 			: uint	= 101;		//登陆失败
		public static const SUB_GP_LOGON_FINISH 		: uint	= 102;		//登陆完成
		public static const SUB_GP_REGISTER_SUCCESS		: uint 	= 103;		//注册成功
		
		//////////////////////////////////////////////////////////////////////////
		//游戏列表命令码
		
		public static const MDM_GP_SERVER_LIST : uint			= 2;		//列表信息
		
		public static const SUB_GP_LIST_TYPE : uint				= 100;		//类型列表
		public static const SUB_GP_LIST_KIND : uint				= 101;		//种类列表
		public static const SUB_GP_LIST_STATION : uint			= 102;		//站点列表
		public static const SUB_GP_LIST_SERVER : uint			= 103; 		//房间列表
		public static const SUB_GP_LIST_FINISH : uint			= 104;		//发送完成
		public static const SUB_GP_LIST_CONFIG : uint			= 105;		//列表配置
		
		//////////////////////////////////////////////////////////////////////////
		//游戏存钱
		public static const MDM_GP_BANK			: uint			= 5;		//银行消息
		
		public static const SUB_GP_BANK_CHECK	: uint			= 98;
		public static const SUB_GP_BANK_CHECK_RESULT	: uint	= 99;
		public static const SUB_GP_BANK_SAVE	: uint			= 100;		//存钱
		public static const SUB_GP_BANK_CASH	: uint			= 101;		//取钱
		public static const SUB_GP_BANK_SAVE_SUCCESS: uint		= 103;		//存钱成功
		public static const SUB_GP_BANK_CASH_SUCCESS: uint		= 104;		//取钱成功
		
		public static const SUB_GP_BANK_SAVE_ERROR: uint		= 106;		//存钱失败
		public static const SUB_GP_BANK_CASH_ERROR: uint		= 107;		//取钱失败
		
		public static const SUB_GP_BANK_CHANGEPASSWORD : uint 	= 102;		//修改密码
		public static const SUB_GP_BANK_CHANGE_ERROR	: uint	= 105;		//密码修改错误
		public static const SUB_GP_BANK_CHANGE_SUCCESS : uint	= 108;		//密码修改成功
		
		
		
		
		public static const SUB_GP_BANK_TRANSFER		: uint	= 110;
		public static const SUB_GP_BANK_TRANSFER_RESULT	: uint	= 111;
		
		
		/////////////////////////////////////////////////////////////////////////
		public static const MDM_GP_USER					: uint	= 4;		//用户命令
		public static const SUB_GP_MOOR_MACHINE    		: uint	= 108;		//锁机请求
		public static const SUB_GP_MOOR_MACHINE_RESULT  : uint 	= 109;		//锁机结果
		
		public static const SUB_GP_REFURBISH			: uint	= 110;		//刷新信息
		public static const SUB_GP_REFURBISH_RESULT		: uint	= 111;		//刷新结果
		
		
		public static const SUB_GP_RECORDSIGNIN				: uint	=112;		//玩家点击按钮记录签到
		public static const SUB_GP_REFURBISHSIGNIN			: uint	=113;		//刷新签到
		public static const SUB_GP_REFURBISHSIGNIN_RESULT	: uint	=114;		//刷新签到结果
		
		public static const SUB_GP_RECORDSIGNIN_RESULT		: uint	=135;		//点击签到结果
		
		public static const  SUB_GP_INPUTFRIEND_RESULT		:uint	=128;			//添加好友结果
		public static const  SUB_GP_INPUTFRIEND				:uint	=129;			//添加好友
		public static const  SUB_GP_DELETEFRIEND			:uint	=130;			//删除好友
		

		
		
		public static const SUB_GP_CHCEKBINDEMAIL		: uint	=	5;		//校验邮箱
		public static const SUB_GP_CHCEKBINDPHONE		: uint	=	6;		//校验电话
		
		public static const SUB_GP_BINDEMAIL			: uint	=   7;		//绑定
		public static const SUB_GP_BINDPHONE			: uint	=	8;
		
		public static const SUB_GP_UPDATEEMAIL			: uint	=	9;		//更换
		public static const SUB_GP_UPDATEPHONE			: uint	=	10;
		
		
		public static const SUB_GP_CHECKBANKINFO		: uint	=	11;
		public static const SUB_GP_BINDBANKINFO			: uint	=	12;
		public static const SUB_GP_UPDATEBANKINFO		: uint	=	13;
		
		public static const SUB_GP_CHECKBANKINFO_RESULT	: uint	=	127;

		
		
		public static const SUB_GP_CHCEKBINDEMAIL_RESULT: uint	=	115;
		public static const SUB_GP_CHCEKPHONE_RESULT	: uint	=	116;
		
		
		
		
		public static const SUB_GP_CREATECUSTOMGAMEROOM	: uint 	=	20;			//创建房间
		public static const SUB_GP_CREATECUSTOMGAMEROOM_RESULT:uint=117;
		
		
	}
}