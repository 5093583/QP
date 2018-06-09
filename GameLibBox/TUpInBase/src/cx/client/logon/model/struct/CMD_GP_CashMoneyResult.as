package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.TCHAR;

	public class CMD_GP_CashMoneyResult
	{
		public var lResultCode : int;							//结果代码
		public var insureScore : Number;						//当前银行钱数
		public var lScore : Number;								//当前身上钱数
		public var szDescribeMsg : String;						//描述信息

		public function CMD_GP_CashMoneyResult()
		{
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_GP_CashMoneyResult
		{
			var result : CMD_GP_CashMoneyResult = new CMD_GP_CashMoneyResult();
			result.lResultCode 	= LONG.read(bytes);
			result.insureScore 	= LONG.read(bytes);
			result.lScore 		= LONG.read(bytes);
			result.szDescribeMsg = TCHAR.read(bytes,128);
			return result;
		}
	}
}