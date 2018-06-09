package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;

	public class CMD_GP_Refurbish_result
	{
		public static const SIZE : uint = 6;
		
		public var lScore : uint;						//玩家金币
		public var lBankScore : uint;						//玩家金币
		public var wFaceID : uint;						//头像标识
		
		public function CMD_GP_Refurbish_result()
		{
			
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GP_Refurbish_result
		{
			var result : CMD_GP_Refurbish_result = new CMD_GP_Refurbish_result();
			
			result.lScore = LONG.read(bytes);
			result.lBankScore = LONG.read(bytes);
			result.wFaceID = WORD.read(bytes);
			
			return result;
		}
	}
}