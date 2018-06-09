package games.cowlord.model
{
	
	import games.cowlord.struct.tagServerGameRecord;
	
	import t.cx.air.controller.Controller;

	public class HistoryModel
	{
				
		private static var _instance : HistoryModel;
		public static function _getInstance() : HistoryModel
		{
			return _instance == null?(_instance = new HistoryModel()):_instance;
		}
		private var _historyVec : Vector.<tagServerGameRecord>;
		
		private var _tianWin : uint = 0;
		public function get xianWinCount() : uint
		{
			return _tianWin;
		}
		private var _diWin : uint = 0;
		public function get zhuangWinCount() : uint
		{
			return _diWin;
		}
		
		private var _xuanWin : uint = 0;
		public function get pingCount() : uint
		{
			return _xuanWin;
		}
		private var _huangWin : uint = 0;
		public function get xianDuiZiCount() : uint
		{
			return _huangWin;
		}
		
		
		
		public function HistoryModel()
		{
		}
		public function get HistoryCount() : uint
		{
			if( _historyVec==null ) return 0;
			return _historyVec.length;
		}
		public function InsertHistory(value : tagServerGameRecord) : void
		{
			if(_historyVec == null) 
			{
				_historyVec = new Vector.<tagServerGameRecord>();
			}
			if(value.m_bAreaAide[1] > 1)
			{
				_tianWin++;
			}
			else if(value.m_bAreaAide[2] > 1) 
			{
				_diWin++;
			}
			else if(value.m_bAreaAide[3] > 1) 
			{
				_xuanWin++;
			}
			else if(value.m_bAreaAide[4] > 1) 
			{
				_huangWin++;
			} 
			
			_historyVec.push(value);
			Controller.dispatchEvent('UPDATE_HISTORY',_historyVec.length-1,value);
		}
		public function GetHistoryByIndex(index : uint) : tagServerGameRecord
		{
			if(_historyVec == null) return null;
			if(index >= _historyVec.length ) return null;
			
			return _historyVec[index];
		}
	}
}