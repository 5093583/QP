package games.baccarat.model
{
	import cx.gamebase.model.GlobalModel;
	
	import games.baccarat.struct.CMD_S_GameEnd;
	import games.baccarat.utils.BaccaratLogic;
	
	import t.cx.air.utils.Memory;
	public class BaccaratModel extends GlobalModel
	{
		public static function _getInstance() : BaccaratModel
		{
			return _instance == null ? (_instance = new BaccaratModel()) : _instance;
		}
		public var m_lApplyBankerCondition 	: Number;				//申请条件
		public var m_lAreaLimitScore 		: Number;				//区域限制
		public var m_wBankerUser			: uint;					//当前庄家
		public var m_cbBankerTime			: int;					//庄家次数
		public var m_lBankerWinScore		: Number;				//庄家成绩
		public var m_lBankerScore			: Number;				//庄家分数
		public var m_lUserMaxScore			: Number;				//自己最大分数
		public var m_bEnableSysBanker		: uint;					//系统坐庄
		public var m_lAreaScore				: Array;
		
		public var m_Logic 					: BaccaratLogic;
		public var m_lastGameEnd 			: CMD_S_GameEnd;
		
		public var m_cbApplyBanker			: Boolean;
		public var m_lChipScore				: Array;
		public var m_lAreaLeftScore			: Array;				//庄闲平 分别可下分数
		public var m_lAreaLimitScoreLest		: Number;
		public var m_lPlayerScore			: Number;
		public var m_lJettonScore			: Number;
		
		public var m_ChipIndex				: int;
		
		
		//玩家下注
		public var lUserTieScore	: Number;						//买平总注
		public var lUserBankerScore	: Number;					//买庄总注
		public var lUserPlayerScore	: Number;					//买闲总注
		public var lUserTieSamePointScore	: Number;			//平天王注
		public var lUserBankerKingScore	: Number;				//庄天王注
		public var lUserPlayerKingScore	: Number;				//闲天王注
		public var lUserPlayerTwoPair	: Number;				//闲家对子
		public var lUserBankerTwoPair	: Number;				//庄家对子
		
		
		public var lAllTieScore		: Number;						//买平总注
		public var lAllBankerScore  : Number;					//买庄总注
		public var lAllPlayerScore 	: Number;					//买闲总注
		
		
		public var l_userTotalAdd:Number  = 0;
		public var l_userTotalIn:Number;
		
		public var m_user_xiazhu:uint;						//当前下注用户
		public var chipArray:Array;						//下注筹码数组
		public var l_status:Boolean;
		public function BaccaratModel()
		{
			super();
			m_lApplyBankerCondition = 0;
			m_lAreaLimitScore =0;
			m_wBankerUser = 0;
			m_cbBankerTime = 0;
			m_lBankerWinScore = 0;
			m_bEnableSysBanker = 0;
			m_lUserMaxScore = 0;
			m_lPlayerScore = 0;
			m_lJettonScore = 0;
			m_lAreaScore = Memory._newArrayAndSetValue(16,0);
			m_cbApplyBanker = false;
			m_Logic = new BaccaratLogic();
			m_lChipScore = new Array();
			m_lAreaLeftScore = Memory._newArrayAndSetValue(3,0);
			
			m_user_xiazhu = 0;
			chipArray = new Array();
			l_status = false;
			lUserTieScore			= 0;
			lUserBankerScore		= 0;
			lUserPlayerScore		= 0;
			lUserTieSamePointScore	= 0;
			lUserBankerKingScore	= 0;
			lUserPlayerKingScore	= 0;
			lUserPlayerTwoPair		= 0;
			lUserBankerTwoPair		= 0;
			
			lAllTieScore			= 0;
			lAllBankerScore			= 0;
			lAllPlayerScore			= 0;
			
			l_userTotalAdd  = 0;
			l_userTotalIn   = 0;
			
			
			m_ChipIndex = -1;
		}
		override public function Destroy():Boolean
		{
			super.Destroy();
			m_lAreaLimitScoreLest = NaN;
			m_lastGameEnd = null;
			m_lAreaScore = null;
			m_Logic = null;
			m_lChipScore = null;
			m_lAreaLeftScore = null;
			
			_instance = null;
			
			return true;
		}
		
		
		
	}
}