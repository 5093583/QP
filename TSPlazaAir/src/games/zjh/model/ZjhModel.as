package games.zjh.model
{
	import games.zjh.utils.ZjhConst;
	import games.zjh.utils.ZjhCMD;
	import cx.gamebase.events.GameEvent;
	import cx.gamebase.model.GlobalModel;
	import cx.gamebase.sturuct.GameCmd;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import t.cx.air.TConst;
	import t.cx.air.TScore;
	import t.cx.air.controller.Controller;
	import t.cx.air.utils.CxTimerHelper;
	import t.cx.air.utils.Memory;
	
	public class ZjhModel extends GlobalModel
	{
		public static function _getInstance() : ZjhModel
		{
			return _instance == null ? (_instance = new ZjhModel()) : _instance;
		}
		
		
		/**--------------------------------------------------------------------
		 * 变量定义区域
		 * --------------------------------------------------------------------*/
		
		public var  lMaxScore		: Number;					//最大下注
		
		public function get lChipCell() : Number
		{
			var ts : Number = TScore.toFloatEx(_lCellScore);
			if(ts>=1) return 1;
			if(ts <= 0) return 1;
			
			return 1/Math.pow( 10,(ts.toString().length - 2) );
		}
		private var _lCellScore : Number;						//单元下注
		public function set lCellScore(val : Number) : void					
		{
			_lCellScore = val;
		}
		public function get lCellScore() : Number
		{
			return _lCellScore;
		}
		public var  lCurrentTimes	: Number;					//当前倍数
		public var  lUserMaxScore	: Number;					//分数上限
		public var 	lMaxCellScore	: Number;					//单注封顶
		public var  wBankerUser		: int;						//庄家用户
		public var  wCurrentUser	: int;						//当前玩家
		public var lMaxAddScore		: Number;					//最大加注
		public var lAddScore		: Number;					//用户加注
		
		public var bCompare			: Boolean;					//是否比牌
		public var lTableScore		: Array;					
		public var lTotalScore		: Number;					//总下注
		public var bMingzhu			: Array;					//明注信息
		public var bCompareUser		: Array;					//比牌信息
		public var bPlayerStatus 	: Array;					//玩家状态
		public var m_lGuoDiScore	: Number;
		public var m_playerInfo		: Array;
		
		public var m_bFollow		: Boolean;					//一跟到底
		public var m_bLeave			: Boolean;					//下局离开
		
		public var m_bFirstUser		: Boolean;
		
		
		public var m_gameStart:Boolean = false;
		
		
		private var m_gameTimer		: CxTimerHelper;	
		public function ZjhModel()
		{
			super();
			
		}
		override public function Init():void
		{
			super.Init();
			lTableScore = Memory._newArrayAndSetValue(ZjhConst.GAME_PLAYER,0);
			bMingzhu	= Memory._newArrayAndSetValue(ZjhConst.GAME_PLAYER,1);
			bCompareUser= Memory._newArrayAndSetValue(ZjhConst.GAME_PLAYER,0);
			bPlayerStatus = Memory._newArrayAndSetValue(ZjhConst.GAME_PLAYER,0);
			lCellScore	= 0;
			lCurrentTimes = 0;
			lUserMaxScore = 0;
			lMaxCellScore = 0;
			lTotalScore	= 0;
			m_bFirstUser = true;
			m_playerInfo = Memory._newArrayAndSetValue(5,0);
			m_lGuoDiScore = 0;
			StartOnLineCheck();
		}
		public function SendTcpEvent(wMainCMD : uint,wSubCMD : uint,pBuffer : ByteArray,wDataSize : int) : void
		{
			if(pBuffer != null) {
				m_Tcp.SendData(wMainCMD,wSubCMD,pBuffer,wDataSize);
			}else {
				m_Tcp.SendCmd(wMainCMD,wSubCMD);
			}
		}
		/**
		 * 删除
		 * */
		override public function Destroy():Boolean
		{
			super.Destroy();
			lTableScore = null;
			bMingzhu = null;
			bCompareUser = null;
			bPlayerStatus = null;
			m_playerInfo = null;
			m_bFirstUser = false;
			if(m_gameTimer != null) {
				m_gameTimer.removeEventListener('complete_timer',OnClientCheckComplete);
				m_gameTimer.Destroy();
				m_gameTimer = null;
			}
			return true;
		}
		
		public function IsAllAction() : Boolean
		{
			for(var i : uint = 0;i<ZjhConst.GAME_PLAYER;i++)
			{
				if(m_User.GetUserByChair(i) != null && (bPlayerStatus[i]==1)) {
					if(lTableScore[i] <= m_lGuoDiScore) return false;
				}
			}
			return true;
		}
		public function get UserCount() : uint
		{
			var count : uint = 0;
			for(var i : uint = 0;i <ZjhConst.GAME_PLAYER;i++)
			{
				if(m_User.GetUserByChair(i) != null && bPlayerStatus[i] == 1) {
					count++;
				}
			}
			return count;
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
					m_Tcp.SendCmd(GameCmd.MDM_GF_GAME,ZjhCMD.SUB_C_CLIENT_ONLINE);
				}
				_bCheckOnline = true;
				m_gameTimer.Reset();
				m_gameTimer.Start(4000);
			}
		}
	}
}