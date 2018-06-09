package games.cowcow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.Memory;

	/**
	 * ...
	 * @author xf
	 * 用户加注
	 */
	public class CMD_C_AddScore 
	{
		public var lScore : Number;					//加注数目
		public function CMD_C_AddScore() 
		{
			
		}
		public function toByArray(): ByteArray
		{
			var bytes :ByteArray = Memory._newLiEndianBytes();
			LONG.write(lScore, bytes);
			return bytes;
		}
		public function get size():uint
		{
			return 4;
		}
	}

}