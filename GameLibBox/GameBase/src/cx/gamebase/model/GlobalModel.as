package cx.gamebase.model
{
	import cx.gamebase.Interface.IDestroy;
	import cx.gamebase.Interface.IReadyGame;
	
	import mx.utils.UIDUtil;
	
	import t.cx.air.TConst;
	import t.cx.air.controller.TEvent;

	public class GlobalModel implements IDestroy,IReadyGame
	{
		protected static var _instance : *;
		public static function GetInstance() : *
		{
			return _instance;
		}
		public static function _exist() : Boolean
		{
			return _instance != null;
		}
		/**----------------------------------------------------------
		 * 
		 * 变量定义
		 * 
		 * ----------------------------------------------------------*/
		public var m_User 			: GameUserModel;		//用户结构
		public var m_Attribute 		: GameAttribute;		//游戏服务属性
		public var m_Tcp			: TCPProxy;				//通信类
		public var m_Sound			: SoundModel;			//音乐
		public var m_bGameStatus	: uint;					//游戏状态
		public var m_bReadyGame		: Boolean;				//继续游戏标识
		/**----------------------------------------------------------
		 * 
		 * 公共函数
		 * 
		 * ----------------------------------------------------------*/
		public function GlobalModel()
		{
		}
		/**
		 * 初始化
		 * */
		public function Init() : void
		{
			m_User 			=	GameUserModel.GetInstance();
			m_Attribute 	=	GameAttribute.GetInstance();
			m_Tcp			= 	TCPProxy.GetInstance();
			m_Sound			= 	SoundModel._getInstance();
			m_bGameStatus	= 	TConst.GS_FREE;
			m_bReadyGame	= 	false;
		}
		public function ReadyGameEvent(e : TEvent) : Boolean
		{
			m_bGameStatus	= TConst.GS_FREE;
			m_bReadyGame	 = true;
			return true;
		}
		/**
		 * 删除
		 * */
		public function Destroy() : Boolean
		{
			if(m_Tcp)
			{
				m_Tcp.Destroy();
				m_Tcp = null;	
			}
			if(m_User)
			{
				m_User.Destroy();
				m_User = null;	
			}
			if(m_Attribute)
			{
				m_Attribute.Destroy();
				m_Attribute = null;
			}
			if(m_Sound)
			{
				m_Sound.Destroy();
				m_Sound = null;
			}
			
			return true;
		}
	}
}