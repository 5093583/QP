package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.TCHAR;

	public class CMD_GP_SaveMoneyResult
	{
		public static const SIZE : uint = 140;
		public var lResultCode : int;
		public var insureScore : int;
		public var lScore : int;
		public var szDescribeMsg : String;
		public function CMD_GP_SaveMoneyResult()
		{
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_GP_SaveMoneyResult
		{
			var result : CMD_GP_SaveMoneyResult = new CMD_GP_SaveMoneyResult();
			result.lResultCode 	= LONG.read(bytes);
			result.insureScore 	= LONG.read(bytes);
			result.lScore 		= LONG.read(bytes);
			result.szDescribeMsg = TCHAR.read(bytes,128);
			return result;
		}
	}
}