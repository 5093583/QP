package cx.admin
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.Memory;

	public class CMD_GF_AideKick
	{
		public var dwKickUser : int;
		public function CMD_GF_AideKick()
		{
			
		}
		public function ToByteArray() : ByteArray
		{
			var result : ByteArray = Memory._newLiEndianBytes();
			DWORD.write(dwKickUser,result);
			return result;
		}
		
		public function get size() : uint
		{
			return 4;
		}
	}
}