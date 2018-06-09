package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.TCHAR;

	public class CMD_GP_Bank_TransferResult
	{
		
		public var lResultCode:int;						//结果代码
		public var lScore:int;								
		public var szDescribeMsg:String;					//描述信息

		
		public function CMD_GP_Bank_TransferResult()
		{
		}
		
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GP_Bank_TransferResult
		{
			var result : CMD_GP_Bank_TransferResult = new CMD_GP_Bank_TransferResult();
			
			result.lResultCode = BYTE.read(bytes);
			result.lScore = LONG.read(bytes);
			result.szDescribeMsg = TCHAR.read(bytes,128);
			
			return result;
		}
		
	}
}