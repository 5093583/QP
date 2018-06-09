package games.gswz.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.Memory;

	/**
	 * ...
	 * @author xf
	 * 用户加注
	 */
	public class CMD_C_AddScore 
	{
		public var lScore		: Number;		//加注数目
		public var cbControlType	: uint;		//操作类型
		public function CMD_C_AddScore() 
		{
		}
		public function toByteArray():ByteArray
		{
			var bytes :ByteArray = Memory._newLiEndianBytes();
			LONG.write(lScore, bytes);
			BYTE.write(cbControlType,bytes);
			return bytes;
		}
		public function get size() :uint
		{
			return 5;
		}
		
	}

}