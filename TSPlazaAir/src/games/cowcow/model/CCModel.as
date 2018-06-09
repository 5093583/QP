package games.cowcow.model
{
	import cx.gamebase.model.GlobalModel;
	
	import games.cowcow.struct.CMD_S_GameEnd;
	
	import t.cx.air.utils.Memory;
	
	public class CCModel extends GlobalModel
	{
		public var m_PlayerInfo : Array;
		public var m_lTurnLessScore : Number;
		public var m_lTotalScore : Number;
		
		public var m_Banker : uint;
		public var m_RecordArrs : Array;
		public var m_RecordOX	: Array;
		public var m_upperLimit : Number;
		
		
		public var m_gameStart:Boolean = false;
		
		
		[Bindable]
		public var m_defaultChip : Number
		
		public var m_zhuangArray:Array;			////存玩家坐庄标识
		public static function _getInstance() : CCModel
		{
			return _instance == null ? (_instance = new CCModel()) : _instance;
		}
		public function CCModel()
		{
			super();
			m_PlayerInfo = Memory._newArrayAndSetValue(4,0);
			m_RecordOX = Memory._newArrayAndSetValue(4,0xff);
			m_lTurnLessScore = 0;
			m_lTotalScore = 0;
			m_upperLimit = 0;
			m_defaultChip = 100;
			m_zhuangArray = Memory._newArrayAndSetValue(4,0);
		}
		public function RecordOpenCard(wViewChairID : uint,type : uint,arrs : Array) : void
		{
			if(m_RecordArrs == null)m_RecordArrs = Memory._newTwoDimension(4,5,0);
			m_RecordOX[wViewChairID] = type;
			for(var i : uint = 0;i<5;i++)
			{
				m_RecordArrs[wViewChairID][i] = arrs[i];
			}
		}
		
		override public function Destroy():Boolean
		{
			super.Destroy();
			m_RecordArrs = null;
			m_RecordOX = null;
			m_PlayerInfo = null;
			
			_instance = null;
			m_zhuangArray = null;
			return true;
		}
	}
}