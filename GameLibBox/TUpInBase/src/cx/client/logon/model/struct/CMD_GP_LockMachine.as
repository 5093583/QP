package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	public class CMD_GP_LockMachine
	{
		public var mUserID : uint;
		public var dwOper : uint;				//操作类型
		public var szPassword : String;			//银行密码
		public var szSerialNumber : String;		//机器码

		public function CMD_GP_LockMachine()
		{
			
		}
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			
			DWORD.write(mUserID,bytes);
			WORD.write(dwOper,bytes);
			TCHAR.write(szPassword,bytes,33);
			TCHAR.write(szSerialNumber,bytes,33);
			return bytes;
		}
		
		public function get size() : uint
		{
			return 72;
		}
	}
}