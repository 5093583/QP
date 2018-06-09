package games.dzlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;

	public class CMD_S_GiveUp
	{
		public static const SIZE:uint=10;
		public var wGiveUpUser:int;		//放弃用户
		public var lLost:Number;		//输掉金币
		public function CMD_S_GiveUp()
		{
			
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_GiveUp
		{
			var result :CMD_S_GiveUp=new CMD_S_GiveUp();
			result.wGiveUpUser=WORD.read(bytes);
			result.lLost=LONG.read(bytes);
			return result;
		}
		
	}
}