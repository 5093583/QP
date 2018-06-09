package  cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.TConst;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.Memory;

	public class CMD_GP_CashMoney
	{
		public var mUserID : int;						//用户ID
		public var szPassword : String;					//玩家密码
		public var szBankPassword : String;				//银行密码
		public var insureScore : Number;				//取钱钱数

		public function CMD_GP_CashMoney()
		{
		}
		public function ToByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			DWORD.write(mUserID,bytes);
			TCHAR.write(szPassword,bytes,TConst.PASS_LEN);
			TCHAR.write(szBankPassword,bytes,TConst.PASS_LEN);
			LONG.write(insureScore,bytes);
			return bytes;
		}
		
		public function get size() : uint
		{
			return 74;
		}
	}
}