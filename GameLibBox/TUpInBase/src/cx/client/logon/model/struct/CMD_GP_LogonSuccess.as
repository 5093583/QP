package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;
	
	public class CMD_GP_LogonSuccess
	{
		public static const SIZE : int = WORD.size + BYTE.size + BYTE.size + DWORD.size + DWORD.size + LONG.size + LONG.size + BYTE.size ;
		public var wFaceID	: int;							//头像索引
		public var cbGender : uint;							//用户性别
		public var cbMember : uint;							//会员等级
		public var dwUserID : Number;						//用户 I D
		public var dwExperience : Number;					//用户经验
		public var lScore : Number;							//用户金币
		public var lBankScore : Number;						//银行金币
		//扩展信息
		public var cbMoorStatus : uint;						//锁机状态
		
		public function CMD_GP_LogonSuccess()
		{
		}
		public static function OnReadByteArray(bytes : ByteArray) : CMD_GP_LogonSuccess
		{
			var result : CMD_GP_LogonSuccess = new CMD_GP_LogonSuccess();
			result.wFaceID = WORD.read(bytes);
			result.cbGender = BYTE.read(bytes);
			result.cbMember = BYTE.read(bytes);
			result.dwUserID = DWORD.read(bytes);
			result.dwExperience = DWORD.read(bytes);
			result.lScore = LONG.read(bytes);
			result.lBankScore = LONG.read(bytes);
			result.cbMoorStatus = BYTE.read(bytes);
			return result;
		}
	}
}