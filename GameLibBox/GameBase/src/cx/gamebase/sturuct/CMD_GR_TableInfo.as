package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.WORD;
	
	public class CMD_GR_TableInfo
	{
		public static const SIZE : uint = 1026;
		public var wTableCount : int;						//桌子数目
		public var TableStatus : Array;					//状态数组
		public function CMD_GR_TableInfo()
		{
			TableStatus = new Array();
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GR_TableInfo
		{
			var result : CMD_GR_TableInfo = new CMD_GR_TableInfo();
			result.wTableCount = WORD.read(bytes);
			
			for(var i : uint = 0;i<result.wTableCount;i++)
			{
				var tableInfo : tagTableStatus = tagTableStatus._readBuffer(bytes);
				result.TableStatus.push(tableInfo);
			}
			
			return result;
		}
	}
}