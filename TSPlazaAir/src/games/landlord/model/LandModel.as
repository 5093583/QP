package games.landlord.model
{
	import cx.gamebase.events.GameEvent;
	import cx.gamebase.model.GlobalModel;
	import cx.gamebase.sturuct.GameCmd;
	
	import flash.events.Event;
	
	import games.landlord.events.LandEvent;
	import games.landlord.utils.LandCmd;
	import games.landlord.utils.LandConst;
	import games.landlord.utils.LandLogic;
	
	import t.cx.air.controller.Controller;
	import t.cx.air.controller.TEvent;
	import t.cx.air.utils.CxTimerHelper;
	import t.cx.air.utils.Memory;
	
	public class LandModel extends GlobalModel
	{
		
		public static function _getInstance() : LandModel
		{
			return _instance == null ? _instance = new LandModel() : _instance;
		}
		public var m_logic : LandLogic;
		public var m_LandScore	: uint;
		public var m_MeCallScore : int;
		public var m_wLnadUser	: uint;
		public var m_backArray	: Array;				/////底牌数组
		
		public var m_bGameStart : Boolean;
		//结算变量
		public var m_EndUserID	: Array;					//结束用户ID
		public var m_EndScore	: Array;					//结束用户分数
		public var m_EndDouble	: Array;					//倍数计算 
		
		//出牌变量
		public var m_bTurnCardCount : uint;				//出牌数目
		public var m_bTurnOutType : uint;				//出牌类型
		public var m_bTurnCardData : Array;				//出牌列表
		
		public var m_bTrust : Boolean;					//托管标记
		
		public var m_playerInfo		: Array;
		public var m_wCurrentUser : uint;
		public var m_wLastOutCard : uint;
		private var _bOutCardEnable : Boolean;
		
		private var m_gameTimer		: CxTimerHelper;	
		
		public function set m_bOutCardEnable(val : Boolean) : void
		{
			_bOutCardEnable = val;
			Controller.dispatchEvent(LandEvent.OUT_ENABLE,_bOutCardEnable?1:0);
		}
		public function get m_bOutCardEnable() : Boolean
		{
			return _bOutCardEnable;
		}
		
		public var m_bTrustCount	: uint; 
		public function LandModel()
		{
			super();
			initModel();
		}
		private function initModel() : void
		{
			m_logic = LandLogic.GetInstance();
			
			m_LandScore = 0;
			m_wLnadUser = 0;
			m_bTurnCardCount = 0;
			m_bTurnOutType	= 0;
			m_bTurnCardData = new Array(20);
			m_EndUserID = Memory._newArrayAndSetValue(LandConst.GAME_PLAYER,0);
			m_EndScore	= Memory._newArrayAndSetValue(LandConst.GAME_PLAYER,0);
			m_EndDouble = Memory._newArrayAndSetValue(5,0);
			m_bTrust 	= false;
			m_bGameStart = false;
			m_bTrustCount = 0;
			m_playerInfo = Memory._newArrayAndSetValue(5,0);
			m_MeCallScore = -1;
			
			StartOnLineCheck();
			m_backArray = Memory._newArrayAndSetValue(3,0);
		}
		override public function ReadyGameEvent(e:TEvent):Boolean
		{
			super.ReadyGameEvent(e);
			initModel();
			return true;
		}
		override public function Destroy():Boolean
		{
			super.Destroy();
			m_bTurnCardData = null;
			m_playerInfo = null;
			m_bTrust = false;
			m_LandScore = 0;
			m_wLnadUser = 0;
			m_bTurnCardCount = 0;
			m_bTurnOutType	= 0;
			
			if(m_gameTimer != null) {
				m_gameTimer.removeEventListener('complete_timer',OnClientCheckComplete);
				m_gameTimer.Destroy();
				m_gameTimer = null;
			}
			m_backArray = null
			return true;
		}
		

		private var _bCheckOnline : Boolean = false;
		public function StartOnLineCheck() : void
		{
			if(m_gameTimer == null) {
				m_gameTimer = new CxTimerHelper(24);
				m_gameTimer.addEventListener('complete_timer',OnClientCheckComplete);
			}else {
				m_gameTimer.Reset();
			}
			_bCheckOnline = false;
			m_gameTimer.Start(6000);
		}
		public function ResetOnLineCheck() : void
		{
			if(m_gameTimer == null) {
				StartOnLineCheck();
			}else {
				_bCheckOnline = false;
				m_gameTimer.Reset();
				m_gameTimer.Start(6000);
			}
		}
		public function StopOnLineCheck() : void
		{
			if(m_gameTimer != null) {
				m_gameTimer.removeEventListener('complete_timer',OnClientCheckComplete);
				m_gameTimer.Reset();
				m_gameTimer = null;
				_bCheckOnline = false;
			}
		}
		private function OnClientCheckComplete(e : Event) : void
		{
			if(_bCheckOnline) {
				Controller.dispatchEvent(GameEvent.CLIENT_GAME_OFFLIE,2);
			} else {
				if( m_Tcp.gameSocket != null ) {
					m_Tcp.SendCmd(GameCmd.MDM_GF_GAME,LandCmd.SUB_C_CLIENT_ONLINE);
				}
				_bCheckOnline = true;
				m_gameTimer.Reset();
				m_gameTimer.Start(4000);
			}
		}
		
	}
}