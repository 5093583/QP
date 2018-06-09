package games.dzlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;

	public class CMD_S_StatusFree
	{
		public static const SIZE:uint=10;
		public var lCellMinScore:Number;
		public var lCellMaxScore:Number;
		public var cbIsTryPlay:uint;
		public var lTryPlayScore:Number;
		
		public function CMD_S_StatusFree()
		{
			
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_StatusFree{
			
			var result:CMD_S_StatusFree= new CMD_S_StatusFree();
			result.lCellMinScore=LONG.read(bytes);
			result.lCellMaxScore=LONG.read(bytes);	
			result.cbIsTryPlay = BYTE.read(bytes);
			result.lTryPlayScore = LONG.read(bytes);
			return result;
			
		}
	}
}