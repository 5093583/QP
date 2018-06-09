package games.gswz.model
{
	import cx.gamebase.events.GameEvent;
	import cx.gamebase.model.GlobalModel;
	import cx.gamebase.sturuct.GameCmd;
	
	import flash.events.Event;
	
	import games.gswz.units.GswzCMD;
	import games.gswz.units.GswzConst;
	
	import t.cx.air.TScore;
	import t.cx.air.controller.Controller;
	import t.cx.air.utils.CxTimerHelper;
	import t.cx.air.utils.Memory;
	
	public class GswzModel extends GlobalModel
	{
		public var m_lMaxScore : Number;
		public function get lChipCell() : Number
		{
			var ts : Number = TScore.toFloatEx(_lCellScore);
			if(ts>=1) return 1;
			if(ts <= 0) return 1;
			
			return 1/Math.pow( 10,(ts.toString().length - 2) );
		}
		private var _lCellScore : Number;						//单元下注
		public function set m_lCellScore(val : Number) : void					
		{
			_lCellScore = val;
		}
		public function get m_lCellScore() : Number
		{
			return _lCellScore;
		}
		public var m_lTurnMaxScore	: Number;					//最大下注
		public var m_lTurnLessScore	: Number;					//最小下注
		public var m_wCurrentUser	: int;						//当前玩家
		
		public var m_lTableScore	: Array;
		public var m_PlayerInfo 	: Array;
		public var m_cbUserCard		: Array;
		public var m_LastUser		: uint;
		public var m_cbPlayerStatus : Array;
		public var m_cbCurrentTimes	: int;
		public var m_lGuoDiScore	: Number;
		
		public var m_LeaveBtn 		: Boolean;
		public var m_AutoAddBtn 	: Boolean;
		
		public var m_ControlType 	: uint = 100;
		public var m_bNowCardCount	: uint;
		
		
		public var m_gameStart:Boolean = false;
		
		
		public static function _getInstance() : GswzModel
		{
			return _instance == null ? (_instance = new GswzModel()) : _instance;
		}
		public function GswzModel()
		{
			super();
			m_lTableScore = Memory._newArrayAndSetValue(GswzConst.GAME_PLAYER*2,0);
			m_cbPlayerStatus = Memory._newArrayAndSetValue(GswzConst.GAME_PLAYER,0);
			m_PlayerInfo = Memory._newArrayAndSetValue(GswzConst.GAME_PLAYER,0);
			m_cbUserCard = Memory._newTwoDimension(GswzConst.GAME_PLAYER,5,0);
			m_cbCurrentTimes = 0;
			m_lGuoDiScore = 0;
			m_bNowCardCount=0;
		}
		override public function Destroy():Boolean
		{
			super.Destroy();
			m_lMaxScore = NaN;
			_lCellScore = NaN;
			m_lTurnMaxScore = NaN;
			m_lTurnLessScore = NaN;
			m_lGuoDiScore = NaN;
			m_wCurrentUser = 0;
			m_lTableScore = null;
			m_PlayerInfo = null;
			m_cbPlayerStatus = null;
			m_cbUserCard = null;
			m_LastUser = 0;
			m_LeaveBtn = false;
			m_AutoAddBtn = false;
			m_bNowCardCount=0;
			
			_instance = null;
			
			return true;
		}
		
		private var _bCheckOnline 	: Boolean = false;
		private var m_gameTimer		: CxTimerHelper;
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
					m_Tcp.SendCmd(GameCmd.MDM_GF_GAME,GswzCMD.SUB_C_CLIENT_ONLINE);
				}
				_bCheckOnline = true;
				m_gameTimer.Reset();
				m_gameTimer.Start(4000);
			}
		}
		
		
	}
}