package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;

	public class CMD_GP_ListConfig
	{
		public var bShowOnLineCount : uint;		//显示人数
		public var cbRadixPoint : uint;			//当前平台小数点后位数				
		public function CMD_GP_ListConfig()
		{
		}
		
		public static function OnReadByteArray(bytes : ByteArray) : CMD_GP_ListConfig
		{
			var result : CMD_GP_ListConfig = new CMD_GP_ListConfig();
			result.bShowOnLineCount = BYTE.read(bytes);
			result.cbRadixPoint = BYTE.read(bytes);
			return result;
		}
	}
}