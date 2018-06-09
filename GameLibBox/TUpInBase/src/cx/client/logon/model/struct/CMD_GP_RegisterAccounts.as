package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	public class CMD_GP_RegisterAccounts
	{
		public var wFaceID 		: uint;						//头像标识
		public var cbGender		: uint;						//用户性别
		public var dwPlazaVersion : int;					//广场版本
		
		public var szSpreader 	: String;					//推广人名
		public var szAccounts 	: String;					//登录帐号
		public var szPassWord 	: String;					//登录密码
		public var szPassWordBank : String;					//登录密码
		public var szUserName 	: String;					//用户姓名
		public var szQQ 		: String;					//用户QQ
		public var szEmail 		: String;					//用户Email

		public function CMD_GP_RegisterAccounts()
		{
		}
		
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			WORD.write(wFaceID,bytes);
			BYTE.write(cbGender,bytes);
			DWORD.write(dwPlazaVersion,bytes);
			
			TCHAR.write(szSpreader,bytes,32);
			TCHAR.write(szAccounts,bytes,32);
			TCHAR.write(szPassWord,bytes,33);
			TCHAR.write(szPassWordBank,bytes,33);
			TCHAR.write(szUserName,bytes,16);
			TCHAR.write(szQQ,bytes,16);
			TCHAR.write(szEmail,bytes,32);
			
			return bytes;
		}
		public function get size() : uint
		{
			return 201;
		}
	}
}