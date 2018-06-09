package games.dzlord.model
{
	import cx.gamebase.events.GameEvent;
	import cx.gamebase.model.GlobalModel;
	import cx.gamebase.sturuct.GameCmd;
	
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import games.dzlord.utils.DZConst;
	import games.dzlord.utils.DZFor_9CMDconst;
	
	import t.cx.air.TConst;
	import t.cx.air.TScore;
	import t.cx.air.controller.Controller;
	import t.cx.air.utils.CxTimerHelper;
	import t.cx.air.utils.Memory;
	
	public class DeZhouModel extends GlobalModel
	{
		/**
		 * 存储公共变量信息类
		 **/
		public static function _getInstance() : DeZhouModel
		{
			return _instance == null ? _instance = new DeZhouModel() : _instance;
		}
		
		public var m_wCurrentUserMatrix:Matrix;				//当前发牌的位置
		public var m_wCurrentUser : uint;					//当前玩家
		public var m_wDUser : uint;							//庄家
		public var m_wMaxChipInUser:uint;					//小盲
		public var m_wBigUser:uint;							//大盲
		public var m_wlCellScore:Number;					//单元下注
		public var m_wlMaxScore:Number;						//本局封顶
		public var m_wCurrentWCardID:uint;					//当前发牌玩家
		public var m_wCurrentLunNum:uint;					//当前发到第几轮
		public var m_wCurrentMyChipNumBer:uint;				//自己当前下的筹码
		public var m_wMyHandGold : Number;					//自己手中的金币
		public var m_wCurrentAddMaxScore:Number;			//当前允许最大下注
		public var m_wCurrentAddMinScore:Number;			//当前允许最小下注
		public var m_wlTurnLessScore:Number;				//平衡当前注（跟注）
		public var m_wDiChi:Number;							//底池分数
		public var m_wUserGiveUp:int;						//当前轮是否有弃牌玩家
		
		public var m_wZiDongStutas:int;
		public var m_wChipNumber:Number;					//跟注789
		
		public var m_wChipArray:Array;
		public var m_wCurrentUserS:Array;					//玩家座位列表
		public var m_wCurrentPlayerCount:Array;				//玩家CardID列表
		public var m_wDUserTipArray:Array;					//庄提示框位置
		public var m_EndScore : Array;					   //结束用户分数
		public var m_wZhuang:Array;
		public var m_PlayerInfo : Array;
		
		public var m_playerStatus : Array;				//检测玩家是否玩到游戏结束
		
		
		public var m_gameStart:Boolean = false;
		
		
		private var m_gameTimer		: CxTimerHelper;
		
		public var m_SendScore:Number;
		public var m_winUser:Array ;						//最后赢家
		
		public var m_AddChip:Array;						//每个玩家下注多少
		public function DeZhouModel()
		{
			super();
			m_PlayerInfo = Memory._newArrayAndSetValue(DZFor_9CMDconst.GAME_PLAYER,0);
			m_playerStatus = Memory._newArrayAndSetValue(DZFor_9CMDconst.GAME_PLAYER,0);
			m_wCurrentUser = 0;
			m_wCurrentWCardID = 0;
			m_wCurrentLunNum = 0;
			m_wCurrentMyChipNumBer = 0;
			m_wDUser = 0; 
			m_wlTurnLessScore = 0;
			m_wUserGiveUp = 0;
			m_wDiChi = 0;
			m_wZiDongStutas = 0;
			m_wChipNumber = 0;
			m_wMyHandGold = 0;
			m_wCurrentUserMatrix = new Matrix();
			m_wCurrentUserS = Memory._newArrayAndSetValue(DZFor_9CMDconst.GAME_PLAYER,TConst.INVALID_DWORD);
			m_wCurrentPlayerCount = new Array();
			m_EndScore	= Memory._newArrayAndSetValue(DZConst.GAME_PLAYER,0);
			m_wChipArray = new Array(
						  new Rectangle(466,430,40,20),
						  new Rectangle(600,430,40,20),	
						  new Rectangle(700,370,20,40),
						  new Rectangle(700,277,20,40),
						  new Rectangle(600,250,40,20),
						  new Rectangle(315,250,40,20),
						  new Rectangle(270,270,20,40),
						  new Rectangle(270,380,20,40),
						  new Rectangle(335,430,40,20));
			
			
			m_wZhuang = new Array(
						new Rectangle(468,480,60,5),
						new Rectangle(650,480,60,5),	
						new Rectangle(805,390,5,60),
						new Rectangle(805,270,5,60),
						new Rectangle(640,195,60,5),
						new Rectangle(300,195,60,5),
						new Rectangle(195,265,5,60),
						new Rectangle(195,390,5,60),
						new Rectangle(300,480,60,5));
			
			m_SendScore = 0;
			m_winUser = Memory._newArrayAndSetValue(DZFor_9CMDconst.GAME_PLAYER,255);
			m_AddChip = Memory._newArrayAndSetValue(DZFor_9CMDconst.GAME_PLAYER,0);
		}
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
		/**
		 * 	获取当前玩家总人数
		 **/
		public function get GetUserNumber():int
		{
			var count : uint = 0;
			var i:int = 0
			for(i = 0;i<DZFor_9CMDconst.GAME_PLAYER;i++){
//				if(this.m_wCurrentUserS[i]!=TConst.INVALID_DWORD)
				if(m_User.GetUserByChair(i) != null) 
				{
					count++;
				}
			}
			return count;
		}
		/**
		 * 人数和庄家发牌
		 **/
		public function get GetPlayerCountArray():Array
		{
			m_wCurrentPlayerCount =  removeArray(m_wCurrentPlayerCount);
			m_wCurrentPlayerCount.sort(Array.NUMERIC);
			var index : int = m_wCurrentPlayerCount.indexOf(m_wDUser);
			if(index < 0)	
				index = 0;
			var tArrs : Array = Memory._newArrayByCopy(m_wCurrentPlayerCount,index,0);
			if(index == 0)return tArrs;
			m_wCurrentPlayerCount.splice(0,index);
			m_wCurrentPlayerCount = m_wCurrentPlayerCount.concat(tArrs);
			return  m_wCurrentPlayerCount;
			
		}
		/**
		 * 删除重复项
		 **/
		private function removeArray(arr:Array):Array
		{
			var newarr:Array = new Array();
			for(var i:int = 0;i<arr.length;i++)
			{
				if(newarr.indexOf(arr[i]) == -1){
					newarr.push(arr[i]);
				}
			}
			return newarr;
		}
		/**
		 * 获取视图ID
		 **/	
		public function ViewChairID(wCardID:int):uint
		{
			var wViewChairID:uint=(wCardID+DZFor_9CMDconst.GAME_PLAYER-this.m_User.GetMeChairID());
			return wViewChairID % DZFor_9CMDconst.GAME_PLAYER;
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
		public function StopOnLineCheck() : void
		{
			if(m_gameTimer != null) {
				m_gameTimer.removeEventListener('complete_timer',OnClientCheckComplete);
				m_gameTimer.Reset();
				m_gameTimer = null;
				_bCheckOnline = false;
			}
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
		private function OnClientCheckComplete(e : Event) : void
		{
			if(_bCheckOnline) {
				Controller.dispatchEvent(GameEvent.CLIENT_GAME_OFFLIE,2);
			} else {
				if( m_Tcp.gameSocket != null ) {
					m_Tcp.SendCmd(GameCmd.MDM_GF_GAME,DZFor_9CMDconst.SUB_C_CLIENT_ONLINE);
				}
				_bCheckOnline = true;
				m_gameTimer.Reset();
				m_gameTimer.Start(4000);
			}
		}
		override public function Destroy():Boolean
		{
			super.Destroy();
			m_wCurrentUserMatrix = null;
			
			m_PlayerInfo 	= null;
			m_wChipArray = null;
			m_wCurrentUserS = null;
			m_wCurrentPlayerCount = null;
			m_wDUserTipArray = null;
			m_EndScore = null;
			m_wZhuang = null;
			
			_instance = null;
			m_winUser = null;
			m_AddChip = null;
			return true;
		}
	}
}