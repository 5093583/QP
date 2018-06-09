package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.TConst;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.Memory;
	
	public class CMD_GP_ChangePassWord
	{
		public var mUserID : int;					//用户ID
		public var szPassword : String;				//玩家密码
		public var szBankPassword : String;			//当前银行密码
		public var szChangePassword : String;			//修改密码

		public function CMD_GP_ChangePassWord()
		{
		}
		public function ToByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			
			DWORD.write(mUserID,bytes);
			TCHAR.write(szPassword,bytes,TConst.PASS_LEN);
			TCHAR.write(szBankPassword,bytes,TConst.PASS_LEN);
			TCHAR.write(szChangePassword,bytes,TConst.PASS_LEN);
			
			return bytes;
		}
		public function get size() : uint
		{
			return 103;
		}
	}
}