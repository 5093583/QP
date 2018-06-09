package games.zjh.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	/**
	 * ...
	 * @author xf
	 * 用户加注
	 */
	public class CMD_C_AddScore 
	{
		public var lScore : Number;								//加注数目
		public var wState : int;								//当前状态
		public function CMD_C_AddScore() 
		{
			
		}
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			LONG.write(lScore, bytes);
			WORD.write(wState, bytes);
			return bytes;
		}
		public function get size() : uint
		{
			return 6;
		}
	}

}