package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.TConst;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.Memory;

	public class CMD_GP_LogonByAccounts
	{
		public var dwPlazaVersion : Number;		//广场版本
		public var szAccounts : String;			//登录帐号
		public var szPassWord : String;			//登录密码
		
		public function CMD_GP_LogonByAccounts()
		{
			
		}
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			DWORD.write(dwPlazaVersion,bytes);
			TCHAR.write(szAccounts,bytes,TConst.NAME_LEN);
			TCHAR.write(szPassWord,bytes,TConst.PASS_LEN);
			return bytes;
		}
		
		public function get size() : uint
		{
			return 69;
		}
	}
}