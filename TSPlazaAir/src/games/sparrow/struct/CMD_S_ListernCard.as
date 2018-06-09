package games.sparrow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;

	public class CMD_S_ListernCard
	{
		public var wListernCardUser : int;
		////////////bRealy根据此值去执行动画
		public var bRealy : uint;
		public var wHuCards			: Array;
		public function CMD_S_ListernCard()
		{
			
		}
		
		public static function _readBuffer(pBuffer : ByteArray) : CMD_S_ListernCard
		{
			var result : CMD_S_ListernCard = new CMD_S_ListernCard();
			
			result.wListernCardUser = WORD.read(pBuffer);
			result.bRealy = BYTE.read(pBuffer);
			result.wHuCards = new Array(34);
			for(var i : uint = 0;i<34;i++)
			{
				result.wHuCards[i] = BYTE.read(pBuffer);
			}
			return result;
		}
	}
}