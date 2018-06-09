package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_GF_Info
	{
		public var bAllowLookon : uint;					//旁观标志
		public function CMD_GF_Info()
		{
		}
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray =  Memory._newLiEndianBytes();
			BYTE.write(bAllowLookon,bytes);
			return bytes;
		}
		public function get size() : uint
		{
			return 1;
		}
	}
}