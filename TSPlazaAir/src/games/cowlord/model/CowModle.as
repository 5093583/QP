package games.cowlord.model
{
	import cx.gamebase.model.GlobalModel;
	
	import games.cowlord.struct.CMD_S_GameEnd;
	
	import t.cx.air.TScore;
	import t.cx.air.utils.Memory;
	
	
	public class CowModle extends GlobalModel
	{
		/**
		 * 存储公共变量信息类
		 **/
		public static function _getInstance() : CowModle
		{
			return _instance == null ? _instance = new CowModle() : _instance;
		}
		public var m_wCurrentWCardID:uint;				//当前ID
		public var m_wBankerID:uint;					//当前庄家ID
		public var m_bEnableSysBanker:uint;				
		public var m_wCurrentLunNum:uint;				//当前发牌轮数
		public var m_wChipAmount:Number;				//当前点击筹码
		public var m_wCBJettonArea:uint;				//下注区域
		public var m_wUserScore:Number;					//自己成绩
		public var m_wUserGold:Number;					//自己手中的金币
		public var m_wBankerScore:Number;				//庄家成绩	
		public var m_lBankerScore:Number;				//庄家金币
		
		public var m_wCbBankerTime : uint;				//庄家局数
		public var m_lPlayerScore: Number;
		public var m_wDiceNumber:int;					//骰子点数
		public var m_wMyPlayCount:int;					//自己玩了多少局
		public var m_wPageCount:int;					//共可以显示多少对错号
		public var m_lApplyBankerCondition:Number;		//申请上庄条件
		public var m_cbApplyBanker			: Boolean;
		
		public var m_wFACardArray:Array;				//玩家ID
		public var m_wApplyBlankTabel:Array;			//申请上庄玩家列表
		public var m_wAreaArray:Array;					//下注区域
		
		public var m_wJieSuanArray:Array;				//结算
		public var m_wCBCardOx:Array;					//结束牌型
		public var lAreaWinner:Array;					//输赢(1庄赢，2玩家赢)
		public var m_wTableChipArr:Array;				//桌面筹码
		public var m_wlChipScore:Array;					//桌面筹码按钮分数
		public var m_wWinAndLoase:Array;				//对错号
		public var m_wGameRecord:Array;					//游戏记录 每轮的对错值
		public var m_ChipIndex:int;						//选择筹码索引
		public var lAreaLimitScore : Array;				//区域总限制
		public var currentAreaLimit : Array;			//当前总区域剩余限制
		
		public var m_lAreaLimitScoreLest	: Number;	//最小金币限制
		
		
		public var m_lUserAreaWinScore:Array;		//玩家每个区域的得分
		
		public var m_lastGameEnd : CMD_S_GameEnd;
		
		
		public function CowModle()
		{
			super();
			m_wCurrentWCardID 	= 0;
			m_wCurrentLunNum 	= 0;
			m_wChipAmount 		= 0;
			m_wUserScore 		= 0;
			m_wUserGold			= 0;
			m_wBankerScore 		= 0;
			m_wDiceNumber 		= 0;
			m_wMyPlayCount		= 0;
			m_wPageCount		= 18;
			m_lApplyBankerCondition = 0;
			m_wFACardArray 		= [0,1,2,3,4];
			m_wApplyBlankTabel  = new Array();
			m_wAreaArray 		= Memory._newArrayAndSetValue(4,0);
			m_wJieSuanArray 	= Memory._newArrayAndSetValue(3,0);
			m_wCBCardOx 		= Memory._newArrayAndSetValue(5,0);
			lAreaWinner 		= Memory._newArrayAndSetValue(5,0);
			m_wTableChipArr 	= new Array();
			m_wlChipScore 		= Memory._newArrayAndSetValue(7,0);
			m_wWinAndLoase      = new Array();
			m_wGameRecord		= new Array();
			lAreaLimitScore     = Memory._newArrayAndSetValue(4,0);
			currentAreaLimit    = Memory._newArrayAndSetValue(4,0);
			
			m_lUserAreaWinScore	=	Memory._newArrayAndSetValue(4,0);
		}
	
		/**
		 * 开始发牌玩家View
		 **/
		public function FACardRectHandler(diceNumber:int):Array
		{
			m_wFACardArray.sort(Array.NUMERIC);
			var index : int = m_wFACardArray.indexOf(diceNumber%5);
			var tArrs : Array = Memory._newArrayByCopy(m_wFACardArray,index,0);
			if(index == 0)return tArrs;
			m_wFACardArray.splice(0,index);
			m_wFACardArray = m_wFACardArray.concat(tArrs);
			return  m_wFACardArray;
		}
		/**
		 *  更新玩家分数
		 **/
		public  function get UpdateUserScore():Number
		{
			var num : Number = m_wJieSuanArray[0] + m_wJieSuanArray[1];
			
			return Number(num);
		}
		override public function Destroy():Boolean
		{
			super.Destroy();
			m_lastGameEnd = null;
			m_wFACardArray 	= null;
			m_wApplyBlankTabel = null;
			m_wAreaArray 	= null;
			m_wJieSuanArray = null;
			m_wCBCardOx 	= null;
			lAreaWinner 	= null;
			m_wTableChipArr = null;
			m_wlChipScore 	= null;
			m_wWinAndLoase  = null;
			m_wGameRecord	= null;
			lAreaLimitScore = null;
			currentAreaLimit = null;
			
			_instance = null;
			
			return true;
		}
	}
}