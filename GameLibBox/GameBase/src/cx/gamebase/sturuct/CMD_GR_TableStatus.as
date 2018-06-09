package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;

	public class CMD_GR_TableStatus
	{
		public static const SIZE : uint = 4;
		
		public var wTableID : int;							//桌子号码
		public var bTableLock : uint;						//锁定状态
		public var bPlayStatus : uint;						//游戏状态
		
		
		public var szTableNum:String;					//牌局号	szTableNum[19];
		
		
		public function CMD_GR_TableStatus()
		{
			
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GR_TableStatus
		{
			var result : CMD_GR_TableStatus = new CMD_GR_TableStatus();
			
			result.wTableID 	= WORD.read(bytes);
			result.bPlayStatus  = BYTE.read(bytes);
			result.bTableLock 	= BYTE.read(bytes);
			
			result.szTableNum	= TCHAR.read(bytes, 19); 
			
			return result;
		}
	}
}