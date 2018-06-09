package games.FiveStarBat.struct
{
	import flash.utils.ByteArray;
	
	import games.FiveStarBat.utils.ConstCmd;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONGLONG;

	public class CMD_S_StatusPlay
	{
		public var cbTimeLeave : uint;
		public var cbIsTryPlay : uint;
		public var lTryPlayScore : Number;
		public var lAreaLimitScore : Number;							//区域限制
		public var lAreaJetton : Array;
		public function CMD_S_StatusPlay()
		{
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_StatusPlay
		{
			var result : CMD_S_StatusPlay = new CMD_S_StatusPlay();
			result.cbTimeLeave = BYTE.read(bytes);
			result.cbIsTryPlay = BYTE.read(bytes);
			result.lTryPlayScore = LONGLONG.read(bytes);
			result.lAreaLimitScore = LONGLONG.read(bytes);
			for(var i : uint = 0 ; i < ConstCmd.AREA_COUNT;i++)
			{
				result.lAreaJetton[i] = LONGLONG.read(bytes);
			}
			return result;
		}
	}
}