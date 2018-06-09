package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.TCHAR;

	public class CMD_GR_SitFailed
	{
		public var szFailedDescribe : String;				//错误描述
		public function CMD_GR_SitFailed()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GR_SitFailed
		{
			var result : CMD_GR_SitFailed = new  CMD_GR_SitFailed();
			result.szFailedDescribe = TCHAR.read(bytes,256);
			return result;
		}
	}
}