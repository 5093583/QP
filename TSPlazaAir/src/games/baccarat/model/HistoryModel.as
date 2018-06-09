package games.baccarat.model
{
	
	import games.baccarat.struct.tagServerGameRecord;
	
	import t.cx.air.controller.Controller;

	public class HistoryModel
	{
				
		private static var _instance : HistoryModel;
		public static function _getInstance() : HistoryModel
		{
			return _instance == null?(_instance = new HistoryModel()):_instance;
		}
		private var _historyVec : Vector.<tagServerGameRecord>;
		
		private var _xianWin : uint = 0;
		public function get xianWinCount() : uint
		{
			return _xianWin;
		}
		private var _zhuangWin : uint = 0;
		public function get zhuangWinCount() : uint
		{
			return _zhuangWin;
		}
		
		private var _ping : uint = 0;
		public function get pingCount() : uint
		{
			return _ping;
		}
		private var _xDuiZi : uint = 0;
		public function get xianDuiZiCount() : uint
		{
			return _xDuiZi;
		}
		private var _zDuiZi : uint = 0;
		public function get zhuangDuiZiCount() : uint
		{
			return _zDuiZi;
		}
		
		private var _xTW : uint = 0;
		public function get xianTW() : uint
		{
			return _xTW;
		}
		private var _zTW : uint = 0;
		public function get zhuangTW() : uint
		{
			return _zTW;
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
			if(_historyVec == null) {
				_historyVec = new Vector.<tagServerGameRecord>();
			}
			if(value.cbBankerCount > value.cbPlayerCount) {
				_zhuangWin++;
			}else if(value.cbBankerCount < value.cbPlayerCount) {
				_xianWin++;
			}else {
				_ping++;
			}
			if(value.bBankerTwoPair==1) {
				_zDuiZi++;
			}else if(value.bPlayerTwoPair == 1) {
				_xDuiZi++;
			}
			
			if(value.cbKingWinner == 4){
				_xTW++;
			}else if(value.cbKingWinner == 5) {
				_zTW++;	
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