package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.TCHAR;

	public class CMD_GP_LockMachineResult
	{
		public static const SIZE : uint = 132;
		public var lResultCode : int;					//结果代码
		public var szErrorDescribe : String;			//错误消息

		public function CMD_GP_LockMachineResult()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GP_LockMachineResult
		{
			var result : CMD_GP_LockMachineResult = new CMD_GP_LockMachineResult();
			result.lResultCode 		= LONG.read(bytes);
			result.szErrorDescribe 	= TCHAR.read(bytes,128);
			return result;
		}
	}
}