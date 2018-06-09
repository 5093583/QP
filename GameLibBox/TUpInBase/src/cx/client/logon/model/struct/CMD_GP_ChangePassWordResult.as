package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.TCHAR;

	public class CMD_GP_ChangePassWordResult
	{
		public static const SIZE : uint = 132;
		
		public var lResultCode : int;						//结果代码
		public var szDescribeMsg : String;					//描述信息

		public function CMD_GP_ChangePassWordResult()
		{
		}

		public static function _readBuffer(bytes : ByteArray) : CMD_GP_ChangePassWordResult
		{
			var result : CMD_GP_ChangePassWordResult = new CMD_GP_ChangePassWordResult();
			result.lResultCode = LONG.read(bytes);
			result.szDescribeMsg = TCHAR.read(bytes,128);
			
			return result;
		}
	}
}