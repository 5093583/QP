package t.cx.cmd.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;
	

	public class tagDataDescribe
	{
		public static const SIZE : uint = 4;
		
		public var wDataSize : int;							//数据大小
		public var wDataDescribe : uint;					//数据描述

		public function tagDataDescribe()
		{
		}
		public static function _readBuffer(bytes : ByteArray) : tagDataDescribe
		{
			var result : tagDataDescribe = new tagDataDescribe();
			
			result.wDataSize = WORD.read(bytes);
			result.wDataDescribe = WORD.read(bytes);
			
			return result;
		}
		
		public function ToByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			
			WORD.write(wDataSize,bytes);
			WORD.write(wDataDescribe,bytes);
			return bytes;
		}
		
		public function get size() : uint
		{
			return 4;
		}
		
	}
}