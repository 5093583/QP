package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.TConst;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.Memory;
	
	public class CMD_GP_SaveMoney
	{
		public var mUserID : int;
		public var szPassword : String;
		public var insureScore : Number;
		public function CMD_GP_SaveMoney()
		{
		}
		public function ToByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			DWORD.write(mUserID,bytes);
			TCHAR.write(szPassword,bytes, TConst.PASS_LEN);
			LONG.write(insureScore,bytes);
			return bytes;
		}
		public function get size() :uint
		{
			return 41;
		}
	}
}