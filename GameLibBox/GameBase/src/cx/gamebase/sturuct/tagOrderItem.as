package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;

	public class tagOrderItem
	{
		public static const SIZE : uint = 36;
		public var lScore : Number;							//等级积分
		public var wOrderDescribe : Array;						//等级描述
		public function tagOrderItem()
		{
			wOrderDescribe = new Array(16);
		}
		
		public static function _readBuffer(bytes : ByteArray) : tagOrderItem
		{
			var retsult : tagOrderItem = new tagOrderItem();
			retsult.lScore = LONG.read(bytes);
			for(var i : uint = 0;i<16;i++)
			{
				retsult.wOrderDescribe[i] = WORD.read(bytes);
			}
			return retsult;
		}
	}
}