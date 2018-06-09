package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.Memory;

	public class CMD_GR_LogonByUserID
	{
		public const SIZE : uint = 	45;
		
		public var dwPlazaVersion : int;						//广场版本
		public var dwProcessVersion : int;						//进程版本
		public var dwUserID : Number;							//用户 I D
		public var szPassWord : String;							//登录密码
		public function CMD_GR_LogonByUserID()
		{
		}
		
		public function Write() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			DWORD.write(dwPlazaVersion,bytes);
			DWORD.write(dwProcessVersion,bytes);
			DWORD.write(dwUserID,bytes);
			TCHAR.write(szPassWord,bytes,33);
			return bytes;
		}
		
		
	}
}