package t.cx.cmd.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.TConst;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;
	
	public class tagGameStation
	{
		public static const SIZE : int = 40;
		public var wSortID : int;							//排序号码
		public var wKindID : int;							//名称号码
		public var wJoinID : int;							//挂接号码
		public var wStationID : int;						//站点号码
		public var szStationName : String;					//站点名称
		public function tagGameStation()
		{
			
		}
		public static function _readByteArray(bytes : ByteArray) : tagGameStation
		{
			var result : tagGameStation = new tagGameStation();
			result.wSortID 		= WORD.read(bytes);
			result.wKindID 		= WORD.read(bytes);
			result.wJoinID 		= WORD.read(bytes);
			result.wStationID 	= WORD.read(bytes);
			
			result.szStationName = TCHAR.read(bytes,TConst.STATION_LEN);
			return result;
		}
	}
}