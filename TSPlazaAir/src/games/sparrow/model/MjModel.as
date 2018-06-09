package games.sparrow.model
{
	import games.sparrow.struct.tagWeaveItem;
	import games.sparrow.utils.GameLogic;
	import cx.gamebase.model.GlobalModel;
	
	import t.cx.air.TConst;
	import t.cx.air.utils.Memory;
	
	public class MjModel extends GlobalModel
	{
		public static function MjInstance() : MjModel
		{
			return _instance == null ? (_instance = new MjModel()) : _instance;
		}
		public var m_Logic 			: GameLogic;
		
		public var m_lCellScore 	: Number;
		public var m_wBankerViewID	: uint;
		public var m_cbCardIndex 	: Array;
		public var m_cbNewCard 		: int;
		public var m_wCurrentUser	: uint;
		
		public var m_cbTing			: uint;
		public var m_cbTing2		: uint;
		public var m_cbTingHuCard	: Array;		//听啤
		public var m_cbTingOutCard	: Array;		//听啤
		
		public var m_WeaveItemArray : Array;		//麻将组合牌
		public var m_cbWeaveCount 	: Array;		//组合牌数目
		
		public var m_cbHuCardIndex	: int;
		public var m_Truestee		: Array;
		
		public var m_bFirstCard		: Boolean;
		public var m_TruesteeLock	: Boolean;
		public function MjModel()
		{
			super();
			m_Logic				= GameLogic.getInstance();
			m_wCurrentUser		= TConst.INVALID_CHAIR;
			m_lCellScore 		= 0;
			m_wBankerViewID		= 0;
			m_cbTing			= 0;
			m_cbTing2			= 0;
			m_cbNewCard			= 255;
			m_cbTingHuCard		= new Array();
			m_cbTingOutCard		= Memory._newArrayAndSetValue(34,255);
			m_cbHuCardIndex		= 0;
			m_cbCardIndex		= Memory._newArrayAndSetValue(42,0);
			m_cbWeaveCount 		= Memory._newArrayAndSetValue(2,0);
			m_WeaveItemArray 	= Memory._newTwoDimension(2,4);
			for(var i : uint = 0;i<2;i++) 
			{ 
				for(var j : uint = 0;j<4;j++) { m_WeaveItemArray[i][j] = new tagWeaveItem();  }
			}
			m_Truestee 			= Memory._newArrayAndSetValue(2,0);
			m_bFirstCard		= false;
			m_TruesteeLock		= false;
		}
		
		override public function Destroy():Boolean
		{
			super.Destroy();
			
			m_lCellScore 		= NaN;
			m_cbCardIndex 		= null;
			m_Logic 			= null;
			
			m_cbTingHuCard 		= null;
			m_cbTingOutCard 	= null;
			
			m_cbWeaveCount 		= null;
			m_WeaveItemArray 	= null;
			m_Truestee			= null;
			
			_instance = null;
			
			return true;
		}
	}
}